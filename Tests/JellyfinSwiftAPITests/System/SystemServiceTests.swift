import Foundation
import XCTest
@testable import JellyfinSwiftAPI

final class SystemServiceTests: XCTestCase {
    func testPublicSystemInfoUsesPublicEndpointWithoutAuthorization() async throws {
        let responseData = try FixtureLoader.data(service: "System", named: "public-info")
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: responseData,
                response: makeHTTPResponse(
                    url: try XCTUnwrap(request.url),
                    statusCode: 200,
                    headers: ["Content-Type": "application/json"]
                )
            )
        }
        let service = makeSystemService(transport: transport)

        let info = try await service.publicSystemInfo()

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(request.url?.absoluteString, "https://jellyfin.example.com/System/Info/Public")
        XCTAssertNil(request.value(forHTTPHeaderField: "Authorization"))
        XCTAssertEqual(info.serverName, "Jellyfin Demo")
    }

    func testSystemInfoUsesAuthorizationAndDecodesFixture() async throws {
        let responseData = try FixtureLoader.data(service: "System", named: "system-info")
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: responseData,
                response: makeHTTPResponse(
                    url: try XCTUnwrap(request.url),
                    statusCode: 200,
                    headers: ["Content-Type": "application/json"]
                )
            )
        }
        let service = makeSystemService(
            authorization: .header("MediaBrowser Token=test-token"),
            transport: transport
        )

        let info = try await service.systemInfo()

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(request.value(forHTTPHeaderField: "Authorization"), "MediaBrowser Token=test-token")
        XCTAssertEqual(info.webSocketPortNumber, 8096)
    }

    func testServerLogsDecodesFixtureArray() async throws {
        let responseData = try FixtureLoader.data(service: "System", named: "server-logs")
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: responseData,
                response: makeHTTPResponse(
                    url: try XCTUnwrap(request.url),
                    statusCode: 200,
                    headers: ["Content-Type": "application/json"]
                )
            )
        }
        let service = makeSystemService(
            authorization: .header("MediaBrowser Token=test-token"),
            transport: transport
        )

        let logs = try await service.serverLogs()

        XCTAssertEqual(logs.count, 2)
        XCTAssertEqual(logs.last?.name, "log_20260423.log")
    }

    func testBrandingCSSReturnsText() async throws {
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: "body { color: white; }".data(using: .utf8) ?? Data(),
                response: makeHTTPResponse(
                    url: try XCTUnwrap(request.url),
                    statusCode: 200,
                    headers: ["Content-Type": "text/css"]
                )
            )
        }
        let service = makeSystemService(transport: transport)

        let css = try await service.brandingCSS()

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(request.url?.absoluteString, "https://jellyfin.example.com/Branding/Css")
        XCTAssertEqual(css, "body { color: white; }")
    }

    func testRestartUsesPostRequest() async throws {
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: Data(),
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 204)
            )
        }
        let service = makeSystemService(
            authorization: .header("MediaBrowser Token=test-token"),
            transport: transport
        )

        try await service.restart()

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.url?.absoluteString, "https://jellyfin.example.com/System/Restart")
    }
}

private func makeSystemService(
    authorization: JellyfinAuthorization = .none,
    transport: any JellyfinTransporting
) -> SystemServiceClient {
    let executor = makeTestExecutor(authorization: authorization, transport: transport)
    return SystemServiceClient(executor: executor)
}
