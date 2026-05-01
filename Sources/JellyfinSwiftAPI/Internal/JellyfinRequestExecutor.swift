import Foundation

internal struct JellyfinRawResponse: Sendable, Equatable {
    internal let data: Data
    internal let mimeType: String?
    internal let statusCode: Int
}

internal enum JellyfinRequestExecutionError: Error, Equatable {
    case invalidURL(String)
    case invalidResponse
    case missingAuthenticationToken
    case unexpectedStatusCode(Int, Data)
}

internal struct JellyfinRequestExecutor: Sendable {
    private let serverURL: URL
    private let clientInfo: JellyfinClientInfo
    private let authorization: JellyfinAuthorization
    private let transport: any JellyfinTransporting

    internal init(
        serverURL: URL,
        clientInfo: JellyfinClientInfo,
        authorization: JellyfinAuthorization,
        transport: any JellyfinTransporting
    ) {
        self.serverURL = serverURL
        self.clientInfo = clientInfo
        self.authorization = authorization
        self.transport = transport
    }

    internal func executeJSON<Response: Decodable>(
        _ responseType: Response.Type,
        for request: JellyfinRequest
    ) async throws -> Response {
        let response = try await perform(request)
        return try JellyfinJSONCoder.decoder().decode(Response.self, from: response.data)
    }

    internal func executeData(for request: JellyfinRequest) async throws -> JellyfinRawResponse {
        let response = try await perform(request)
        return JellyfinRawResponse(
            data: response.data,
            mimeType: response.response.value(forHTTPHeaderField: "Content-Type"),
            statusCode: response.response.statusCode
        )
    }

    internal func executeString(for request: JellyfinRequest) async throws -> String {
        let response = try await perform(request)

        guard !response.data.isEmpty else {
            return ""
        }

        return String(decoding: response.data, as: UTF8.self)
    }

    internal func executeEmpty(for request: JellyfinRequest) async throws {
        _ = try await perform(request)
    }

    private func perform(_ request: JellyfinRequest) async throws -> JellyfinTransportResponse {
        let urlRequest = try buildURLRequest(for: request)
        JellyfinDebugLogger.logRequest(urlRequest)

        let transportResponse: JellyfinTransportResponse
        do {
            transportResponse = try await transport.data(for: urlRequest)
        } catch {
            JellyfinDebugLogger.logError(error, for: urlRequest)
            throw error
        }

        JellyfinDebugLogger.logResponse(transportResponse, for: urlRequest)

        guard (200 ..< 300).contains(transportResponse.response.statusCode) else {
            throw JellyfinRequestExecutionError.unexpectedStatusCode(
                transportResponse.response.statusCode,
                transportResponse.data
            )
        }

        return transportResponse
    }

    private func buildURLRequest(for request: JellyfinRequest) throws -> URLRequest {
        let url = try makeURL(path: request.path, queryItems: request.queryItems)
        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = request.method.rawValue
        urlRequest.setValue(try authorizationHeaderValue(for: request), forHTTPHeaderField: "Authorization")

        for (field, value) in request.headers {
            urlRequest.setValue(value, forHTTPHeaderField: field)
        }

        if let body = request.body {
            urlRequest.httpBody = body.data
            urlRequest.setValue(body.contentType, forHTTPHeaderField: "Content-Type")
        }

        return urlRequest
    }

    private func authorizationHeaderValue(for request: JellyfinRequest) throws -> String {
        let token: String?

        if request.requiresAuthentication {
            guard let authenticationToken = authorization.token else {
                throw JellyfinRequestExecutionError.missingAuthenticationToken
            }
            token = authenticationToken
        } else {
            token = nil
        }

        return clientInfo.authorizationHeaderValue(token: token)
    }

    private func makeURL(path: String, queryItems: [URLQueryItem]) throws -> URL {
        let trimmedPath = path.hasPrefix("/") ? String(path.dropFirst()) : path
        let baseURL = serverURL.appendingPathComponent(trimmedPath)

        guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) else {
            throw JellyfinRequestExecutionError.invalidURL(path)
        }

        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }

        guard let url = components.url else {
            throw JellyfinRequestExecutionError.invalidURL(path)
        }

        return url
    }
}
