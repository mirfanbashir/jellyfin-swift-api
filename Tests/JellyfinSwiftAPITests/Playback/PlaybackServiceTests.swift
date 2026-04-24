import Foundation
import XCTest
@testable import JellyfinSwiftAPI

final class PlaybackServiceTests: XCTestCase {
    func testPlaybackInfoUsesUserQuery() async throws {
        let responseData = try FixtureLoader.data(service: "Playback", named: "playback-info")
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: responseData,
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200)
            )
        }
        let service = makePlaybackService(transport: transport)

        let info = try await service.playbackInfo(
            itemID: UUID(uuidString: "D2C48876-BD8F-4D6A-8734-712267F7F9F6")!,
            userID: UUID(uuidString: "5F6D5A13-4B25-4F8D-B9FB-A3B4699EF301")
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/Items/D2C48876-BD8F-4D6A-8734-712267F7F9F6/PlaybackInfo?userId=5F6D5A13-4B25-4F8D-B9FB-A3B4699EF301"
        )
        XCTAssertEqual(info.playSessionId, "play-session")
    }

    func testPostedPlaybackInfoPostsBodyAndQuery() async throws {
        let responseData = try FixtureLoader.data(service: "Playback", named: "playback-info")
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: responseData,
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200)
            )
        }
        let service = makePlaybackService(transport: transport)

        let requestBody = PlaybackInfoRequest(
            maxStreamingBitrate: 8_000_000,
            audioStreamIndex: 1,
            subtitleStreamIndex: 2,
            enableDirectPlay: true,
            enableDirectStream: true,
            enableTranscoding: false
        )
        _ = try await service.postedPlaybackInfo(
            itemID: UUID(uuidString: "D2C48876-BD8F-4D6A-8734-712267F7F9F6")!,
            userID: UUID(uuidString: "5F6D5A13-4B25-4F8D-B9FB-A3B4699EF301"),
            request: requestBody
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        let bodyString = try XCTUnwrap(String(data: try XCTUnwrap(request.httpBody), encoding: .utf8))
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertTrue(try XCTUnwrap(request.url?.absoluteString).contains("maxStreamingBitrate=8000000"))
        XCTAssertTrue(bodyString.contains(#""EnableDirectPlay":true"#))
    }

    func testAudioStreamReturnsRawPayload() async throws {
        let payload = Data("audio-stream".utf8)
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: payload,
                response: makeHTTPResponse(
                    url: try XCTUnwrap(request.url),
                    statusCode: 200,
                    headers: ["Content-Type": "audio/mpeg"]
                )
            )
        }
        let service = makePlaybackService(transport: transport)

        let stream = try await service.audioStream(
            itemID: UUID(uuidString: "D2C48876-BD8F-4D6A-8734-712267F7F9F6")!,
            query: StreamRequestOptions(container: "mp3", audioBitRate: 192000)
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/Audio/D2C48876-BD8F-4D6A-8734-712267F7F9F6/stream?container=mp3&audioBitRate=192000"
        )
        XCTAssertEqual(stream.mimeType, "audio/mpeg")
    }

    func testHeadVideoStreamUsesHEADMethod() async throws {
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: Data(),
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200)
            )
        }
        let service = makePlaybackService(transport: transport)

        try await service.headVideoStream(
            itemID: UUID(uuidString: "D2C48876-BD8F-4D6A-8734-712267F7F9F6")!,
            container: "mp4",
            query: StreamRequestOptions(videoBitRate: 6_000_000)
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(request.httpMethod, "HEAD")
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/Videos/D2C48876-BD8F-4D6A-8734-712267F7F9F6/stream.mp4?videoBitRate=6000000"
        )
    }

    func testBitrateTestReturnsRawData() async throws {
        let payload = Data(repeating: 0xAA, count: 16)
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: payload,
                response: makeHTTPResponse(
                    url: try XCTUnwrap(request.url),
                    statusCode: 200,
                    headers: ["Content-Type": "application/octet-stream"]
                )
            )
        }
        let service = makePlaybackService(transport: transport)

        let bytes = try await service.bitrateTestBytes(size: 16)

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(request.url?.absoluteString, "https://jellyfin.example.com/Playback/BitrateTest?size=16")
        XCTAssertEqual(bytes.data.count, 16)
    }

    func testUploadLyricsPostsTextPlainBody() async throws {
        let responseData = try FixtureLoader.data(service: "Playback", named: "lyrics")
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: responseData,
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200)
            )
        }
        let service = makePlaybackService(transport: transport)

        let lyric = try await service.uploadLyrics(
            itemID: UUID(uuidString: "D2C48876-BD8F-4D6A-8734-712267F7F9F6")!,
            fileName: "song.lrc",
            contents: "[00:01.00]First line"
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.value(forHTTPHeaderField: "Content-Type"), "text/plain")
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/Audio/D2C48876-BD8F-4D6A-8734-712267F7F9F6/Lyrics?fileName=song.lrc"
        )
        XCTAssertEqual(lyric.lyrics.first?.text, "First line")
    }

    func testSearchRemoteLyricsUsesLyricsPath() async throws {
        let responseData = try FixtureLoader.data(service: "Playback", named: "remote-lyrics")
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: responseData,
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200)
            )
        }
        let service = makePlaybackService(transport: transport)

        let lyrics = try await service.searchRemoteLyrics(
            itemID: UUID(uuidString: "D2C48876-BD8F-4D6A-8734-712267F7F9F6")!
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/Audio/D2C48876-BD8F-4D6A-8734-712267F7F9F6/RemoteSearch/Lyrics"
        )
        XCTAssertEqual(lyrics.first?.providerName, "EmbeddedProvider")
    }

    func testSubtitleWithTicksBuildsRouteAndQuery() async throws {
        let payload = Data("WEBVTT".utf8)
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: payload,
                response: makeHTTPResponse(
                    url: try XCTUnwrap(request.url),
                    statusCode: 200,
                    headers: ["Content-Type": "text/vtt"]
                )
            )
        }
        let service = makePlaybackService(transport: transport)

        let subtitle = try await service.subtitle(
            SubtitleStreamRequest(
                itemID: UUID(uuidString: "D2C48876-BD8F-4D6A-8734-712267F7F9F6")!,
                mediaSourceID: "media-source-1",
                index: 2,
                format: "vtt",
                startPositionTicks: 10_000,
                copyTimestamps: true,
                addVTTTimeMap: true
            )
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/Videos/D2C48876-BD8F-4D6A-8734-712267F7F9F6/media-source-1/Subtitles/2/10000/Stream.vtt?itemId=D2C48876-BD8F-4D6A-8734-712267F7F9F6&mediaSourceId=media-source-1&index=2&format=vtt&startPositionTicks=10000&copyTimestamps=true&addVttTimeMap=true"
        )
        XCTAssertEqual(subtitle.mimeType, "text/vtt")
    }

    func testSearchRemoteSubtitlesUsesLanguagePath() async throws {
        let responseData = try FixtureLoader.data(service: "Playback", named: "remote-subtitles")
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: responseData,
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200)
            )
        }
        let service = makePlaybackService(transport: transport)

        let subtitles = try await service.searchRemoteSubtitles(
            itemID: UUID(uuidString: "D2C48876-BD8F-4D6A-8734-712267F7F9F6")!,
            language: "eng",
            isPerfectMatch: true
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/Items/D2C48876-BD8F-4D6A-8734-712267F7F9F6/RemoteSearch/Subtitles/eng?isPerfectMatch=true"
        )
        XCTAssertEqual(subtitles.first?.providerName, "OpenSubtitles")
    }

    func testUploadSubtitlePostsJSONBody() async throws {
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: Data(),
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 204)
            )
        }
        let service = makePlaybackService(transport: transport)

        try await service.uploadSubtitle(
            itemID: UUID(uuidString: "D2C48876-BD8F-4D6A-8734-712267F7F9F6")!,
            request: UploadSubtitleRequest(language: "eng", format: "srt", isForced: false, data: "1\n00:00:01,000 --> 00:00:02,000\nHello")
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        let bodyString = try XCTUnwrap(String(data: try XCTUnwrap(request.httpBody), encoding: .utf8))
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.url?.absoluteString, "https://jellyfin.example.com/Videos/D2C48876-BD8F-4D6A-8734-712267F7F9F6/Subtitles")
        XCTAssertTrue(bodyString.contains(#""Format":"srt""#))
    }

    func testOpenLiveStreamPostsBodyAndQuery() async throws {
        let responseData = try FixtureLoader.data(service: "Playback", named: "live-stream-response")
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: responseData,
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200)
            )
        }
        let service = makePlaybackService(transport: transport)

        let response = try await service.openLiveStream(
            OpenLiveStreamRequest(
                openToken: "open-token",
                userID: UUID(uuidString: "5F6D5A13-4B25-4F8D-B9FB-A3B4699EF301"),
                playSessionId: "play-session",
                maxStreamingBitrate: 8_000_000,
                itemID: UUID(uuidString: "D2C48876-BD8F-4D6A-8734-712267F7F9F6"),
                enableDirectPlay: true
            )
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        let postedBody = try JellyfinJSONCoder.decoder().decode(
            OpenLiveStreamRequest.self,
            from: try XCTUnwrap(request.httpBody)
        )
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertTrue(try XCTUnwrap(request.url?.absoluteString).contains("openToken=open-token"))
        XCTAssertEqual(
            postedBody.itemID,
            UUID(uuidString: "D2C48876-BD8F-4D6A-8734-712267F7F9F6")
        )
        XCTAssertEqual(response.mediaSource?.name, "Live Stream")
    }

    func testCloseLiveStreamUsesPostRequest() async throws {
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: Data(),
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 204)
            )
        }
        let service = makePlaybackService(transport: transport)

        try await service.closeLiveStream(liveStreamID: "live-1")

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.url?.absoluteString, "https://jellyfin.example.com/LiveStreams/Close?liveStreamId=live-1")
    }

    func testMasterHlsVideoPlaylistUsesPlaylistPath() async throws {
        let payload = Data("#EXTM3U".utf8)
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: payload,
                response: makeHTTPResponse(
                    url: try XCTUnwrap(request.url),
                    statusCode: 200,
                    headers: ["Content-Type": "application/x-mpegURL"]
                )
            )
        }
        let service = makePlaybackService(transport: transport)

        let playlist = try await service.masterHlsVideoPlaylist(
            itemID: UUID(uuidString: "D2C48876-BD8F-4D6A-8734-712267F7F9F6")!,
            query: StreamRequestOptions(mediaSourceId: "media-source-1", enableAdaptiveBitrateStreaming: true)
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/Videos/D2C48876-BD8F-4D6A-8734-712267F7F9F6/master.m3u8?mediaSourceId=media-source-1&enableAdaptiveBitrateStreaming=true"
        )
        XCTAssertEqual(playlist.mimeType, "application/x-mpegURL")
    }

    func testHlsVideoSegmentUsesDynamicPathAndTicks() async throws {
        let payload = Data(repeating: 0xAA, count: 8)
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: payload,
                response: makeHTTPResponse(
                    url: try XCTUnwrap(request.url),
                    statusCode: 200,
                    headers: ["Content-Type": "video/mp2t"]
                )
            )
        }
        let service = makePlaybackService(transport: transport)

        let segment = try await service.hlsVideoSegment(
            HLSVideoSegmentRequest(
                itemID: UUID(uuidString: "D2C48876-BD8F-4D6A-8734-712267F7F9F6")!,
                playlistID: "playlist-1",
                segmentID: 7,
                container: "ts",
                runtimeTicks: 90_000,
                actualSegmentLengthTicks: 30_000
            )
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/Videos/D2C48876-BD8F-4D6A-8734-712267F7F9F6/hls1/playlist-1/7.ts?runtimeTicks=90000&actualSegmentLengthTicks=30000"
        )
        XCTAssertEqual(segment.mimeType, "video/mp2t")
    }

    func testTrickplayTileUsesWidthIndexAndMediaSource() async throws {
        let payload = Data(repeating: 0xFF, count: 4)
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: payload,
                response: makeHTTPResponse(
                    url: try XCTUnwrap(request.url),
                    statusCode: 200,
                    headers: ["Content-Type": "image/jpeg"]
                )
            )
        }
        let service = makePlaybackService(transport: transport)

        let tile = try await service.trickplayTile(
            itemID: UUID(uuidString: "D2C48876-BD8F-4D6A-8734-712267F7F9F6")!,
            width: 320,
            index: 4,
            mediaSourceID: "media-source-1"
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/Videos/D2C48876-BD8F-4D6A-8734-712267F7F9F6/Trickplay/320/4.jpg?mediaSourceId=media-source-1"
        )
        XCTAssertEqual(tile.mimeType, "image/jpeg")
    }

    func testStopEncodingProcessUsesDeleteQuery() async throws {
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: Data(),
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 204)
            )
        }
        let service = makePlaybackService(transport: transport)

        try await service.stopEncodingProcess(deviceID: "device-1", playSessionID: "play-1")

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(request.httpMethod, "DELETE")
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/Videos/ActiveEncodings?deviceId=device-1&playSessionId=play-1"
        )
    }

    func testMergeVersionsUsesJoinedIDsQuery() async throws {
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: Data(),
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 204)
            )
        }
        let service = makePlaybackService(transport: transport)

        try await service.mergeVersions(
            itemIDs: [
                UUID(uuidString: "D2C48876-BD8F-4D6A-8734-712267F7F9F6")!,
                UUID(uuidString: "5F6D5A13-4B25-4F8D-B9FB-A3B4699EF301")!,
            ]
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/Videos/MergeVersions?ids=D2C48876-BD8F-4D6A-8734-712267F7F9F6,5F6D5A13-4B25-4F8D-B9FB-A3B4699EF301"
        )
    }
}

private func makePlaybackService(
    authorization: JellyfinAuthorization = .header("MediaBrowser Token=test-token"),
    transport: any JellyfinTransporting
) -> PlaybackServiceClient {
    PlaybackServiceClient(executor: makeTestExecutor(authorization: authorization, transport: transport))
}
