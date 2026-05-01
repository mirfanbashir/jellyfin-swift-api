import XCTest
@testable import JellyfinSwiftAPI

final class SessionsServiceFixtureTests: XCTestCase {
    func testSessionsFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "Sessions", named: "sessions")
        let sessions = try JellyfinJSONCoder.decoder().decode([SessionInfo].self, from: data)

        XCTAssertEqual(sessions.first?.userName, "irfan")
        XCTAssertEqual(sessions.first?.supportedCommands?.first, .displayMessage)
        XCTAssertEqual(sessions.first?.playState?.playMethod, .directPlay)
        XCTAssertEqual(sessions.first?.userId?.uuidString.uppercased(), "D2C48876-BD8F-4D6A-8734-712267F7F9F6")
        XCTAssertEqual(sessions.first?.nowPlayingQueue?.first?.id?.uuidString.uppercased(), "11111111-1111-1111-1111-111111111111")
    }

    func testSyncPlayGroupFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "Sessions", named: "syncplay-group")
        let group = try JellyfinJSONCoder.decoder().decode(SyncPlayGroup.self, from: data)

        XCTAssertEqual(group.groupName, "Movie Night")
        XCTAssertEqual(group.state, .playing)
        XCTAssertEqual(group.participants?.count, 2)
    }
}
