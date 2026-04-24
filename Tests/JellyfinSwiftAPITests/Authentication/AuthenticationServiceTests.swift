import Foundation
import XCTest
@testable import JellyfinSwiftAPI

final class AuthenticationServiceTests: XCTestCase {
    func testAuthenticateBuildsPublicPostRequest() async throws {
        let responseData = try FixtureLoader.data(service: "Authentication", named: "authentication-result")
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: responseData,
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200)
            )
        }
        let service = makeAuthenticationService(transport: transport)

        let result = try await service.authenticate(username: "demo", password: "secret")

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.url?.absoluteString, "https://jellyfin.example.com/Users/AuthenticateByName")
        XCTAssertNil(request.value(forHTTPHeaderField: "Authorization"))
        XCTAssertEqual(result.accessToken, "demo-token")
        let bodyString = try XCTUnwrap(String(data: try XCTUnwrap(request.httpBody), encoding: .utf8))
        XCTAssertTrue(bodyString.contains(#""Username":"demo""#))
        XCTAssertTrue(bodyString.contains(#""Pw":"secret""#))
    }

    func testQuickConnectEnabledUsesPublicEndpoint() async throws {
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: Data("true".utf8),
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200)
            )
        }
        let service = makeAuthenticationService(transport: transport)

        let enabled = try await service.quickConnectEnabled()

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(request.url?.absoluteString, "https://jellyfin.example.com/QuickConnect/Enabled")
        XCTAssertTrue(enabled)
    }

    func testAuthorizeQuickConnectUsesAuthorizationAndQueryItems() async throws {
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: Data(),
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 204)
            )
        }
        let service = makeAuthenticationService(
            authorization: .header("MediaBrowser Token=test-token"),
            transport: transport
        )
        let userID = UUID(uuidString: "5F6D5A13-4B25-4F8D-B9FB-A3B4699EF001")!

        try await service.authorizeQuickConnect(code: "ABCD", userID: userID)

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.value(forHTTPHeaderField: "Authorization"), "MediaBrowser Token=test-token")
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/QuickConnect/Authorize?code=ABCD&userId=5F6D5A13-4B25-4F8D-B9FB-A3B4699EF001"
        )
    }
}

private func makeAuthenticationService(
    authorization: JellyfinAuthorization = .none,
    transport: any JellyfinTransporting
) -> AuthenticationServiceClient {
    AuthenticationServiceClient(executor: makeTestExecutor(authorization: authorization, transport: transport))
}
