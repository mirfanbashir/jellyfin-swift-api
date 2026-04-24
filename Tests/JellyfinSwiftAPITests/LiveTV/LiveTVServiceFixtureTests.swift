import XCTest
@testable import JellyfinSwiftAPI

final class LiveTVServiceFixtureTests: XCTestCase {
    func testLiveTVInfoFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "LiveTV", named: "info")
        let decoded = try JellyfinJSONCoder.decoder().decode(LiveTVInfo.self, from: data)

        XCTAssertEqual(decoded.services.first?.name, "HDHomeRun")
    }

    func testChannelMappingOptionsFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "LiveTV", named: "channel-mapping-options")
        let decoded = try JellyfinJSONCoder.decoder().decode(ChannelMappingOptions.self, from: data)

        XCTAssertEqual(decoded.providerName, "Schedules Direct")
    }

    func testTimerQueryFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "LiveTV", named: "timers")
        let decoded = try JellyfinJSONCoder.decoder().decode(TimerQueryResult.self, from: data)

        XCTAssertEqual(decoded.items.first?.name, "Evening News")
    }

    func testTunerHostsFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "LiveTV", named: "tuners")
        let decoded = try JellyfinJSONCoder.decoder().decode([TunerHost].self, from: data)

        XCTAssertEqual(decoded.first?.friendlyName, "HDHomeRun Flex")
    }
}
