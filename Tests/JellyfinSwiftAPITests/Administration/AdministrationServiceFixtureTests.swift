import XCTest
@testable import JellyfinSwiftAPI

final class AdministrationServiceFixtureTests: XCTestCase {
    func testServerConfigurationFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "Administration", named: "configuration")
        let decoded = try JellyfinJSONCoder.decoder().decode(ServerConfiguration.self, from: data)

        XCTAssertEqual(decoded.serverName, "Jellyfin Test Server")
    }

    func testBackupsFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "Administration", named: "backups")
        let decoded = try JellyfinJSONCoder.decoder().decode([BackupManifest].self, from: data)

        XCTAssertEqual(decoded.first?.serverVersion, "10.11.8")
    }

    func testTasksFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "Administration", named: "tasks")
        let decoded = try JellyfinJSONCoder.decoder().decode([ScheduledTask].self, from: data)

        XCTAssertEqual(decoded.first?.name, "Scan Library")
    }

    func testPluginsFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "Administration", named: "plugins")
        let decoded = try JellyfinJSONCoder.decoder().decode([PluginInfo].self, from: data)

        XCTAssertEqual(decoded.first?.name, "Intro Skipper")
    }

    func testActivityLogFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "Administration", named: "activity-log")
        let decoded = try JellyfinJSONCoder.decoder().decode(ActivityLogQueryResult.self, from: data)

        XCTAssertEqual(decoded.items.first?.name, "Library scan completed")
    }

    func testApiKeysFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "Administration", named: "api-keys")
        let decoded = try JellyfinJSONCoder.decoder().decode(APIKeyQueryResult.self, from: data)

        XCTAssertEqual(decoded.items.first?.appName, "Swift App")
    }
}
