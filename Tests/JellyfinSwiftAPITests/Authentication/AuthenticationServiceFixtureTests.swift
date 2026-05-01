import XCTest
@testable import JellyfinSwiftAPI

final class AuthenticationServiceFixtureTests: XCTestCase {
    func testAuthenticationResultFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "Authentication", named: "authentication-result")
        let decoded = try JellyfinJSONCoder.decoder().decode(AuthenticationResult.self, from: data)

        XCTAssertEqual(decoded.accessToken, "36fc473875bf4822910e6a4e006770a1")
        XCTAssertEqual(decoded.user?.id, "44d5193bc7864cdda9c400e2be69b76e")
        XCTAssertEqual(decoded.user?.configuration?.orderedViews, ["7e64e319657a9516ec78490da03edccb"])
        XCTAssertEqual(decoded.user?.policy?.syncPlayAccess, .createAndJoinGroups)
        XCTAssertEqual(decoded.sessionInfo?.userId, "44d5193bc7864cdda9c400e2be69b76e")
        XCTAssertEqual(decoded.sessionInfo?.deviceName, "iPhone 17 Pro")
        XCTAssertEqual(decoded.sessionInfo?.playState?.repeatMode, .repeatNone)
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
