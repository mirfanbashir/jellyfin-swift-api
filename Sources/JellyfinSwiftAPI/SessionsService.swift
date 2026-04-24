import Foundation

/// Service interface for Jellyfin sessions, remote control, playstate, and SyncPlay endpoints.
public protocol SessionsService: JellyfinService {
    func sessions(_ query: SessionQuery) async throws -> [SessionInfo]
    func sendGeneralCommand(sessionID: String, command: SessionGeneralCommand) async throws
    func sendFullGeneralCommand(sessionID: String, command: GeneralCommand) async throws
    func sendMessageCommand(sessionID: String, command: MessageCommand) async throws
    func play(sessionID: String, request: SessionPlayRequest) async throws
    func sendPlaystateCommand(sessionID: String, request: SessionPlaystateCommandRequest) async throws
    func sendSystemCommand(sessionID: String, command: SessionGeneralCommand) async throws
    func addUser(to sessionID: String, userID: UUID) async throws
    func removeUser(from sessionID: String, userID: UUID) async throws
    func displayContent(sessionID: String, request: SessionDisplayRequest) async throws
    func postCapabilities(_ query: SessionCapabilitiesQuery) async throws
    func postFullCapabilities(_ capabilities: ClientCapabilities) async throws
    func reportSessionEnded() async throws
    func reportViewing(_ request: ViewingRequest) async throws
    func playbackStarted(itemID: String, request: LegacyPlaybackStartRequest) async throws
    func playbackProgress(itemID: String, request: LegacyPlaybackProgressRequest) async throws
    func playbackStopped(itemID: String, request: LegacyPlaybackStopRequest) async throws
    func pingPlaybackSession() async throws
    func reportPlaybackStart(_ info: PlaybackStartInfo) async throws
    func reportPlaybackProgress(_ info: PlaybackProgressInfo) async throws
    func reportPlaybackStopped(_ info: PlaybackStopInfo) async throws
    func markPlayedItem(itemID: String, userID: UUID?, datePlayed: Date?) async throws -> UserItemData
    func markUnplayedItem(itemID: String, userID: UUID?) async throws -> UserItemData
    func syncPlayGroup(id: String) async throws -> SyncPlayGroup
    func syncPlayGroups() async throws -> [SyncPlayGroup]
    func createSyncPlayGroup(_ request: SyncPlayNewGroupRequest) async throws -> SyncPlayGroup
    func joinSyncPlayGroup(_ request: SyncPlayJoinGroupRequest) async throws
    func leaveSyncPlayGroup() async throws
    func syncPlayPause() async throws
    func syncPlayUnpause() async throws
    func syncPlayStop() async throws
    func syncPlaySeek(_ request: SyncPlaySeekRequest) async throws
    func syncPlayBuffering(_ request: SyncPlayTimingRequest) async throws
    func syncPlayReady(_ request: SyncPlayTimingRequest) async throws
    func syncPlayPing(_ request: SyncPlayPingRequest) async throws
    func syncPlayNextItem(_ request: SyncPlayPlaylistItemRequest) async throws
    func syncPlayPreviousItem(_ request: SyncPlayPlaylistItemRequest) async throws
    func syncPlaySetPlaylistItem(_ request: SyncPlaySetPlaylistItemRequest) async throws
    func syncPlaySetRepeatMode(_ request: SyncPlaySetRepeatModeRequest) async throws
    func syncPlaySetShuffleMode(_ request: SyncPlaySetShuffleModeRequest) async throws
    func syncPlaySetNewQueue(_ request: SyncPlaySetNewQueueRequest) async throws
    func syncPlayQueue(_ request: SyncPlayQueueRequest) async throws
    func syncPlayMovePlaylistItem(_ request: SyncPlayMovePlaylistItemRequest) async throws
    func syncPlayRemoveFromPlaylist(_ request: SyncPlayRemoveFromPlaylistRequest) async throws
    func syncPlaySetIgnoreWait(_ request: SyncPlaySetIgnoreWaitRequest) async throws
}
