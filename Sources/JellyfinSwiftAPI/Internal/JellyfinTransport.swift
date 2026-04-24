import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

internal protocol JellyfinTransporting: Sendable {
    func data(for request: URLRequest) async throws -> JellyfinTransportResponse
}

internal struct JellyfinTransportResponse: Sendable {
    internal let data: Data
    internal let response: HTTPURLResponse
}

internal actor JellyfinTransport: JellyfinTransporting {
    private let session: URLSession

    internal init(session: URLSession) {
        self.session = session
    }

    internal func data(for request: URLRequest) async throws -> JellyfinTransportResponse {
        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw JellyfinRequestExecutionError.invalidResponse
        }

        return JellyfinTransportResponse(data: data, response: httpResponse)
    }
}
