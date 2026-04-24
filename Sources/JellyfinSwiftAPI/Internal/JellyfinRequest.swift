import Foundation

internal enum JellyfinHTTPMethod: String, Sendable {
    case delete = "DELETE"
    case get = "GET"
    case head = "HEAD"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
}

internal enum JellyfinRequestBody: Sendable {
    case json(Data)
    case raw(Data, contentType: String)

    internal var data: Data {
        switch self {
        case let .json(data), let .raw(data, _):
            return data
        }
    }

    internal var contentType: String {
        switch self {
        case .json:
            return "application/json"
        case let .raw(_, contentType):
            return contentType
        }
    }
}

internal struct JellyfinRequest: Sendable {
    internal let path: String
    internal var method: JellyfinHTTPMethod
    internal var queryItems: [URLQueryItem]
    internal var headers: [String: String]
    internal var body: JellyfinRequestBody?
    internal var requiresAuthorization: Bool

    internal init(
        path: String,
        method: JellyfinHTTPMethod = .get,
        queryItems: [URLQueryItem] = [],
        headers: [String: String] = [:],
        body: JellyfinRequestBody? = nil,
        requiresAuthorization: Bool = true
    ) {
        self.path = path
        self.method = method
        self.queryItems = queryItems
        self.headers = headers
        self.body = body
        self.requiresAuthorization = requiresAuthorization
    }
}
