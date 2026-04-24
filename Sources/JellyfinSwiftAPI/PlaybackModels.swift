import Foundation

/// Request body for posted playback-info resolution.
public struct PlaybackInfoRequest: Codable, Sendable, Equatable {
    public let maxStreamingBitrate: Int?
    public let startTimeTicks: Int64?
    public let audioStreamIndex: Int?
    public let subtitleStreamIndex: Int?
    public let maxAudioChannels: Int?
    public let mediaSourceId: String?
    public let liveStreamId: String?
    public let enableDirectPlay: Bool?
    public let enableDirectStream: Bool?
    public let enableTranscoding: Bool?
    public let allowVideoStreamCopy: Bool?
    public let allowAudioStreamCopy: Bool?
    public let autoOpenLiveStream: Bool?

    enum CodingKeys: String, CodingKey {
        case maxStreamingBitrate = "MaxStreamingBitrate"
        case startTimeTicks = "StartTimeTicks"
        case audioStreamIndex = "AudioStreamIndex"
        case subtitleStreamIndex = "SubtitleStreamIndex"
        case maxAudioChannels = "MaxAudioChannels"
        case mediaSourceId = "MediaSourceId"
        case liveStreamId = "LiveStreamId"
        case enableDirectPlay = "EnableDirectPlay"
        case enableDirectStream = "EnableDirectStream"
        case enableTranscoding = "EnableTranscoding"
        case allowVideoStreamCopy = "AllowVideoStreamCopy"
        case allowAudioStreamCopy = "AllowAudioStreamCopy"
        case autoOpenLiveStream = "AutoOpenLiveStream"
    }

    public init(
        maxStreamingBitrate: Int? = nil,
        startTimeTicks: Int64? = nil,
        audioStreamIndex: Int? = nil,
        subtitleStreamIndex: Int? = nil,
        maxAudioChannels: Int? = nil,
        mediaSourceId: String? = nil,
        liveStreamId: String? = nil,
        enableDirectPlay: Bool? = nil,
        enableDirectStream: Bool? = nil,
        enableTranscoding: Bool? = nil,
        allowVideoStreamCopy: Bool? = nil,
        allowAudioStreamCopy: Bool? = nil,
        autoOpenLiveStream: Bool? = nil
    ) {
        self.maxStreamingBitrate = maxStreamingBitrate
        self.startTimeTicks = startTimeTicks
        self.audioStreamIndex = audioStreamIndex
        self.subtitleStreamIndex = subtitleStreamIndex
        self.maxAudioChannels = maxAudioChannels
        self.mediaSourceId = mediaSourceId
        self.liveStreamId = liveStreamId
        self.enableDirectPlay = enableDirectPlay
        self.enableDirectStream = enableDirectStream
        self.enableTranscoding = enableTranscoding
        self.allowVideoStreamCopy = allowVideoStreamCopy
        self.allowAudioStreamCopy = allowAudioStreamCopy
        self.autoOpenLiveStream = autoOpenLiveStream
    }
}

/// Common direct-stream request options shared by audio and video endpoints.
public struct StreamRequestOptions: Sendable, Equatable {
    public var container: String?
    public var isStatic: Bool?
    public var params: String?
    public var tag: String?
    public var deviceProfileId: String?
    public var playSessionId: String?
    public var segmentContainer: String?
    public var segmentLength: Int?
    public var minSegments: Int?
    public var mediaSourceId: String?
    public var deviceId: String?
    public var audioCodec: String?
    public var enableAutoStreamCopy: Bool?
    public var allowVideoStreamCopy: Bool?
    public var allowAudioStreamCopy: Bool?
    public var breakOnNonKeyFrames: Bool?
    public var audioSampleRate: Int?
    public var maxAudioBitDepth: Int?
    public var maxStreamingBitrate: Int?
    public var audioBitRate: Int?
    public var audioChannels: Int?
    public var maxAudioChannels: Int?
    public var profile: String?
    public var level: String?
    public var frameRate: Double?
    public var maxFrameRate: Double?
    public var copyTimestamps: Bool?
    public var startTimeTicks: Int64?
    public var width: Int?
    public var height: Int?
    public var maxWidth: Int?
    public var maxHeight: Int?
    public var videoBitRate: Int?
    public var subtitleStreamIndex: Int?
    public var maxRefFrames: Int?
    public var maxVideoBitDepth: Int?
    public var requireAVC: Bool?
    public var deinterlace: Bool?
    public var requireNonAnamorphic: Bool?
    public var transcodingMaxAudioChannels: Int?
    public var cpuCoreLimit: Int?
    public var liveStreamId: String?
    public var enableMpegtsM2TsMode: Bool?
    public var videoCodec: String?
    public var subtitleCodec: String?
    public var transcodeReasons: String?
    public var audioStreamIndex: Int?
    public var videoStreamIndex: Int?
    public var enableAdaptiveBitrateStreaming: Bool?
    public var enableSubtitlesInManifest: Bool?
    public var enableAudioVbrEncoding: Bool?
    public var alwaysBurnInSubtitleWhenTranscoding: Bool?
    public var additionalQueryItems: [URLQueryItem]

    public init(
        container: String? = nil,
        isStatic: Bool? = nil,
        params: String? = nil,
        tag: String? = nil,
        deviceProfileId: String? = nil,
        playSessionId: String? = nil,
        segmentContainer: String? = nil,
        segmentLength: Int? = nil,
        minSegments: Int? = nil,
        mediaSourceId: String? = nil,
        deviceId: String? = nil,
        audioCodec: String? = nil,
        enableAutoStreamCopy: Bool? = nil,
        allowVideoStreamCopy: Bool? = nil,
        allowAudioStreamCopy: Bool? = nil,
        breakOnNonKeyFrames: Bool? = nil,
        audioSampleRate: Int? = nil,
        maxAudioBitDepth: Int? = nil,
        maxStreamingBitrate: Int? = nil,
        audioBitRate: Int? = nil,
        audioChannels: Int? = nil,
        maxAudioChannels: Int? = nil,
        profile: String? = nil,
        level: String? = nil,
        frameRate: Double? = nil,
        maxFrameRate: Double? = nil,
        copyTimestamps: Bool? = nil,
        startTimeTicks: Int64? = nil,
        width: Int? = nil,
        height: Int? = nil,
        maxWidth: Int? = nil,
        maxHeight: Int? = nil,
        videoBitRate: Int? = nil,
        subtitleStreamIndex: Int? = nil,
        maxRefFrames: Int? = nil,
        maxVideoBitDepth: Int? = nil,
        requireAVC: Bool? = nil,
        deinterlace: Bool? = nil,
        requireNonAnamorphic: Bool? = nil,
        transcodingMaxAudioChannels: Int? = nil,
        cpuCoreLimit: Int? = nil,
        liveStreamId: String? = nil,
        enableMpegtsM2TsMode: Bool? = nil,
        videoCodec: String? = nil,
        subtitleCodec: String? = nil,
        transcodeReasons: String? = nil,
        audioStreamIndex: Int? = nil,
        videoStreamIndex: Int? = nil,
        enableAdaptiveBitrateStreaming: Bool? = nil,
        enableSubtitlesInManifest: Bool? = nil,
        enableAudioVbrEncoding: Bool? = nil,
        alwaysBurnInSubtitleWhenTranscoding: Bool? = nil,
        additionalQueryItems: [URLQueryItem] = []
    ) {
        self.container = container
        self.isStatic = isStatic
        self.params = params
        self.tag = tag
        self.deviceProfileId = deviceProfileId
        self.playSessionId = playSessionId
        self.segmentContainer = segmentContainer
        self.segmentLength = segmentLength
        self.minSegments = minSegments
        self.mediaSourceId = mediaSourceId
        self.deviceId = deviceId
        self.audioCodec = audioCodec
        self.enableAutoStreamCopy = enableAutoStreamCopy
        self.allowVideoStreamCopy = allowVideoStreamCopy
        self.allowAudioStreamCopy = allowAudioStreamCopy
        self.breakOnNonKeyFrames = breakOnNonKeyFrames
        self.audioSampleRate = audioSampleRate
        self.maxAudioBitDepth = maxAudioBitDepth
        self.maxStreamingBitrate = maxStreamingBitrate
        self.audioBitRate = audioBitRate
        self.audioChannels = audioChannels
        self.maxAudioChannels = maxAudioChannels
        self.profile = profile
        self.level = level
        self.frameRate = frameRate
        self.maxFrameRate = maxFrameRate
        self.copyTimestamps = copyTimestamps
        self.startTimeTicks = startTimeTicks
        self.width = width
        self.height = height
        self.maxWidth = maxWidth
        self.maxHeight = maxHeight
        self.videoBitRate = videoBitRate
        self.subtitleStreamIndex = subtitleStreamIndex
        self.maxRefFrames = maxRefFrames
        self.maxVideoBitDepth = maxVideoBitDepth
        self.requireAVC = requireAVC
        self.deinterlace = deinterlace
        self.requireNonAnamorphic = requireNonAnamorphic
        self.transcodingMaxAudioChannels = transcodingMaxAudioChannels
        self.cpuCoreLimit = cpuCoreLimit
        self.liveStreamId = liveStreamId
        self.enableMpegtsM2TsMode = enableMpegtsM2TsMode
        self.videoCodec = videoCodec
        self.subtitleCodec = subtitleCodec
        self.transcodeReasons = transcodeReasons
        self.audioStreamIndex = audioStreamIndex
        self.videoStreamIndex = videoStreamIndex
        self.enableAdaptiveBitrateStreaming = enableAdaptiveBitrateStreaming
        self.enableSubtitlesInManifest = enableSubtitlesInManifest
        self.enableAudioVbrEncoding = enableAudioVbrEncoding
        self.alwaysBurnInSubtitleWhenTranscoding = alwaysBurnInSubtitleWhenTranscoding
        self.additionalQueryItems = additionalQueryItems
    }
}

/// Request options for universal audio streams.
public struct UniversalAudioRequestOptions: Sendable, Equatable {
    public var containers: [String]
    public var mediaSourceId: String?
    public var deviceId: String?
    public var userID: UUID?
    public var audioCodec: String?
    public var maxAudioChannels: Int?
    public var transcodingAudioChannels: Int?
    public var maxStreamingBitrate: Int?
    public var audioBitRate: Int?
    public var startTimeTicks: Int64?
    public var transcodingContainer: String?
    public var maxAudioSampleRate: Int?
    public var maxAudioBitDepth: Int?
    public var enableRemoteMedia: Bool?
    public var enableAudioVbrEncoding: Bool?
    public var breakOnNonKeyFrames: Bool?
    public var enableRedirection: Bool?
    public var additionalQueryItems: [URLQueryItem]

    public init(
        containers: [String] = [],
        mediaSourceId: String? = nil,
        deviceId: String? = nil,
        userID: UUID? = nil,
        audioCodec: String? = nil,
        maxAudioChannels: Int? = nil,
        transcodingAudioChannels: Int? = nil,
        maxStreamingBitrate: Int? = nil,
        audioBitRate: Int? = nil,
        startTimeTicks: Int64? = nil,
        transcodingContainer: String? = nil,
        maxAudioSampleRate: Int? = nil,
        maxAudioBitDepth: Int? = nil,
        enableRemoteMedia: Bool? = nil,
        enableAudioVbrEncoding: Bool? = nil,
        breakOnNonKeyFrames: Bool? = nil,
        enableRedirection: Bool? = nil,
        additionalQueryItems: [URLQueryItem] = []
    ) {
        self.containers = containers
        self.mediaSourceId = mediaSourceId
        self.deviceId = deviceId
        self.userID = userID
        self.audioCodec = audioCodec
        self.maxAudioChannels = maxAudioChannels
        self.transcodingAudioChannels = transcodingAudioChannels
        self.maxStreamingBitrate = maxStreamingBitrate
        self.audioBitRate = audioBitRate
        self.startTimeTicks = startTimeTicks
        self.transcodingContainer = transcodingContainer
        self.maxAudioSampleRate = maxAudioSampleRate
        self.maxAudioBitDepth = maxAudioBitDepth
        self.enableRemoteMedia = enableRemoteMedia
        self.enableAudioVbrEncoding = enableAudioVbrEncoding
        self.breakOnNonKeyFrames = breakOnNonKeyFrames
        self.enableRedirection = enableRedirection
        self.additionalQueryItems = additionalQueryItems
    }
}

/// Playback-info response.
public struct PlaybackInfoResponse: Codable, Sendable, Equatable {
    public let mediaSources: [MediaSource]
    public let playSessionId: String?
    public let errorCode: PlaybackErrorCode?

    enum CodingKeys: String, CodingKey {
        case mediaSources = "MediaSources"
        case playSessionId = "PlaySessionId"
        case errorCode = "ErrorCode"
    }
}

/// Minimal media-source description used by playback-info responses.
public struct MediaSource: Codable, Sendable, Equatable {
    public let id: String?
    public let path: String?
    public let container: String?
    public let name: String?
    public let supportsTranscoding: Bool?
    public let supportsDirectStream: Bool?
    public let supportsDirectPlay: Bool?
    public let mediaStreams: [MediaStream]?
    public let bitrate: Int?
    public let transcodingUrl: String?
    public let transcodingContainer: String?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case path = "Path"
        case container = "Container"
        case name = "Name"
        case supportsTranscoding = "SupportsTranscoding"
        case supportsDirectStream = "SupportsDirectStream"
        case supportsDirectPlay = "SupportsDirectPlay"
        case mediaStreams = "MediaStreams"
        case bitrate = "Bitrate"
        case transcodingUrl = "TranscodingUrl"
        case transcodingContainer = "TranscodingContainer"
    }
}

/// Minimal media-stream description used by playback-info responses.
public struct MediaStream: Codable, Sendable, Equatable {
    public let codec: String?
    public let language: String?
    public let title: String?
    public let displayTitle: String?
    public let bitRate: Int?
    public let channels: Int?
    public let sampleRate: Int?
    public let isDefault: Bool?
    public let isForced: Bool?
    public let width: Int?
    public let height: Int?
    public let type: MediaStreamType?
    public let index: Int?

    enum CodingKeys: String, CodingKey {
        case codec = "Codec"
        case language = "Language"
        case title = "Title"
        case displayTitle = "DisplayTitle"
        case bitRate = "BitRate"
        case channels = "Channels"
        case sampleRate = "SampleRate"
        case isDefault = "IsDefault"
        case isForced = "IsForced"
        case width = "Width"
        case height = "Height"
        case type = "Type"
        case index = "Index"
    }
}

/// Media-stream categories surfaced by Jellyfin playback metadata.
public enum MediaStreamType: String, Codable, Sendable, Equatable {
    case audio = "Audio"
    case video = "Video"
    case subtitle = "Subtitle"
    case embeddedImage = "EmbeddedImage"
    case data = "Data"
    case lyric = "Lyric"
}

/// Playback resolution errors surfaced by Jellyfin.
public enum PlaybackErrorCode: String, Codable, Sendable, Equatable {
    case notAllowed = "NotAllowed"
    case noCompatibleStream = "NoCompatibleStream"
    case rateLimitExceeded = "RateLimitExceeded"
}

/// Fallback font metadata.
public struct FontFile: Codable, Sendable, Equatable {
    public let name: String?
    public let size: Int64?
    public let dateCreated: Date?
    public let dateModified: Date?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case size = "Size"
        case dateCreated = "DateCreated"
        case dateModified = "DateModified"
    }
}

/// Playback media segment metadata.
public struct MediaSegment: Codable, Sendable, Equatable {
    public let id: UUID?
    public let itemId: UUID?
    public let type: MediaSegmentType?
    public let startTicks: Int64?
    public let endTicks: Int64?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case itemId = "ItemId"
        case type = "Type"
        case startTicks = "StartTicks"
        case endTicks = "EndTicks"
    }
}

/// Segment categories emitted by Jellyfin.
public enum MediaSegmentType: String, Codable, Sendable, Equatable {
    case unknown = "Unknown"
    case commercial = "Commercial"
    case preview = "Preview"
    case recap = "Recap"
    case outro = "Outro"
    case intro = "Intro"
}

/// Lyric response payload.
public struct Lyric: Codable, Sendable, Equatable {
    public let metadata: LyricMetadata?
    public let lyrics: [LyricLine]

    enum CodingKeys: String, CodingKey {
        case metadata = "Metadata"
        case lyrics = "Lyrics"
    }
}

/// High-level lyric metadata.
public struct LyricMetadata: Codable, Sendable, Equatable {
    public let artist: String?
    public let album: String?
    public let title: String?
    public let author: String?
    public let length: Int64?
    public let by: String?
    public let offset: Int64?
    public let creator: String?
    public let version: String?
    public let isSynced: Bool?

    enum CodingKeys: String, CodingKey {
        case artist = "Artist"
        case album = "Album"
        case title = "Title"
        case author = "Author"
        case length = "Length"
        case by = "By"
        case offset = "Offset"
        case creator = "Creator"
        case version = "Version"
        case isSynced = "IsSynced"
    }
}

/// A single lyric line.
public struct LyricLine: Codable, Sendable, Equatable {
    public let text: String?
    public let start: Int64?
    public let cues: [LyricLineCue]?

    enum CodingKeys: String, CodingKey {
        case text = "Text"
        case start = "Start"
        case cues = "Cues"
    }
}

/// Cue timing for a portion of a lyric line.
public struct LyricLineCue: Codable, Sendable, Equatable {
    public let position: Int?
    public let endPosition: Int?
    public let start: Int64?
    public let end: Int64?

    enum CodingKeys: String, CodingKey {
        case position = "Position"
        case endPosition = "EndPosition"
        case start = "Start"
        case end = "End"
    }
}

/// A remote lyric search result.
public struct RemoteLyricInfo: Codable, Sendable, Equatable {
    public let id: String?
    public let providerName: String?
    public let lyrics: Lyric?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case providerName = "ProviderName"
        case lyrics = "Lyrics"
    }
}

/// A remote subtitle search result.
public struct RemoteSubtitleInfo: Codable, Sendable, Equatable {
    public let threeLetterISOLanguageName: String?
    public let id: String?
    public let providerName: String?
    public let name: String?
    public let format: String?
    public let author: String?
    public let comment: String?
    public let dateCreated: Date?
    public let communityRating: Double?
    public let frameRate: Double?
    public let downloadCount: Int?
    public let isHashMatch: Bool?
    public let aiTranslated: Bool?
    public let machineTranslated: Bool?
    public let forced: Bool?
    public let hearingImpaired: Bool?

    enum CodingKeys: String, CodingKey {
        case threeLetterISOLanguageName = "ThreeLetterISOLanguageName"
        case id = "Id"
        case providerName = "ProviderName"
        case name = "Name"
        case format = "Format"
        case author = "Author"
        case comment = "Comment"
        case dateCreated = "DateCreated"
        case communityRating = "CommunityRating"
        case frameRate = "FrameRate"
        case downloadCount = "DownloadCount"
        case isHashMatch = "IsHashMatch"
        case aiTranslated = "AiTranslated"
        case machineTranslated = "MachineTranslated"
        case forced = "Forced"
        case hearingImpaired = "HearingImpaired"
    }
}

/// Request for subtitle stream retrieval.
public struct SubtitleStreamRequest: Sendable, Equatable {
    public let itemID: UUID
    public let mediaSourceID: String
    public let index: Int
    public let format: String
    public let startPositionTicks: Int64?
    public let endPositionTicks: Int64?
    public let copyTimestamps: Bool?
    public let addVTTTimeMap: Bool?

    public init(
        itemID: UUID,
        mediaSourceID: String,
        index: Int,
        format: String,
        startPositionTicks: Int64? = nil,
        endPositionTicks: Int64? = nil,
        copyTimestamps: Bool? = nil,
        addVTTTimeMap: Bool? = nil
    ) {
        self.itemID = itemID
        self.mediaSourceID = mediaSourceID
        self.index = index
        self.format = format
        self.startPositionTicks = startPositionTicks
        self.endPositionTicks = endPositionTicks
        self.copyTimestamps = copyTimestamps
        self.addVTTTimeMap = addVTTTimeMap
    }
}

/// Request for subtitle upload.
public struct UploadSubtitleRequest: Codable, Sendable, Equatable {
    public let language: String?
    public let format: String
    public let isForced: Bool?
    public let isHearingImpaired: Bool?
    public let data: String

    enum CodingKeys: String, CodingKey {
        case language = "Language"
        case format = "Format"
        case isForced = "IsForced"
        case isHearingImpaired = "IsHearingImpaired"
        case data = "Data"
    }

    public init(
        language: String? = nil,
        format: String,
        isForced: Bool? = nil,
        isHearingImpaired: Bool? = nil,
        data: String
    ) {
        self.language = language
        self.format = format
        self.isForced = isForced
        self.isHearingImpaired = isHearingImpaired
        self.data = data
    }
}

/// Request for opening a Jellyfin live stream.
public struct OpenLiveStreamRequest: Codable, Sendable, Equatable {
    public let openToken: String?
    public let userID: UUID?
    public let playSessionId: String?
    public let maxStreamingBitrate: Int?
    public let startTimeTicks: Int64?
    public let audioStreamIndex: Int?
    public let subtitleStreamIndex: Int?
    public let maxAudioChannels: Int?
    public let itemID: UUID?
    public let enableDirectPlay: Bool?
    public let enableDirectStream: Bool?
    public let alwaysBurnInSubtitleWhenTranscoding: Bool?

    enum CodingKeys: String, CodingKey {
        case openToken = "OpenToken"
        case userID = "UserID"
        case playSessionId = "PlaySessionId"
        case maxStreamingBitrate = "MaxStreamingBitrate"
        case startTimeTicks = "StartTimeTicks"
        case audioStreamIndex = "AudioStreamIndex"
        case subtitleStreamIndex = "SubtitleStreamIndex"
        case maxAudioChannels = "MaxAudioChannels"
        case itemID = "ItemID"
        case enableDirectPlay = "EnableDirectPlay"
        case enableDirectStream = "EnableDirectStream"
        case alwaysBurnInSubtitleWhenTranscoding = "AlwaysBurnInSubtitleWhenTranscoding"
    }

    public init(
        openToken: String? = nil,
        userID: UUID? = nil,
        playSessionId: String? = nil,
        maxStreamingBitrate: Int? = nil,
        startTimeTicks: Int64? = nil,
        audioStreamIndex: Int? = nil,
        subtitleStreamIndex: Int? = nil,
        maxAudioChannels: Int? = nil,
        itemID: UUID? = nil,
        enableDirectPlay: Bool? = nil,
        enableDirectStream: Bool? = nil,
        alwaysBurnInSubtitleWhenTranscoding: Bool? = nil
    ) {
        self.openToken = openToken
        self.userID = userID
        self.playSessionId = playSessionId
        self.maxStreamingBitrate = maxStreamingBitrate
        self.startTimeTicks = startTimeTicks
        self.audioStreamIndex = audioStreamIndex
        self.subtitleStreamIndex = subtitleStreamIndex
        self.maxAudioChannels = maxAudioChannels
        self.itemID = itemID
        self.enableDirectPlay = enableDirectPlay
        self.enableDirectStream = enableDirectStream
        self.alwaysBurnInSubtitleWhenTranscoding = alwaysBurnInSubtitleWhenTranscoding
    }
}

/// Live stream opening response.
public struct LiveStreamResponse: Codable, Sendable, Equatable {
    public let mediaSource: MediaSource?

    enum CodingKeys: String, CodingKey {
        case mediaSource = "MediaSource"
    }
}

/// Request for dynamic HLS audio segment retrieval.
public struct HLSAudioSegmentRequest: Sendable, Equatable {
    public let itemID: UUID
    public let playlistID: String
    public let segmentID: Int
    public let container: String
    public let runtimeTicks: Int64
    public let actualSegmentLengthTicks: Int64
    public var query: StreamRequestOptions

    public init(
        itemID: UUID,
        playlistID: String,
        segmentID: Int,
        container: String,
        runtimeTicks: Int64,
        actualSegmentLengthTicks: Int64,
        query: StreamRequestOptions = StreamRequestOptions()
    ) {
        self.itemID = itemID
        self.playlistID = playlistID
        self.segmentID = segmentID
        self.container = container
        self.runtimeTicks = runtimeTicks
        self.actualSegmentLengthTicks = actualSegmentLengthTicks
        self.query = query
    }
}

/// Request for dynamic HLS video segment retrieval.
public struct HLSVideoSegmentRequest: Sendable, Equatable {
    public let itemID: UUID
    public let playlistID: String
    public let segmentID: Int
    public let container: String
    public let runtimeTicks: Int64
    public let actualSegmentLengthTicks: Int64
    public var query: StreamRequestOptions

    public init(
        itemID: UUID,
        playlistID: String,
        segmentID: Int,
        container: String,
        runtimeTicks: Int64,
        actualSegmentLengthTicks: Int64,
        query: StreamRequestOptions = StreamRequestOptions()
    ) {
        self.itemID = itemID
        self.playlistID = playlistID
        self.segmentID = segmentID
        self.container = container
        self.runtimeTicks = runtimeTicks
        self.actualSegmentLengthTicks = actualSegmentLengthTicks
        self.query = query
    }
}

/// Legacy HLS audio segment container extensions.
public enum AudioSegmentContainer: String, Sendable, Equatable {
    case aac
    case mp3
}
