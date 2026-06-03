import Foundation

/// Service interface for Jellyfin sessions, remote control, playstate, and SyncPlay endpoints.
public protocol SessionsService: JellyfinService {
    /// Gets the active Jellyfin sessions visible to the current client.
    ///
    /// - Parameter query: Filters for controllable sessions, device id, and recent activity.
    /// - Returns: The sessions that match the supplied filters.
    func sessions(_ query: SessionQuery) async throws -> [SessionInfo]

    /// Issues a general remote-control command to a client session.
    ///
    /// - Parameters:
    ///   - sessionID: The target session identifier.
    ///   - command: The general command to send.
    func sendGeneralCommand(sessionID: String, command: SessionGeneralCommand) async throws

    /// Issues a full general command payload to a client session.
    ///
    /// - Parameters:
    ///   - sessionID: The target session identifier.
    ///   - command: The full command payload, including optional arguments and controlling user context.
    func sendFullGeneralCommand(sessionID: String, command: GeneralCommand) async throws

    /// Sends a message command that asks a client session to display text to the user.
    ///
    /// - Parameters:
    ///   - sessionID: The target session identifier.
    ///   - command: The message payload containing header, body text, and optional timeout.
    func sendMessageCommand(sessionID: String, command: MessageCommand) async throws

    /// Instructs a session to begin playback of one or more items.
    ///
    /// - Parameters:
    ///   - sessionID: The target session identifier.
    ///   - request: The playback command, item identifiers, and optional stream selection details.
    func play(sessionID: String, request: SessionPlayRequest) async throws

    /// Issues a playstate command such as pause, stop, or seek to a client session.
    ///
    /// - Parameters:
    ///   - sessionID: The target session identifier.
    ///   - request: The playstate command and any optional seek or controlling-user metadata.
    func sendPlaystateCommand(sessionID: String, request: SessionPlaystateCommandRequest) async throws

    /// Issues a system-level remote-control command to a client session.
    ///
    /// - Parameters:
    ///   - sessionID: The target session identifier.
    ///   - command: The system command to send.
    func sendSystemCommand(sessionID: String, command: SessionGeneralCommand) async throws

    /// Adds an additional user to a shared session.
    ///
    /// - Parameters:
    ///   - sessionID: The target session identifier.
    ///   - userID: The user identifier to add.
    func addUser(to sessionID: String, userID: UUID) async throws

    /// Removes an additional user from a shared session.
    ///
    /// - Parameters:
    ///   - sessionID: The target session identifier.
    ///   - userID: The user identifier to remove.
    func removeUser(from sessionID: String, userID: UUID) async throws

    /// Instructs a client session to browse to a specific item or view.
    ///
    /// - Parameters:
    ///   - sessionID: The target session identifier.
    ///   - request: The item kind, item identifier, and item name to display.
    func displayContent(sessionID: String, request: SessionDisplayRequest) async throws

    /// Updates device capabilities using the lightweight query-parameter endpoint.
    ///
    /// - Parameter query: Session capability values such as supported commands and playable media types.
    func postCapabilities(_ query: SessionCapabilitiesQuery) async throws

    /// Updates device capabilities using the full JSON capability payload.
    ///
    /// - Parameter capabilities: The complete client capability description to send to Jellyfin.
    func postFullCapabilities(_ capabilities: ClientCapabilities) async throws

    /// Reports that the current authenticated session has ended.
    func reportSessionEnded() async throws

    /// Reports the item or view currently being displayed by the current session.
    ///
    /// - Parameter request: The item metadata that the client is currently viewing.
    func reportViewing(_ request: ViewingRequest) async throws

    /// Reports that playback has started for an item using Jellyfin's legacy playstate endpoint.
    ///
    /// - Parameters:
    ///   - itemID: The item identifier being played.
    ///   - request: The playback-start details to report.
    func playbackStarted(itemID: String, request: LegacyPlaybackStartRequest) async throws

    /// Reports playback progress for an item using Jellyfin's legacy playstate endpoint.
    ///
    /// - Parameters:
    ///   - itemID: The item identifier being played.
    ///   - request: The progress details to report.
    func playbackProgress(itemID: String, request: LegacyPlaybackProgressRequest) async throws

    /// Reports that playback has stopped for an item using Jellyfin's legacy playstate endpoint.
    ///
    /// - Parameters:
    ///   - itemID: The item identifier that stopped playing.
    ///   - request: The stop details to report.
    func playbackStopped(itemID: String, request: LegacyPlaybackStopRequest) async throws

    /// Pings the current playback session to keep it active on the server.
    func pingPlaybackSession() async throws

    /// Reports that playback has started within the current session.
    ///
    /// - Parameter info: The playback-start information to send to Jellyfin.
    func reportPlaybackStart(_ info: PlaybackStartInfo) async throws

    /// Reports playback progress within the current session.
    ///
    /// - Parameter info: The playback-progress information to send to Jellyfin.
    func reportPlaybackProgress(_ info: PlaybackProgressInfo) async throws

    /// Reports that playback has stopped within the current session.
    ///
    /// - Parameter info: The playback-stop information to send to Jellyfin.
    func reportPlaybackStopped(_ info: PlaybackStopInfo) async throws

    /// Marks an item as played for a user.
    ///
    /// - Parameters:
    ///   - itemID: The item identifier to update.
    ///   - userID: The user identifier to associate with the played state. When omitted, Jellyfin uses the current user.
    ///   - datePlayed: An optional playback timestamp to record.
    /// - Returns: The updated per-user item data returned by Jellyfin.
    func markPlayedItem(itemID: String, userID: UUID?, datePlayed: Date?) async throws -> UserItemData

    /// Marks an item as unplayed for a user.
    ///
    /// - Parameters:
    ///   - itemID: The item identifier to update.
    ///   - userID: The user identifier to associate with the unplayed state. When omitted, Jellyfin uses the current user.
    /// - Returns: The updated per-user item data returned by Jellyfin.
    func markUnplayedItem(itemID: String, userID: UUID?) async throws -> UserItemData

    /// Gets a SyncPlay group by identifier.
    ///
    /// - Parameter id: The SyncPlay group identifier.
    /// - Returns: The requested SyncPlay group.
    func syncPlayGroup(id: String) async throws -> SyncPlayGroup

    /// Gets all SyncPlay groups visible to the current user.
    ///
    /// - Returns: The available SyncPlay groups.
    func syncPlayGroups() async throws -> [SyncPlayGroup]

    /// Creates a new SyncPlay group.
    ///
    /// - Parameter request: The new group settings.
    /// - Returns: The newly created SyncPlay group when returned by the server.
    func createSyncPlayGroup(_ request: SyncPlayNewGroupRequest) async throws -> SyncPlayGroup

    /// Joins an existing SyncPlay group.
    ///
    /// - Parameter request: The group join request.
    func joinSyncPlayGroup(_ request: SyncPlayJoinGroupRequest) async throws

    /// Leaves the currently joined SyncPlay group.
    func leaveSyncPlayGroup() async throws

    /// Requests that the current SyncPlay group pause playback.
    func syncPlayPause() async throws

    /// Requests that the current SyncPlay group resume playback.
    func syncPlayUnpause() async throws

    /// Requests that the current SyncPlay group stop playback.
    func syncPlayStop() async throws

    /// Seeks playback for the current SyncPlay group.
    ///
    /// - Parameter request: The seek position and related SyncPlay context.
    func syncPlaySeek(_ request: SyncPlaySeekRequest) async throws

    /// Notifies the current SyncPlay group that this member is buffering.
    ///
    /// - Parameter request: The buffering status to broadcast.
    func syncPlayBuffering(_ request: SyncPlayTimingRequest) async throws

    /// Notifies the current SyncPlay group that this member is ready to continue playback.
    ///
    /// - Parameter request: The ready status to broadcast.
    func syncPlayReady(_ request: SyncPlayTimingRequest) async throws

    /// Sends a ping update for the current SyncPlay group member.
    ///
    /// - Parameter request: The ping payload to send.
    func syncPlayPing(_ request: SyncPlayPingRequest) async throws

    /// Requests the next playlist item in the current SyncPlay group.
    ///
    /// - Parameter request: The current item context.
    func syncPlayNextItem(_ request: SyncPlayPlaylistItemRequest) async throws

    /// Requests the previous playlist item in the current SyncPlay group.
    ///
    /// - Parameter request: The current item context.
    func syncPlayPreviousItem(_ request: SyncPlayPlaylistItemRequest) async throws

    /// Sets the current playlist item for the SyncPlay group.
    ///
    /// - Parameter request: The target playlist item.
    func syncPlaySetPlaylistItem(_ request: SyncPlaySetPlaylistItemRequest) async throws

    /// Updates repeat mode for the SyncPlay group.
    ///
    /// - Parameter request: The repeat-mode payload.
    func syncPlaySetRepeatMode(_ request: SyncPlaySetRepeatModeRequest) async throws

    /// Updates shuffle mode for the SyncPlay group.
    ///
    /// - Parameter request: The shuffle-mode payload.
    func syncPlaySetShuffleMode(_ request: SyncPlaySetShuffleModeRequest) async throws

    /// Replaces the SyncPlay group's queue with a new playlist.
    ///
    /// - Parameter request: The new queue payload.
    func syncPlaySetNewQueue(_ request: SyncPlaySetNewQueueRequest) async throws

    /// Queues items into the current SyncPlay group playlist.
    ///
    /// - Parameter request: The queue update payload.
    func syncPlayQueue(_ request: SyncPlayQueueRequest) async throws

    /// Moves an item within the current SyncPlay group playlist.
    ///
    /// - Parameter request: The playlist move request.
    func syncPlayMovePlaylistItem(_ request: SyncPlayMovePlaylistItemRequest) async throws

    /// Removes one or more items from the current SyncPlay group playlist.
    ///
    /// - Parameter request: The playlist removal request.
    func syncPlayRemoveFromPlaylist(_ request: SyncPlayRemoveFromPlaylistRequest) async throws

    /// Updates ignore-wait behavior for the current SyncPlay group member.
    ///
    /// - Parameter request: The ignore-wait state to apply.
    func syncPlaySetIgnoreWait(_ request: SyncPlaySetIgnoreWaitRequest) async throws
}
