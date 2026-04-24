import Foundation

internal struct SessionsServiceClient: SessionsService {
    private let executor: JellyfinRequestExecutor

    internal init(executor: JellyfinRequestExecutor) {
        self.executor = executor
    }

    internal func sessions(_ query: SessionQuery = SessionQuery()) async throws -> [SessionInfo] {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("controllableByUserId", query.controllableByUserID?.uuidString)
        queryItems.appendOptional("deviceId", query.deviceID)
        queryItems.appendOptional("activeWithinSeconds", query.activeWithinSeconds)
        return try await executor.executeJSON(
            [SessionInfo].self,
            for: JellyfinRequest(path: "/Sessions", queryItems: queryItems)
        )
    }

    internal func sendGeneralCommand(sessionID: String, command: SessionGeneralCommand) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(path: "/Sessions/\(sessionID)/Command/\(command.rawValue)", method: .post)
        )
    }

    internal func sendFullGeneralCommand(sessionID: String, command: GeneralCommand) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Sessions/\(sessionID)/Command",
                method: .post,
                body: .json(try JellyfinJSONCoder.encoder().encode(command))
            )
        )
    }

    internal func sendMessageCommand(sessionID: String, command: MessageCommand) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Sessions/\(sessionID)/Message",
                method: .post,
                body: .json(try JellyfinJSONCoder.encoder().encode(command))
            )
        )
    }

    internal func play(sessionID: String, request: SessionPlayRequest) async throws {
        var queryItems = [URLQueryItem(name: "playCommand", value: request.playCommand.rawValue)]
        queryItems.append(URLQueryItem(name: "itemIds", value: request.itemIDs.joined(separator: ",")))
        queryItems.appendOptional("startPositionTicks", request.startPositionTicks)
        queryItems.appendOptional("mediaSourceId", request.mediaSourceID)
        queryItems.appendOptional("audioStreamIndex", request.audioStreamIndex)
        queryItems.appendOptional("subtitleStreamIndex", request.subtitleStreamIndex)
        queryItems.appendOptional("startIndex", request.startIndex)
        try await executor.executeEmpty(
            for: JellyfinRequest(path: "/Sessions/\(sessionID)/Playing", method: .post, queryItems: queryItems)
        )
    }

    internal func sendPlaystateCommand(sessionID: String, request: SessionPlaystateCommandRequest) async throws {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("seekPositionTicks", request.seekPositionTicks)
        queryItems.appendOptional("controllingUserId", request.controllingUserID?.uuidString)
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Sessions/\(sessionID)/Playing/\(request.command.rawValue)",
                method: .post,
                queryItems: queryItems
            )
        )
    }

    internal func sendSystemCommand(sessionID: String, command: SessionGeneralCommand) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(path: "/Sessions/\(sessionID)/System/\(command.rawValue)", method: .post)
        )
    }

    internal func addUser(to sessionID: String, userID: UUID) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(path: "/Sessions/\(sessionID)/User/\(userID.uuidString)", method: .post)
        )
    }

    internal func removeUser(from sessionID: String, userID: UUID) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(path: "/Sessions/\(sessionID)/User/\(userID.uuidString)", method: .delete)
        )
    }

    internal func displayContent(sessionID: String, request: SessionDisplayRequest) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Sessions/\(sessionID)/Viewing",
                method: .post,
                queryItems: [
                    URLQueryItem(name: "itemType", value: request.itemType.rawValue),
                    URLQueryItem(name: "itemId", value: request.itemID),
                    URLQueryItem(name: "itemName", value: request.itemName),
                ]
            )
        )
    }

    internal func postCapabilities(_ query: SessionCapabilitiesQuery) async throws {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("id", query.id)
        queryItems.appendJoined("playableMediaTypes", query.playableMediaTypes.map(\.rawValue))
        queryItems.appendJoined("supportedCommands", query.supportedCommands.map(\.rawValue))
        queryItems.appendOptional("supportsMediaControl", query.supportsMediaControl)
        queryItems.appendOptional("supportsPersistentIdentifier", query.supportsPersistentIdentifier)
        try await executor.executeEmpty(
            for: JellyfinRequest(path: "/Sessions/Capabilities", method: .post, queryItems: queryItems)
        )
    }

    internal func postFullCapabilities(_ capabilities: ClientCapabilities) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Sessions/Capabilities/Full",
                method: .post,
                body: .json(try JellyfinJSONCoder.encoder().encode(capabilities))
            )
        )
    }

    internal func reportSessionEnded() async throws {
        try await executor.executeEmpty(for: JellyfinRequest(path: "/Sessions/Logout", method: .post))
    }

    internal func reportViewing(_ request: ViewingRequest) async throws {
        var queryItems = [URLQueryItem(name: "itemId", value: request.itemID)]
        queryItems.appendOptional("sessionId", request.sessionID)
        try await executor.executeEmpty(
            for: JellyfinRequest(path: "/Sessions/Viewing", method: .post, queryItems: queryItems)
        )
    }

    internal func playbackStarted(itemID: String, request: LegacyPlaybackStartRequest) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/PlayingItems/\(itemID)",
                method: .post,
                queryItems: legacyPlaybackStartQuery(request)
            )
        )
    }

    internal func playbackProgress(itemID: String, request: LegacyPlaybackProgressRequest) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/PlayingItems/\(itemID)/Progress",
                method: .post,
                queryItems: legacyPlaybackProgressQuery(request)
            )
        )
    }

    internal func playbackStopped(itemID: String, request: LegacyPlaybackStopRequest) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/PlayingItems/\(itemID)",
                method: .delete,
                queryItems: legacyPlaybackStopQuery(request)
            )
        )
    }

    internal func pingPlaybackSession() async throws {
        try await executor.executeEmpty(for: JellyfinRequest(path: "/Sessions/Playing/Ping", method: .post))
    }

    internal func reportPlaybackStart(_ info: PlaybackStartInfo) async throws {
        try await postJSON("/Sessions/Playing", info)
    }

    internal func reportPlaybackProgress(_ info: PlaybackProgressInfo) async throws {
        try await postJSON("/Sessions/Playing/Progress", info)
    }

    internal func reportPlaybackStopped(_ info: PlaybackStopInfo) async throws {
        try await postJSON("/Sessions/Playing/Stopped", info)
    }

    internal func markPlayedItem(itemID: String, userID: UUID?, datePlayed: Date?) async throws -> UserItemData {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("userId", userID?.uuidString)
        queryItems.appendOptional("datePlayed", datePlayed.map(iso8601))
        return try await executor.executeJSON(
            UserItemData.self,
            for: JellyfinRequest(path: "/UserPlayedItems/\(itemID)", method: .post, queryItems: queryItems)
        )
    }

    internal func markUnplayedItem(itemID: String, userID: UUID?) async throws -> UserItemData {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("userId", userID?.uuidString)
        return try await executor.executeJSON(
            UserItemData.self,
            for: JellyfinRequest(path: "/UserPlayedItems/\(itemID)", method: .delete, queryItems: queryItems)
        )
    }

    internal func syncPlayGroup(id: String) async throws -> SyncPlayGroup {
        try await executor.executeJSON(
            SyncPlayGroup.self,
            for: JellyfinRequest(path: "/SyncPlay/\(id)")
        )
    }

    internal func syncPlayGroups() async throws -> [SyncPlayGroup] {
        try await executor.executeJSON(
            [SyncPlayGroup].self,
            for: JellyfinRequest(path: "/SyncPlay/List")
        )
    }

    internal func createSyncPlayGroup(_ request: SyncPlayNewGroupRequest) async throws -> SyncPlayGroup {
        try await executor.executeJSON(
            SyncPlayGroup.self,
            for: JellyfinRequest(
                path: "/SyncPlay/New",
                method: .post,
                body: .json(try JellyfinJSONCoder.encoder().encode(request))
            )
        )
    }

    internal func joinSyncPlayGroup(_ request: SyncPlayJoinGroupRequest) async throws {
        try await postJSON("/SyncPlay/Join", request)
    }

    internal func leaveSyncPlayGroup() async throws {
        try await executor.executeEmpty(for: JellyfinRequest(path: "/SyncPlay/Leave", method: .post))
    }

    internal func syncPlayPause() async throws {
        try await executor.executeEmpty(for: JellyfinRequest(path: "/SyncPlay/Pause", method: .post))
    }

    internal func syncPlayUnpause() async throws {
        try await executor.executeEmpty(for: JellyfinRequest(path: "/SyncPlay/Unpause", method: .post))
    }

    internal func syncPlayStop() async throws {
        try await executor.executeEmpty(for: JellyfinRequest(path: "/SyncPlay/Stop", method: .post))
    }

    internal func syncPlaySeek(_ request: SyncPlaySeekRequest) async throws {
        try await postJSON("/SyncPlay/Seek", request)
    }

    internal func syncPlayBuffering(_ request: SyncPlayTimingRequest) async throws {
        try await postJSON("/SyncPlay/Buffering", request)
    }

    internal func syncPlayReady(_ request: SyncPlayTimingRequest) async throws {
        try await postJSON("/SyncPlay/Ready", request)
    }

    internal func syncPlayPing(_ request: SyncPlayPingRequest) async throws {
        try await postJSON("/SyncPlay/Ping", request)
    }

    internal func syncPlayNextItem(_ request: SyncPlayPlaylistItemRequest) async throws {
        try await postJSON("/SyncPlay/NextItem", request)
    }

    internal func syncPlayPreviousItem(_ request: SyncPlayPlaylistItemRequest) async throws {
        try await postJSON("/SyncPlay/PreviousItem", request)
    }

    internal func syncPlaySetPlaylistItem(_ request: SyncPlaySetPlaylistItemRequest) async throws {
        try await postJSON("/SyncPlay/SetPlaylistItem", request)
    }

    internal func syncPlaySetRepeatMode(_ request: SyncPlaySetRepeatModeRequest) async throws {
        try await postJSON("/SyncPlay/SetRepeatMode", request)
    }

    internal func syncPlaySetShuffleMode(_ request: SyncPlaySetShuffleModeRequest) async throws {
        try await postJSON("/SyncPlay/SetShuffleMode", request)
    }

    internal func syncPlaySetNewQueue(_ request: SyncPlaySetNewQueueRequest) async throws {
        try await postJSON("/SyncPlay/SetNewQueue", request)
    }

    internal func syncPlayQueue(_ request: SyncPlayQueueRequest) async throws {
        try await postJSON("/SyncPlay/Queue", request)
    }

    internal func syncPlayMovePlaylistItem(_ request: SyncPlayMovePlaylistItemRequest) async throws {
        try await postJSON("/SyncPlay/MovePlaylistItem", request)
    }

    internal func syncPlayRemoveFromPlaylist(_ request: SyncPlayRemoveFromPlaylistRequest) async throws {
        try await postJSON("/SyncPlay/RemoveFromPlaylist", request)
    }

    internal func syncPlaySetIgnoreWait(_ request: SyncPlaySetIgnoreWaitRequest) async throws {
        try await postJSON("/SyncPlay/SetIgnoreWait", request)
    }

    private func postJSON<T: Encodable>(_ path: String, _ body: T) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: path,
                method: .post,
                body: .json(try JellyfinJSONCoder.encoder().encode(body))
            )
        )
    }

    private func legacyPlaybackStartQuery(_ request: LegacyPlaybackStartRequest) -> [URLQueryItem] {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("mediaSourceId", request.mediaSourceID)
        queryItems.appendOptional("audioStreamIndex", request.audioStreamIndex)
        queryItems.appendOptional("subtitleStreamIndex", request.subtitleStreamIndex)
        queryItems.appendOptional("playMethod", request.playMethod?.rawValue)
        queryItems.appendOptional("liveStreamId", request.liveStreamID)
        queryItems.appendOptional("playSessionId", request.playSessionID)
        queryItems.appendOptional("canSeek", request.canSeek)
        return queryItems
    }

    private func legacyPlaybackProgressQuery(_ request: LegacyPlaybackProgressRequest) -> [URLQueryItem] {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("mediaSourceId", request.mediaSourceID)
        queryItems.appendOptional("positionTicks", request.positionTicks)
        queryItems.appendOptional("audioStreamIndex", request.audioStreamIndex)
        queryItems.appendOptional("subtitleStreamIndex", request.subtitleStreamIndex)
        queryItems.appendOptional("volumeLevel", request.volumeLevel)
        queryItems.appendOptional("playMethod", request.playMethod?.rawValue)
        queryItems.appendOptional("liveStreamId", request.liveStreamID)
        queryItems.appendOptional("playSessionId", request.playSessionID)
        queryItems.appendOptional("repeatMode", request.repeatMode?.rawValue)
        queryItems.appendOptional("isPaused", request.isPaused)
        queryItems.appendOptional("isMuted", request.isMuted)
        return queryItems
    }

    private func legacyPlaybackStopQuery(_ request: LegacyPlaybackStopRequest) -> [URLQueryItem] {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("mediaSourceId", request.mediaSourceID)
        queryItems.appendOptional("nextMediaType", request.nextMediaType)
        queryItems.appendOptional("positionTicks", request.positionTicks)
        queryItems.appendOptional("liveStreamId", request.liveStreamID)
        queryItems.appendOptional("playSessionId", request.playSessionID)
        return queryItems
    }
}

private extension Array where Element == URLQueryItem {
    mutating func appendOptional<T: CustomStringConvertible>(_ name: String, _ value: T?) {
        guard let value else { return }
        append(URLQueryItem(name: name, value: value.description))
    }

    mutating func appendJoined(_ name: String, _ values: [String]) {
        guard !values.isEmpty else { return }
        append(URLQueryItem(name: name, value: values.joined(separator: ",")))
    }
}

private func iso8601(_ value: Date) -> String {
    ISO8601DateFormatter().string(from: value)
}
