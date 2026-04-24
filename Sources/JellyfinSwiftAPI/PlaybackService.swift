import Foundation

/// Service interface for Jellyfin playback-info and direct stream endpoints.
public protocol PlaybackService: JellyfinService {
    func playbackInfo(itemID: UUID, userID: UUID?) async throws -> PlaybackInfoResponse
    func postedPlaybackInfo(
        itemID: UUID,
        userID: UUID?,
        request: PlaybackInfoRequest
    ) async throws -> PlaybackInfoResponse
    func audioStream(itemID: UUID, query: StreamRequestOptions) async throws -> JellyfinRawData
    func headAudioStream(itemID: UUID, query: StreamRequestOptions) async throws
    func audioStream(itemID: UUID, container: String, query: StreamRequestOptions) async throws -> JellyfinRawData
    func headAudioStream(itemID: UUID, container: String, query: StreamRequestOptions) async throws
    func universalAudioStream(itemID: UUID, query: UniversalAudioRequestOptions) async throws -> JellyfinRawData
    func headUniversalAudioStream(itemID: UUID, query: UniversalAudioRequestOptions) async throws
    func videoStream(itemID: UUID, query: StreamRequestOptions) async throws -> JellyfinRawData
    func headVideoStream(itemID: UUID, query: StreamRequestOptions) async throws
    func videoStream(itemID: UUID, container: String, query: StreamRequestOptions) async throws -> JellyfinRawData
    func headVideoStream(itemID: UUID, container: String, query: StreamRequestOptions) async throws
    func bitrateTestBytes(size: Int?) async throws -> JellyfinRawData
    func additionalParts(itemID: UUID, userID: UUID?) async throws -> BaseItemQueryResult
    func attachment(videoID: UUID, mediaSourceID: String, index: Int) async throws -> JellyfinRawData
    func itemSegments(itemID: UUID) async throws -> [MediaSegment]
    func lyrics(itemID: UUID) async throws -> Lyric
    func uploadLyrics(itemID: UUID, fileName: String, contents: String) async throws -> Lyric
    func deleteLyrics(itemID: UUID) async throws
    func searchRemoteLyrics(itemID: UUID) async throws -> [RemoteLyricInfo]
    func downloadRemoteLyrics(itemID: UUID, lyricID: String) async throws -> Lyric
    func remoteLyrics(lyricID: String) async throws -> Lyric
    func searchRemoteSubtitles(itemID: UUID, language: String, isPerfectMatch: Bool?) async throws -> [RemoteSubtitleInfo]
    func downloadRemoteSubtitles(itemID: UUID, subtitleID: String) async throws
    func remoteSubtitle(subtitleID: String) async throws -> JellyfinRawData
    func subtitle(_ request: SubtitleStreamRequest) async throws -> JellyfinRawData
    func subtitlePlaylist(itemID: UUID, mediaSourceID: String, index: Int, segmentLength: Int) async throws -> JellyfinRawData
    func uploadSubtitle(itemID: UUID, request: UploadSubtitleRequest) async throws
    func deleteSubtitle(itemID: UUID, index: Int) async throws
    func openLiveStream(_ request: OpenLiveStreamRequest) async throws -> LiveStreamResponse
    func closeLiveStream(liveStreamID: String) async throws
    func masterHlsAudioPlaylist(itemID: UUID, query: StreamRequestOptions) async throws -> JellyfinRawData
    func headMasterHlsAudioPlaylist(itemID: UUID, query: StreamRequestOptions) async throws
    func variantHlsAudioPlaylist(itemID: UUID, query: StreamRequestOptions) async throws -> JellyfinRawData
    func hlsAudioSegment(_ request: HLSAudioSegmentRequest) async throws -> JellyfinRawData
    func legacyHlsAudioSegment(itemID: UUID, segmentID: String, container: AudioSegmentContainer) async throws -> JellyfinRawData
    func masterHlsVideoPlaylist(itemID: UUID, query: StreamRequestOptions) async throws -> JellyfinRawData
    func headMasterHlsVideoPlaylist(itemID: UUID, query: StreamRequestOptions) async throws
    func variantHlsVideoPlaylist(itemID: UUID, query: StreamRequestOptions) async throws -> JellyfinRawData
    func liveHlsVideoPlaylist(itemID: UUID, query: StreamRequestOptions) async throws -> JellyfinRawData
    func hlsVideoSegment(_ request: HLSVideoSegmentRequest) async throws -> JellyfinRawData
    func legacyHlsVideoSegment(itemID: UUID, playlistID: String, segmentID: String, segmentContainer: String) async throws -> JellyfinRawData
    func trickplayPlaylist(itemID: UUID, width: Int, mediaSourceID: String?) async throws -> JellyfinRawData
    func trickplayTile(itemID: UUID, width: Int, index: Int, mediaSourceID: String?) async throws -> JellyfinRawData
    func stopEncodingProcess(deviceID: String, playSessionID: String) async throws
    func mergeVersions(itemIDs: [UUID]) async throws
    func deleteAlternateSources(itemID: UUID) async throws
    func fallbackFontList() async throws -> [FontFile]
    func fallbackFont(named name: String) async throws -> JellyfinRawData
}
