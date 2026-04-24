import Foundation
import XCTest
@testable import JellyfinSwiftAPI

final class JellyfinRequestExecutorTests: XCTestCase {
    func testAuthenticatedRequestAddsAuthorizationHeader() async throws {
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: Data(),
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 204)
            )
        }
        let executor = makeTestExecutor(
            authorization: .header("MediaBrowser Token=test-token"),
            transport: transport
        )

        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/System/Info",
                queryItems: [URLQueryItem(name: "include", value: "storage")]
            )
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(
            request.value(forHTTPHeaderField: "Authorization"),
            "MediaBrowser Token=test-token"
        )
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/System/Info?include=storage"
        )
    }

    func testPublicRequestSkipsAuthorization() async throws {
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: Data(),
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 204)
            )
        }
        let executor = makeTestExecutor(transport: transport)

        try await executor.executeEmpty(
            for: JellyfinRequest(path: "/System/Info/Public", requiresAuthorization: false)
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertNil(request.value(forHTTPHeaderField: "Authorization"))
    }

    func testMissingAuthorizationFailsBeforeTransport() async throws {
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: Data(),
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 204)
            )
        }
        let executor = makeTestExecutor(transport: transport)

        do {
            try await executor.executeEmpty(for: JellyfinRequest(path: "/System/Info"))
            XCTFail("Expected missing authorization error")
        } catch let error as JellyfinRequestExecutionError {
            XCTAssertEqual(error, .missingAuthorization)
        }

        let requestCount = await transport.requestCount()
        XCTAssertEqual(requestCount, 0)
    }

    func testExecuteJSONDecodesResponse() async throws {
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: #"{"serverName":"Jellyfin Demo"}"#.data(using: .utf8) ?? Data(),
                response: makeHTTPResponse(
                    url: try XCTUnwrap(request.url),
                    statusCode: 200,
                    headers: ["Content-Type": "application/json"]
                )
            )
        }
        let executor = makeTestExecutor(transport: transport)

        let decoded = try await executor.executeJSON(
            PublicSystemInfoResponse.self,
            for: JellyfinRequest(path: "/System/Info/Public", requiresAuthorization: false)
        )

        XCTAssertEqual(decoded, PublicSystemInfoResponse(serverName: "Jellyfin Demo"))
    }

    func testExecuteDataReturnsRawPayloadMetadata() async throws {
        let pngData = Data([0x89, 0x50, 0x4E, 0x47])
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: pngData,
                response: makeHTTPResponse(
                    url: try XCTUnwrap(request.url),
                    statusCode: 200,
                    headers: ["Content-Type": "image/png"]
                )
            )
        }
        let executor = makeTestExecutor(transport: transport)

        let response = try await executor.executeData(
            for: JellyfinRequest(path: "/Items/1/Images/Primary", requiresAuthorization: false)
        )

        XCTAssertEqual(response.data, pngData)
        XCTAssertEqual(response.mimeType, "image/png")
        XCTAssertEqual(response.statusCode, 200)
    }

    func testRequestBodyAndHeadersAreAttachedToPostRequests() async throws {
        let body = #"{"Name":"Favorites"}"#.data(using: .utf8) ?? Data()
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: Data(),
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 204)
            )
        }
        let executor = makeTestExecutor(
            authorization: .header("MediaBrowser Token=test-token"),
            transport: transport
        )

        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Playlists",
                method: .post,
                headers: ["X-Test": "enabled"],
                body: .json(body)
            )
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.httpBody, body)
        XCTAssertEqual(request.value(forHTTPHeaderField: "Content-Type"), "application/json")
        XCTAssertEqual(request.value(forHTTPHeaderField: "X-Test"), "enabled")
    }

    func testHeadRequestsPreserveMethod() async throws {
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: Data(),
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200)
            )
        }
        let executor = makeTestExecutor(transport: transport)

        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Videos/1/stream",
                method: .head,
                requiresAuthorization: false
            )
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(request.httpMethod, "HEAD")
    }
}

private struct PublicSystemInfoResponse: Decodable, Equatable {
    let serverName: String

    private enum CodingKeys: String, CodingKey {
        case serverName = "serverName"
    }
}
