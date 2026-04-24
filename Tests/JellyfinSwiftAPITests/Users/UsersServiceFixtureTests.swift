import XCTest
@testable import JellyfinSwiftAPI

final class UsersServiceFixtureTests: XCTestCase {
    func testUsersFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "Users", named: "users")
        let decoded = try JellyfinJSONCoder.decoder().decode([User].self, from: data)

        XCTAssertEqual(decoded.count, 1)
        XCTAssertEqual(decoded.first?.name, "demo")
    }

    func testDevicesFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "Users", named: "devices")
        let decoded = try JellyfinJSONCoder.decoder().decode(DeviceQueryResult.self, from: data)

        XCTAssertEqual(decoded.totalRecordCount, 1)
        XCTAssertEqual(decoded.items.first?.appName, "Jellyfin iOS")
    }

    func testDisplayPreferencesFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "Users", named: "display-preferences")
        let decoded = try JellyfinJSONCoder.decoder().decode(DisplayPreferences.self, from: data)

        XCTAssertEqual(decoded.client, "jellyfin-ios")
        XCTAssertEqual(decoded.scrollDirection, .horizontal)
    }
}
