import XCTest
@testable import JellyfinSwiftAPI

final class UsersServiceFixtureTests: XCTestCase {
    func testUsersFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "Users", named: "users")
        let decoded = try JellyfinJSONCoder.decoder().decode([User].self, from: data)

        XCTAssertEqual(decoded.count, 1)
        XCTAssertEqual(decoded.first?.name, "demo")
        XCTAssertEqual(decoded.first?.id.uuidString.uppercased(), "5F6D5A13-4B25-4F8D-B9FB-A3B4699EF001")
        XCTAssertEqual(decoded.first?.configuration?.orderedViews.first?.uuidString.uppercased(), "D2C48876-BD8F-4D6A-8734-712267F7F9F6")
        XCTAssertEqual(decoded.first?.policy?.enabledChannels?.first?.uuidString.uppercased(), "22222222-2222-2222-2222-222222222222")
        XCTAssertEqual(decoded.first?.policy?.accessSchedules?.first?.userId.uuidString.uppercased(), "5F6D5A13-4B25-4F8D-B9FB-A3B4699EF001")
    }

    func testDevicesFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "Users", named: "devices")
        let decoded = try JellyfinJSONCoder.decoder().decode(DeviceQueryResult.self, from: data)

        XCTAssertEqual(decoded.totalRecordCount, 1)
        XCTAssertEqual(decoded.items.first?.appName, "Jellyfin iOS")
        XCTAssertEqual(decoded.items.first?.lastUserId?.uuidString.uppercased(), "5F6D5A13-4B25-4F8D-B9FB-A3B4699EF001")
    }

    func testDisplayPreferencesFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "Users", named: "display-preferences")
        let decoded = try JellyfinJSONCoder.decoder().decode(DisplayPreferences.self, from: data)

        XCTAssertEqual(decoded.client, "jellyfin-ios")
        XCTAssertEqual(decoded.scrollDirection, .horizontal)
    }
}
