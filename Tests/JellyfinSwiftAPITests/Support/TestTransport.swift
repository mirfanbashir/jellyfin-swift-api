import Foundation
@testable import JellyfinSwiftAPI

actor TestTransport: JellyfinTransporting {
    private let handler: @Sendable (URLRequest) throws -> JellyfinTransportResponse
    private var requests: [URLRequest] = []

    init(handler: @escaping @Sendable (URLRequest) throws -> JellyfinTransportResponse) {
        self.handler = handler
    }

    func data(for request: URLRequest) async throws -> JellyfinTransportResponse {
        requests.append(request)
        return try handler(request)
    }

    func lastRequest() -> URLRequest? {
        requests.last
    }

    func requestCount() -> Int {
        requests.count
    }
}

func makeTestExecutor(
    authorization: JellyfinAuthorization = .none,
    transport: any JellyfinTransporting
) -> JellyfinRequestExecutor {
    JellyfinRequestExecutor(
        serverURL: URL(string: "https://jellyfin.example.com") ?? URL(fileURLWithPath: "/"),
        authorization: authorization,
        transport: transport
    )
}

func makeHTTPResponse(
    url: URL,
    statusCode: Int,
    headers: [String: String] = [:]
) -> HTTPURLResponse {
    HTTPURLResponse(
        url: url,
        statusCode: statusCode,
        httpVersion: nil,
        headerFields: headers
    ) ?? HTTPURLResponse()
}
