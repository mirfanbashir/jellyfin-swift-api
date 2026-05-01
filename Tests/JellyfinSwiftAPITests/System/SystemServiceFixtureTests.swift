import XCTest
import JellyfinSwiftAPI

final class SystemServiceFixtureTests: XCTestCase {
    func testPublicSystemInfoFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "System", named: "public-info")
        let decoded = try makeDecoder().decode(PublicSystemInfo.self, from: data)

        XCTAssertEqual(decoded.serverName, "Jellyfin Demo")
        XCTAssertEqual(decoded.version, "10.10.7")
        XCTAssertEqual(decoded.operatingSystem, "Linux")
    }

    func testSystemInfoFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "System", named: "system-info")
        let decoded = try makeDecoder().decode(SystemInfo.self, from: data)

        XCTAssertEqual(decoded.serverName, "Jellyfin Demo")
        XCTAssertEqual(decoded.webSocketPortNumber, 8096)
        XCTAssertEqual(decoded.completedInstallations?.first?.name, "TheTVDB")
        XCTAssertEqual(decoded.completedInstallations?.first?.guid.uuidString.uppercased(), "5F6D5A13-4B25-4F8D-B9FB-A3B4699EF001")
        XCTAssertEqual(decoded.completedInstallations?.first?.packageInfo?.guid.uuidString.uppercased(), "5F6D5A13-4B25-4F8D-B9FB-A3B4699EF001")
    }

    func testServerLogsFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "System", named: "server-logs")
        let decoded = try makeDecoder().decode([LogFile].self, from: data)

        XCTAssertEqual(decoded.count, 2)
        XCTAssertEqual(decoded.first?.name, "log_20260424.log")
    }

    func testUtcTimeFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "System", named: "utc-time")
        let decoded = try makeDecoder().decode(UtcTimeResponse.self, from: data)

        XCTAssertEqual(
            decoded.requestReceptionTime,
            ISO8601DateFormatter().date(from: "2026-04-24T14:00:00Z")
        )
    }
}

private func makeDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    return decoder
}
