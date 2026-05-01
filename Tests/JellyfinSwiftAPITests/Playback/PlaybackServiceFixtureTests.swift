import XCTest
@testable import JellyfinSwiftAPI

final class PlaybackServiceFixtureTests: XCTestCase {
    func testPlaybackInfoFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "Playback", named: "playback-info")
        let decoded = try JellyfinJSONCoder.decoder().decode(PlaybackInfoResponse.self, from: data)

        XCTAssertEqual(decoded.playSessionId, "play-session")
        XCTAssertEqual(decoded.mediaSources.first?.id, "media-source-1")
    }

    func testFallbackFontsFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "Playback", named: "fallback-fonts")
        let decoded = try JellyfinJSONCoder.decoder().decode([FontFile].self, from: data)

        XCTAssertEqual(decoded.first?.name, "NotoSans-Regular.ttf")
    }

    func testItemSegmentsFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "Playback", named: "item-segments")
        let decoded = try JellyfinJSONCoder.decoder().decode([MediaSegment].self, from: data)

        XCTAssertEqual(decoded.first?.type, .intro)
        XCTAssertEqual(decoded.first?.id?.uuidString.uppercased(), "4A9A391D-9731-4B82-9EAF-D14BF2F4DC74")
        XCTAssertEqual(decoded.first?.itemId?.uuidString.uppercased(), "D2C48876-BD8F-4D6A-8734-712267F7F9F6")
    }

    func testLyricsFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "Playback", named: "lyrics")
        let decoded = try JellyfinJSONCoder.decoder().decode(Lyric.self, from: data)

        XCTAssertEqual(decoded.metadata?.title, "Example Song")
        XCTAssertEqual(decoded.lyrics.first?.text, "First line")
    }

    func testRemoteSubtitlesFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "Playback", named: "remote-subtitles")
        let decoded = try JellyfinJSONCoder.decoder().decode([RemoteSubtitleInfo].self, from: data)

        XCTAssertEqual(decoded.first?.format, "srt")
    }

    func testLiveStreamResponseFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "Playback", named: "live-stream-response")
        let decoded = try JellyfinJSONCoder.decoder().decode(LiveStreamResponse.self, from: data)

        XCTAssertEqual(decoded.mediaSource?.id, "live-source-1")
    }
}
