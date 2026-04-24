import Foundation
import XCTest
@testable import JellyfinSwiftAPI

final class SessionsServiceTests: XCTestCase {
    func testSessionsUsesTypedQuery() async throws {
        let responseData = try FixtureLoader.data(service: "Sessions", named: "sessions")
        let transport = TestTransport { request in
            JellyfinTransportResponse(data: responseData, response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200))
        }
        let service = makeSessionsService(transport: transport)
        let userID = try XCTUnwrap(UUID(uuidString: "D2C48876-BD8F-4D6A-8734-712267F7F9F6"))

        let sessions = try await service.sessions(
            SessionQuery(controllableByUserID: userID, deviceID: "device-1", activeWithinSeconds: 300)
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/Sessions?controllableByUserId=D2C48876-BD8F-4D6A-8734-712267F7F9F6&deviceId=device-1&activeWithinSeconds=300"
        )
        XCTAssertEqual(sessions.first?.client, "SwiftUI")
    }

    func testPlayBuildsQueryItems() async throws {
        let transport = TestTransport { request in
            JellyfinTransportResponse(data: Data(), response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 204))
        }
        let service = makeSessionsService(transport: transport)

        try await service.play(
            sessionID: "session-1",
            request: SessionPlayRequest(
                playCommand: .playNow,
                itemIDs: ["item-1", "item-2"],
                startPositionTicks: 1200,
                mediaSourceID: "source-1",
                subtitleStreamIndex: 3
            )
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/Sessions/session-1/Playing?playCommand=PlayNow&itemIds=item-1,item-2&startPositionTicks=1200&mediaSourceId=source-1&subtitleStreamIndex=3"
        )
    }

    func testPostCapabilitiesUsesJoinedQueryValues() async throws {
        let transport = TestTransport { request in
            JellyfinTransportResponse(data: Data(), response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 204))
        }
        let service = makeSessionsService(transport: transport)

        try await service.postCapabilities(
            SessionCapabilitiesQuery(
                id: "device-1",
                playableMediaTypes: [.audio, .video],
                supportedCommands: [.displayMessage, .play],
                supportsMediaControl: true
            )
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/Sessions/Capabilities?id=device-1&playableMediaTypes=Audio,Video&supportedCommands=DisplayMessage,Play&supportsMediaControl=true"
        )
    }

    func testPostFullCapabilitiesPostsJSONBody() async throws {
        let transport = TestTransport { request in
            JellyfinTransportResponse(data: Data(), response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 204))
        }
        let service = makeSessionsService(transport: transport)

        try await service.postFullCapabilities(
            ClientCapabilities(
                playableMediaTypes: [.audio],
                supportedCommands: ["Play"],
                supportsMediaControl: true,
                supportsPersistentIdentifier: false,
                appStoreUrl: nil,
                iconUrl: nil
            )
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        let body = try JellyfinJSONCoder.decoder().decode(ClientCapabilities.self, from: try XCTUnwrap(request.httpBody))
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.url?.absoluteString, "https://jellyfin.example.com/Sessions/Capabilities/Full")
        XCTAssertEqual(body.playableMediaTypes, [.audio])
    }

    func testSendMessageCommandPostsJSONBody() async throws {
        let transport = TestTransport { request in
            JellyfinTransportResponse(data: Data(), response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 204))
        }
        let service = makeSessionsService(transport: transport)

        try await service.sendMessageCommand(sessionID: "session-1", command: MessageCommand(header: "Hi", text: "Hello", timeoutMs: 5000))

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        let body = try JellyfinJSONCoder.decoder().decode(MessageCommand.self, from: try XCTUnwrap(request.httpBody))
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.url?.absoluteString, "https://jellyfin.example.com/Sessions/session-1/Message")
        XCTAssertEqual(body.text, "Hello")
    }

    func testPlaybackProgressBuildsLegacyQuery() async throws {
        let transport = TestTransport { request in
            JellyfinTransportResponse(data: Data(), response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 204))
        }
        let service = makeSessionsService(transport: transport)

        try await service.playbackProgress(
            itemID: "item-1",
            request: LegacyPlaybackProgressRequest(
                mediaSourceID: "source-1",
                positionTicks: 9000,
                audioStreamIndex: 1,
                playMethod: .directPlay,
                repeatMode: .repeatAll,
                isPaused: false
            )
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/PlayingItems/item-1/Progress?mediaSourceId=source-1&positionTicks=9000&audioStreamIndex=1&playMethod=DirectPlay&repeatMode=RepeatAll&isPaused=false"
        )
    }

    func testReportPlaybackProgressPostsJSONBody() async throws {
        let transport = TestTransport { request in
            JellyfinTransportResponse(data: Data(), response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 204))
        }
        let service = makeSessionsService(transport: transport)

        try await service.reportPlaybackProgress(
            PlaybackProgressInfo(
                canSeek: true,
                itemId: "item-1",
                sessionId: "session-1",
                mediaSourceId: "source-1",
                positionTicks: 1200,
                playMethod: .directPlay
            )
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        let body = try JellyfinJSONCoder.decoder().decode(PlaybackProgressInfo.self, from: try XCTUnwrap(request.httpBody))
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.url?.absoluteString, "https://jellyfin.example.com/Sessions/Playing/Progress")
        XCTAssertEqual(body.itemId, "item-1")
        XCTAssertEqual(body.playMethod, .directPlay)
    }

    func testMarkPlayedItemBuildsOptionalQuery() async throws {
        let responseData = Data(#"{"Played":true,"PlayCount":1,"Key":"item-1"}"#.utf8)
        let transport = TestTransport { request in
            JellyfinTransportResponse(data: responseData, response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200))
        }
        let service = makeSessionsService(transport: transport)
        let userID = try XCTUnwrap(UUID(uuidString: "D2C48876-BD8F-4D6A-8734-712267F7F9F6"))
        let date = try XCTUnwrap(ISO8601DateFormatter().date(from: "2024-04-01T12:00:00Z"))

        let userData = try await service.markPlayedItem(itemID: "item-1", userID: userID, datePlayed: date)

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/UserPlayedItems/item-1?userId=D2C48876-BD8F-4D6A-8734-712267F7F9F6&datePlayed=2024-04-01T12:00:00Z"
        )
        XCTAssertEqual(userData.playCount, 1)
    }

    func testCreateSyncPlayGroupPostsBodyAndDecodesResponse() async throws {
        let responseData = try FixtureLoader.data(service: "Sessions", named: "syncplay-group")
        let transport = TestTransport { request in
            JellyfinTransportResponse(data: responseData, response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200))
        }
        let service = makeSessionsService(transport: transport)

        let group = try await service.createSyncPlayGroup(SyncPlayNewGroupRequest(groupName: "Movie Night"))

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        let body = try JellyfinJSONCoder.decoder().decode(SyncPlayNewGroupRequest.self, from: try XCTUnwrap(request.httpBody))
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.url?.absoluteString, "https://jellyfin.example.com/SyncPlay/New")
        XCTAssertEqual(body.groupName, "Movie Night")
        XCTAssertEqual(group.groupName, "Movie Night")
    }

    func testSyncPlaySetRepeatModePostsBody() async throws {
        let transport = TestTransport { request in
            JellyfinTransportResponse(data: Data(), response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 204))
        }
        let service = makeSessionsService(transport: transport)

        try await service.syncPlaySetRepeatMode(SyncPlaySetRepeatModeRequest(mode: .repeatOne))

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        let body = try JellyfinJSONCoder.decoder().decode(SyncPlaySetRepeatModeRequest.self, from: try XCTUnwrap(request.httpBody))
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.url?.absoluteString, "https://jellyfin.example.com/SyncPlay/SetRepeatMode")
        XCTAssertEqual(body.mode, .repeatOne)
    }
}

private func makeSessionsService(
    authorization: JellyfinAuthorization = .header("MediaBrowser Token=test-token"),
    transport: any JellyfinTransporting
) -> SessionsServiceClient {
    SessionsServiceClient(executor: makeTestExecutor(authorization: authorization, transport: transport))
}
