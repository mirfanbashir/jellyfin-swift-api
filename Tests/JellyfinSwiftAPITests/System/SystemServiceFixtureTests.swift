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
    decoder.keyDecodingStrategy = .custom { codingPath in
        let key = codingPath.last?.stringValue ?? ""
        guard let first = key.first else {
            return FixtureCodingKey(stringValue: key) ?? FixtureCodingKey(intValue: 0)!
        }

        return FixtureCodingKey(stringValue: first.lowercased() + key.dropFirst())
            ?? FixtureCodingKey(intValue: 0)!
    }
    return decoder
}

private struct FixtureCodingKey: CodingKey {
    let stringValue: String
    let intValue: Int?

    init?(stringValue: String) {
        self.stringValue = stringValue
        self.intValue = nil
    }

    init?(intValue: Int) {
        self.stringValue = String(intValue)
        self.intValue = intValue
    }
}
