import XCTest
@testable import JellyfinSwiftAPI

final class AuthenticationServiceFixtureTests: XCTestCase {
    func testAuthenticationResultFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "Authentication", named: "authentication-result")
        let decoded = try JellyfinJSONCoder.decoder().decode(AuthenticationResult.self, from: data)

        XCTAssertEqual(decoded.accessToken, "demo-token")
        XCTAssertEqual(decoded.user?.name, "demo")
        XCTAssertEqual(decoded.sessionInfo?.deviceName, "iPhone")
    }

    func testQuickConnectFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "Authentication", named: "quick-connect")
        let decoded = try JellyfinJSONCoder.decoder().decode(QuickConnectResult.self, from: data)

        XCTAssertEqual(decoded.code, "ABCD")
        XCTAssertFalse(decoded.authenticated)
    }

    func testPublicUsersFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "Authentication", named: "public-users")
        let decoded = try JellyfinJSONCoder.decoder().decode([User].self, from: data)

        XCTAssertEqual(decoded.count, 1)
        XCTAssertEqual(decoded.first?.name, "demo")
    }
}
