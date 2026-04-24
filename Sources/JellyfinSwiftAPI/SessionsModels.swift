import Foundation

/// Query options for `/Sessions`.
public struct SessionQuery: Sendable, Equatable {
    public let controllableByUserID: UUID?
    public let deviceID: String?
    public let activeWithinSeconds: Int?

    public init(
        controllableByUserID: UUID? = nil,
        deviceID: String? = nil,
        activeWithinSeconds: Int? = nil
    ) {
        self.controllableByUserID = controllableByUserID
        self.deviceID = deviceID
        self.activeWithinSeconds = activeWithinSeconds
    }
}

/// Metadata about an active Jellyfin session.
public struct SessionInfo: Codable, Sendable, Equatable {
    public let playState: SessionPlayerState?
    public let additionalUsers: [SessionUserInfo]?
    public let capabilities: ClientCapabilities?
    public let remoteEndPoint: String?
    public let playableMediaTypes: [MediaType]?
    public let id: String?
    public let userId: UUID?
    public let userName: String?
    public let client: String?
    public let lastActivityDate: Date?
    public let lastPlaybackCheckIn: Date?
    public let lastPausedDate: Date?
    public let deviceName: String?
    public let deviceType: String?
    public let nowPlayingItem: BaseItem?
    public let nowViewingItem: BaseItem?
    public let deviceId: String?
    public let applicationVersion: String?
    public let transcodingInfo: SessionTranscodingInfo?
    public let isActive: Bool?
    public let supportsMediaControl: Bool?
    public let supportsRemoteControl: Bool?
    public let nowPlayingQueue: [SessionQueueItem]?
    public let nowPlayingQueueFullItems: [BaseItem]?
    public let hasCustomDeviceName: Bool?
    public let playlistItemId: String?
    public let serverId: String?
    public let userPrimaryImageTag: String?
    public let supportedCommands: [SessionGeneralCommand]?
}

/// Additional user metadata attached to a session.
public struct SessionUserInfo: Codable, Sendable, Equatable {
    public let userId: UUID?
    public let userName: String?
}

/// Queue item metadata returned by session and SyncPlay payloads.
public struct SessionQueueItem: Codable, Sendable, Equatable {
    public let id: UUID?
    public let playlistItemId: String?
}

/// Active playback state for a session.
public struct SessionPlayerState: Codable, Sendable, Equatable {
    public let positionTicks: Int64?
    public let canSeek: Bool?
    public let isPaused: Bool?
    public let isMuted: Bool?
    public let volumeLevel: Int?
    public let audioStreamIndex: Int?
    public let subtitleStreamIndex: Int?
    public let mediaSourceId: String?
    public let playMethod: SessionPlayMethod?
    public let repeatMode: SessionRepeatMode?
    public let playbackOrder: SessionPlaybackOrder?
    public let liveStreamId: String?
}

/// Transcoding metadata for an active session.
public struct SessionTranscodingInfo: Codable, Sendable, Equatable {
    public let audioCodec: String?
    public let videoCodec: String?
    public let container: String?
    public let isVideoDirect: Bool?
    public let isAudioDirect: Bool?
    public let bitrate: Int?
    public let framerate: Double?
    public let completionPercentage: Double?
    public let width: Int?
    public let height: Int?
    public let audioChannels: Int?
    public let hardwareAccelerationType: String?
    public let transcodeReasons: [String]?
}

/// General command names accepted by session command endpoints.
public enum SessionGeneralCommand: String, Codable, Sendable, Equatable {
    case moveUp = "MoveUp"
    case moveDown = "MoveDown"
    case moveLeft = "MoveLeft"
    case moveRight = "MoveRight"
    case pageUp = "PageUp"
    case pageDown = "PageDown"
    case previousLetter = "PreviousLetter"
    case nextLetter = "NextLetter"
    case toggleOsd = "ToggleOsd"
    case toggleContextMenu = "ToggleContextMenu"
    case select = "Select"
    case back = "Back"
    case takeScreenshot = "TakeScreenshot"
    case sendKey = "SendKey"
    case sendString = "SendString"
    case goHome = "GoHome"
    case goToSettings = "GoToSettings"
    case volumeUp = "VolumeUp"
    case volumeDown = "VolumeDown"
    case mute = "Mute"
    case unmute = "Unmute"
    case toggleMute = "ToggleMute"
    case setVolume = "SetVolume"
    case setAudioStreamIndex = "SetAudioStreamIndex"
    case setSubtitleStreamIndex = "SetSubtitleStreamIndex"
    case toggleFullscreen = "ToggleFullscreen"
    case displayContent = "DisplayContent"
    case goToSearch = "GoToSearch"
    case displayMessage = "DisplayMessage"
    case setRepeatMode = "SetRepeatMode"
    case channelUp = "ChannelUp"
    case channelDown = "ChannelDown"
    case guide = "Guide"
    case toggleStats = "ToggleStats"
    case playMediaSource = "PlayMediaSource"
    case playTrailers = "PlayTrailers"
    case setShuffleQueue = "SetShuffleQueue"
    case playState = "PlayState"
    case playNext = "PlayNext"
    case toggleOsdMenu = "ToggleOsdMenu"
    case play = "Play"
    case setMaxStreamingBitrate = "SetMaxStreamingBitrate"
    case setPlaybackOrder = "SetPlaybackOrder"
}

/// Request body for `/Sessions/{sessionId}/Command`.
public struct GeneralCommand: Codable, Sendable, Equatable {
    public let name: SessionGeneralCommand?
    public let controllingUserId: UUID?
    public let arguments: [String: String]?

    public init(
        name: SessionGeneralCommand? = nil,
        controllingUserId: UUID? = nil,
        arguments: [String: String]? = nil
    ) {
        self.name = name
        self.controllingUserId = controllingUserId
        self.arguments = arguments
    }
}

/// Request body for `/Sessions/{sessionId}/Message`.
public struct MessageCommand: Codable, Sendable, Equatable {
    public let header: String?
    public let text: String
    public let timeoutMs: Int?

    public init(header: String? = nil, text: String, timeoutMs: Int? = nil) {
        self.header = header
        self.text = text
        self.timeoutMs = timeoutMs
    }
}

/// Query model for `/Sessions/{sessionId}/Playing`.
public struct SessionPlayRequest: Sendable, Equatable {
    public let playCommand: SessionPlayCommand
    public let itemIDs: [String]
    public let startPositionTicks: Int64?
    public let mediaSourceID: String?
    public let audioStreamIndex: Int?
    public let subtitleStreamIndex: Int?
    public let startIndex: Int?

    public init(
        playCommand: SessionPlayCommand,
        itemIDs: [String],
        startPositionTicks: Int64? = nil,
        mediaSourceID: String? = nil,
        audioStreamIndex: Int? = nil,
        subtitleStreamIndex: Int? = nil,
        startIndex: Int? = nil
    ) {
        self.playCommand = playCommand
        self.itemIDs = itemIDs
        self.startPositionTicks = startPositionTicks
        self.mediaSourceID = mediaSourceID
        self.audioStreamIndex = audioStreamIndex
        self.subtitleStreamIndex = subtitleStreamIndex
        self.startIndex = startIndex
    }
}

/// Play command values for session playback control.
public enum SessionPlayCommand: String, Codable, Sendable, Equatable {
    case playNow = "PlayNow"
    case playNext = "PlayNext"
    case playLast = "PlayLast"
    case playInstantMix = "PlayInstantMix"
    case playShuffle = "PlayShuffle"
}

/// Playstate command values for `/Sessions/{sessionId}/Playing/{command}`.
public enum SessionPlaystateCommand: String, Codable, Sendable, Equatable {
    case stop = "Stop"
    case pause = "Pause"
    case unpause = "Unpause"
    case nextTrack = "NextTrack"
    case previousTrack = "PreviousTrack"
    case seek = "Seek"
    case rewind = "Rewind"
    case fastForward = "FastForward"
    case playPause = "PlayPause"
}

/// Query model for playstate commands.
public struct SessionPlaystateCommandRequest: Sendable, Equatable {
    public let command: SessionPlaystateCommand
    public let seekPositionTicks: Int64?
    public let controllingUserID: UUID?

    public init(
        command: SessionPlaystateCommand,
        seekPositionTicks: Int64? = nil,
        controllingUserID: UUID? = nil
    ) {
        self.command = command
        self.seekPositionTicks = seekPositionTicks
        self.controllingUserID = controllingUserID
    }
}

/// Query model for `/Sessions/{sessionId}/Viewing`.
public struct SessionDisplayRequest: Sendable, Equatable {
    public let itemType: SessionDisplayItemType
    public let itemID: String
    public let itemName: String

    public init(itemType: SessionDisplayItemType, itemID: String, itemName: String) {
        self.itemType = itemType
        self.itemID = itemID
        self.itemName = itemName
    }
}

/// Item types accepted by the display-content session endpoint.
public enum SessionDisplayItemType: String, Codable, Sendable, Equatable {
    case aggregateFolder = "AggregateFolder"
    case audio = "Audio"
    case audioBook = "AudioBook"
    case basePluginFolder = "BasePluginFolder"
    case book = "Book"
    case boxSet = "BoxSet"
    case channel = "Channel"
    case channelFolderItem = "ChannelFolderItem"
    case collectionFolder = "CollectionFolder"
    case episode = "Episode"
    case folder = "Folder"
    case genre = "Genre"
    case manualPlaylistsFolder = "ManualPlaylistsFolder"
    case movie = "Movie"
    case liveTVChannel = "LiveTvChannel"
    case liveTVProgram = "LiveTvProgram"
    case musicAlbum = "MusicAlbum"
    case musicArtist = "MusicArtist"
    case musicGenre = "MusicGenre"
    case musicVideo = "MusicVideo"
    case person = "Person"
    case photo = "Photo"
    case photoAlbum = "PhotoAlbum"
    case playlist = "Playlist"
    case playlistsFolder = "PlaylistsFolder"
    case program = "Program"
    case recording = "Recording"
    case season = "Season"
    case series = "Series"
    case studio = "Studio"
    case trailer = "Trailer"
    case tvChannel = "TvChannel"
    case tvProgram = "TvProgram"
    case userRootFolder = "UserRootFolder"
    case userView = "UserView"
    case video = "Video"
    case year = "Year"
}

/// Query model for `/Sessions/Capabilities`.
public struct SessionCapabilitiesQuery: Sendable, Equatable {
    public let id: String?
    public let playableMediaTypes: [MediaType]
    public let supportedCommands: [SessionGeneralCommand]
    public let supportsMediaControl: Bool?
    public let supportsPersistentIdentifier: Bool?

    public init(
        id: String? = nil,
        playableMediaTypes: [MediaType] = [],
        supportedCommands: [SessionGeneralCommand] = [],
        supportsMediaControl: Bool? = nil,
        supportsPersistentIdentifier: Bool? = nil
    ) {
        self.id = id
        self.playableMediaTypes = playableMediaTypes
        self.supportedCommands = supportedCommands
        self.supportsMediaControl = supportsMediaControl
        self.supportsPersistentIdentifier = supportsPersistentIdentifier
    }
}

/// Query model for `/Sessions/Viewing`.
public struct ViewingRequest: Sendable, Equatable {
    public let sessionID: String?
    public let itemID: String

    public init(sessionID: String? = nil, itemID: String) {
        self.sessionID = sessionID
        self.itemID = itemID
    }
}

/// Query model for `/PlayingItems/{itemId}`.
public struct LegacyPlaybackStartRequest: Sendable, Equatable {
    public let mediaSourceID: String?
    public let audioStreamIndex: Int?
    public let subtitleStreamIndex: Int?
    public let playMethod: SessionPlayMethod?
    public let liveStreamID: String?
    public let playSessionID: String?
    public let canSeek: Bool?

    public init(
        mediaSourceID: String? = nil,
        audioStreamIndex: Int? = nil,
        subtitleStreamIndex: Int? = nil,
        playMethod: SessionPlayMethod? = nil,
        liveStreamID: String? = nil,
        playSessionID: String? = nil,
        canSeek: Bool? = nil
    ) {
        self.mediaSourceID = mediaSourceID
        self.audioStreamIndex = audioStreamIndex
        self.subtitleStreamIndex = subtitleStreamIndex
        self.playMethod = playMethod
        self.liveStreamID = liveStreamID
        self.playSessionID = playSessionID
        self.canSeek = canSeek
    }
}

/// Query model for `/PlayingItems/{itemId}/Progress`.
public struct LegacyPlaybackProgressRequest: Sendable, Equatable {
    public let mediaSourceID: String?
    public let positionTicks: Int64?
    public let audioStreamIndex: Int?
    public let subtitleStreamIndex: Int?
    public let volumeLevel: Int?
    public let playMethod: SessionPlayMethod?
    public let liveStreamID: String?
    public let playSessionID: String?
    public let repeatMode: SessionRepeatMode?
    public let isPaused: Bool?
    public let isMuted: Bool?

    public init(
        mediaSourceID: String? = nil,
        positionTicks: Int64? = nil,
        audioStreamIndex: Int? = nil,
        subtitleStreamIndex: Int? = nil,
        volumeLevel: Int? = nil,
        playMethod: SessionPlayMethod? = nil,
        liveStreamID: String? = nil,
        playSessionID: String? = nil,
        repeatMode: SessionRepeatMode? = nil,
        isPaused: Bool? = nil,
        isMuted: Bool? = nil
    ) {
        self.mediaSourceID = mediaSourceID
        self.positionTicks = positionTicks
        self.audioStreamIndex = audioStreamIndex
        self.subtitleStreamIndex = subtitleStreamIndex
        self.volumeLevel = volumeLevel
        self.playMethod = playMethod
        self.liveStreamID = liveStreamID
        self.playSessionID = playSessionID
        self.repeatMode = repeatMode
        self.isPaused = isPaused
        self.isMuted = isMuted
    }
}

/// Query model for `/PlayingItems/{itemId}` delete requests.
public struct LegacyPlaybackStopRequest: Sendable, Equatable {
    public let mediaSourceID: String?
    public let nextMediaType: String?
    public let positionTicks: Int64?
    public let liveStreamID: String?
    public let playSessionID: String?

    public init(
        mediaSourceID: String? = nil,
        nextMediaType: String? = nil,
        positionTicks: Int64? = nil,
        liveStreamID: String? = nil,
        playSessionID: String? = nil
    ) {
        self.mediaSourceID = mediaSourceID
        self.nextMediaType = nextMediaType
        self.positionTicks = positionTicks
        self.liveStreamID = liveStreamID
        self.playSessionID = playSessionID
    }
}

/// Play methods used by session state and playback reports.
public enum SessionPlayMethod: String, Codable, Sendable, Equatable {
    case transcode = "Transcode"
    case directStream = "DirectStream"
    case directPlay = "DirectPlay"
}

/// Repeat modes used by session state and playback reports.
public enum SessionRepeatMode: String, Codable, Sendable, Equatable {
    case repeatNone = "RepeatNone"
    case repeatAll = "RepeatAll"
    case repeatOne = "RepeatOne"
}

/// Playback order values used by playback reports.
public enum SessionPlaybackOrder: String, Codable, Sendable, Equatable {
    case `default` = "Default"
    case shuffle = "Shuffle"
}

/// Body model for `/Sessions/Playing`.
public struct PlaybackStartInfo: Codable, Sendable, Equatable {
    public let canSeek: Bool?
    public let itemId: String?
    public let sessionId: String?
    public let mediaSourceId: String?
    public let audioStreamIndex: Int?
    public let subtitleStreamIndex: Int?
    public let isPaused: Bool?
    public let isMuted: Bool?
    public let positionTicks: Int64?
    public let playbackStartTimeTicks: Int64?
    public let volumeLevel: Int?
    public let brightness: Int?
    public let aspectRatio: String?
    public let playMethod: SessionPlayMethod?
    public let liveStreamId: String?
    public let playSessionId: String?
    public let repeatMode: SessionRepeatMode?
    public let playbackOrder: SessionPlaybackOrder?
    public let nowPlayingQueue: [SessionQueueItem]?
    public let playlistItemId: String?

    public init(
        canSeek: Bool? = nil,
        itemId: String? = nil,
        sessionId: String? = nil,
        mediaSourceId: String? = nil,
        audioStreamIndex: Int? = nil,
        subtitleStreamIndex: Int? = nil,
        isPaused: Bool? = nil,
        isMuted: Bool? = nil,
        positionTicks: Int64? = nil,
        playbackStartTimeTicks: Int64? = nil,
        volumeLevel: Int? = nil,
        brightness: Int? = nil,
        aspectRatio: String? = nil,
        playMethod: SessionPlayMethod? = nil,
        liveStreamId: String? = nil,
        playSessionId: String? = nil,
        repeatMode: SessionRepeatMode? = nil,
        playbackOrder: SessionPlaybackOrder? = nil,
        nowPlayingQueue: [SessionQueueItem]? = nil,
        playlistItemId: String? = nil
    ) {
        self.canSeek = canSeek
        self.itemId = itemId
        self.sessionId = sessionId
        self.mediaSourceId = mediaSourceId
        self.audioStreamIndex = audioStreamIndex
        self.subtitleStreamIndex = subtitleStreamIndex
        self.isPaused = isPaused
        self.isMuted = isMuted
        self.positionTicks = positionTicks
        self.playbackStartTimeTicks = playbackStartTimeTicks
        self.volumeLevel = volumeLevel
        self.brightness = brightness
        self.aspectRatio = aspectRatio
        self.playMethod = playMethod
        self.liveStreamId = liveStreamId
        self.playSessionId = playSessionId
        self.repeatMode = repeatMode
        self.playbackOrder = playbackOrder
        self.nowPlayingQueue = nowPlayingQueue
        self.playlistItemId = playlistItemId
    }
}

/// Body model for `/Sessions/Playing/Progress`.
public typealias PlaybackProgressInfo = PlaybackStartInfo

/// Body model for `/Sessions/Playing/Stopped`.
public struct PlaybackStopInfo: Codable, Sendable, Equatable {
    public let itemId: String?
    public let sessionId: String?
    public let mediaSourceId: String?
    public let positionTicks: Int64?
    public let liveStreamId: String?
    public let playSessionId: String?
    public let failed: Bool?
    public let nextMediaType: String?
    public let playlistItemId: String?
    public let nowPlayingQueue: [SessionQueueItem]?

    public init(
        itemId: String? = nil,
        sessionId: String? = nil,
        mediaSourceId: String? = nil,
        positionTicks: Int64? = nil,
        liveStreamId: String? = nil,
        playSessionId: String? = nil,
        failed: Bool? = nil,
        nextMediaType: String? = nil,
        playlistItemId: String? = nil,
        nowPlayingQueue: [SessionQueueItem]? = nil
    ) {
        self.itemId = itemId
        self.sessionId = sessionId
        self.mediaSourceId = mediaSourceId
        self.positionTicks = positionTicks
        self.liveStreamId = liveStreamId
        self.playSessionId = playSessionId
        self.failed = failed
        self.nextMediaType = nextMediaType
        self.playlistItemId = playlistItemId
        self.nowPlayingQueue = nowPlayingQueue
    }
}

/// SyncPlay group metadata.
public struct SyncPlayGroup: Codable, Sendable, Equatable {
    public let groupId: String?
    public let groupName: String?
    public let state: SyncPlayGroupState?
    public let participants: [String]?
    public let lastUpdatedAt: Date?
}

/// SyncPlay group states.
public enum SyncPlayGroupState: String, Codable, Sendable, Equatable {
    case idle = "Idle"
    case waiting = "Waiting"
    case paused = "Paused"
    case playing = "Playing"
}

/// Body model for `/SyncPlay/New`.
public struct SyncPlayNewGroupRequest: Codable, Sendable, Equatable {
    public let groupName: String?

    public init(groupName: String? = nil) {
        self.groupName = groupName
    }
}

/// Body model for `/SyncPlay/Join`.
public struct SyncPlayJoinGroupRequest: Codable, Sendable, Equatable {
    public let groupId: String?

    public init(groupId: String? = nil) {
        self.groupId = groupId
    }
}

/// Shared SyncPlay timing payload used by buffering and ready endpoints.
public struct SyncPlayTimingRequest: Codable, Sendable, Equatable {
    public let when: Date?
    public let positionTicks: Int64?
    public let isPlaying: Bool?
    public let playlistItemId: String?

    public init(
        when: Date? = nil,
        positionTicks: Int64? = nil,
        isPlaying: Bool? = nil,
        playlistItemId: String? = nil
    ) {
        self.when = when
        self.positionTicks = positionTicks
        self.isPlaying = isPlaying
        self.playlistItemId = playlistItemId
    }
}

/// Body model for `/SyncPlay/Ping`.
public struct SyncPlayPingRequest: Codable, Sendable, Equatable {
    public let ping: Int?

    public init(ping: Int? = nil) {
        self.ping = ping
    }
}

/// Body model for `/SyncPlay/Queue`.
public struct SyncPlayQueueRequest: Codable, Sendable, Equatable {
    public let itemIds: [String]?
    public let mode: SyncPlayQueueMode?

    public init(itemIds: [String]? = nil, mode: SyncPlayQueueMode? = nil) {
        self.itemIds = itemIds
        self.mode = mode
    }
}

/// Queue placement mode for SyncPlay queue operations.
public enum SyncPlayQueueMode: String, Codable, Sendable, Equatable {
    case queue = "Queue"
    case queueNext = "QueueNext"
}

/// Body model for `/SyncPlay/MovePlaylistItem`.
public struct SyncPlayMovePlaylistItemRequest: Codable, Sendable, Equatable {
    public let playlistItemId: String?
    public let newIndex: Int?

    public init(playlistItemId: String? = nil, newIndex: Int? = nil) {
        self.playlistItemId = playlistItemId
        self.newIndex = newIndex
    }
}

/// Body model for `/SyncPlay/NextItem` and `/SyncPlay/PreviousItem`.
public struct SyncPlayPlaylistItemRequest: Codable, Sendable, Equatable {
    public let playlistItemId: String?

    public init(playlistItemId: String? = nil) {
        self.playlistItemId = playlistItemId
    }
}

/// Body model for `/SyncPlay/SetPlaylistItem`.
public typealias SyncPlaySetPlaylistItemRequest = SyncPlayPlaylistItemRequest

/// Body model for `/SyncPlay/Seek`.
public struct SyncPlaySeekRequest: Codable, Sendable, Equatable {
    public let positionTicks: Int64?

    public init(positionTicks: Int64? = nil) {
        self.positionTicks = positionTicks
    }
}

/// Body model for `/SyncPlay/SetRepeatMode`.
public struct SyncPlaySetRepeatModeRequest: Codable, Sendable, Equatable {
    public let mode: SessionRepeatMode?

    public init(mode: SessionRepeatMode? = nil) {
        self.mode = mode
    }
}

/// Body model for `/SyncPlay/SetShuffleMode`.
public struct SyncPlaySetShuffleModeRequest: Codable, Sendable, Equatable {
    public let mode: SyncPlayShuffleMode?

    public init(mode: SyncPlayShuffleMode? = nil) {
        self.mode = mode
    }
}

/// Shuffle mode for SyncPlay.
public enum SyncPlayShuffleMode: String, Codable, Sendable, Equatable {
    case sorted = "Sorted"
    case shuffle = "Shuffle"
}

/// Body model for `/SyncPlay/SetNewQueue`.
public struct SyncPlaySetNewQueueRequest: Codable, Sendable, Equatable {
    public let playingQueue: [SessionQueueItem]?
    public let playingItemPosition: Int?
    public let startPositionTicks: Int64?

    public init(
        playingQueue: [SessionQueueItem]? = nil,
        playingItemPosition: Int? = nil,
        startPositionTicks: Int64? = nil
    ) {
        self.playingQueue = playingQueue
        self.playingItemPosition = playingItemPosition
        self.startPositionTicks = startPositionTicks
    }
}

/// Body model for `/SyncPlay/RemoveFromPlaylist`.
public struct SyncPlayRemoveFromPlaylistRequest: Codable, Sendable, Equatable {
    public let playlistItemIds: [String]?
    public let clearPlaylist: Bool?
    public let clearPlayingItem: Bool?

    public init(
        playlistItemIds: [String]? = nil,
        clearPlaylist: Bool? = nil,
        clearPlayingItem: Bool? = nil
    ) {
        self.playlistItemIds = playlistItemIds
        self.clearPlaylist = clearPlaylist
        self.clearPlayingItem = clearPlayingItem
    }
}

/// Body model for `/SyncPlay/SetIgnoreWait`.
public struct SyncPlaySetIgnoreWaitRequest: Codable, Sendable, Equatable {
    public let ignoreWait: Bool?

    public init(ignoreWait: Bool? = nil) {
        self.ignoreWait = ignoreWait
    }
}
