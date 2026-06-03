import Foundation

/// Service interface for Jellyfin playback-info and direct stream endpoints.
public protocol PlaybackService: JellyfinService {
    /// Gets live playback media information for an item.
    ///
    /// - Parameters:
    ///   - itemID: The item identifier to inspect.
    ///   - userID: The user identifier whose playback context should be used. When omitted, Jellyfin uses the current user.
    /// - Returns: The playback sources, transcoding options, and stream details Jellyfin can provide for the item.
    func playbackInfo(itemID: UUID, userID: UUID?) async throws -> PlaybackInfoResponse

    /// Gets live playback media information for an item using the full playback-info request payload.
    ///
    /// - Parameters:
    ///   - itemID: The item identifier to inspect.
    ///   - userID: The user identifier whose playback context should be used. When omitted, Jellyfin uses the current user.
    ///   - request: The playback preferences and capability hints to send to Jellyfin.
    /// - Returns: The playback sources, transcoding options, and stream details Jellyfin can provide for the item.
    func postedPlaybackInfo(
        itemID: UUID,
        userID: UUID?,
        request: PlaybackInfoRequest
    ) async throws -> PlaybackInfoResponse

    /// Opens the default direct audio stream endpoint for an item.
    ///
    /// - Parameters:
    ///   - itemID: The audio item identifier.
    ///   - query: Streaming and transcoding options such as media source, bitrate, and stream selection.
    /// - Returns: The raw response body returned by Jellyfin for the stream.
    func audioStream(itemID: UUID, query: StreamRequestOptions) async throws -> JellyfinRawData

    /// Issues a `HEAD` request for the default direct audio stream endpoint.
    ///
    /// - Parameters:
    ///   - itemID: The audio item identifier.
    ///   - query: Streaming and transcoding options such as media source, bitrate, and stream selection.
    func headAudioStream(itemID: UUID, query: StreamRequestOptions) async throws

    /// Opens a container-specific direct audio stream endpoint for an item.
    ///
    /// - Parameters:
    ///   - itemID: The audio item identifier.
    ///   - container: The desired output container extension, such as `mp3`.
    ///   - query: Streaming and transcoding options such as media source, bitrate, and stream selection.
    /// - Returns: The raw response body returned by Jellyfin for the stream.
    func audioStream(itemID: UUID, container: String, query: StreamRequestOptions) async throws -> JellyfinRawData

    /// Issues a `HEAD` request for a container-specific direct audio stream endpoint.
    ///
    /// - Parameters:
    ///   - itemID: The audio item identifier.
    ///   - container: The desired output container extension.
    ///   - query: Streaming and transcoding options such as media source, bitrate, and stream selection.
    func headAudioStream(itemID: UUID, container: String, query: StreamRequestOptions) async throws

    /// Opens Jellyfin's universal audio endpoint for an item.
    ///
    /// - Parameters:
    ///   - itemID: The audio item identifier.
    ///   - query: Universal audio streaming options, including codec, bitrate, and transcoding preferences.
    /// - Returns: The raw response body returned by Jellyfin for the stream.
    func universalAudioStream(itemID: UUID, query: UniversalAudioRequestOptions) async throws -> JellyfinRawData

    /// Issues a `HEAD` request for Jellyfin's universal audio endpoint.
    ///
    /// - Parameters:
    ///   - itemID: The audio item identifier.
    ///   - query: Universal audio streaming options, including codec, bitrate, and transcoding preferences.
    func headUniversalAudioStream(itemID: UUID, query: UniversalAudioRequestOptions) async throws

    /// Opens the default direct video stream endpoint for an item.
    ///
    /// - Parameters:
    ///   - itemID: The video item identifier.
    ///   - query: Streaming and transcoding options such as media source, bitrate, and subtitle selection.
    /// - Returns: The raw response body returned by Jellyfin for the stream.
    func videoStream(itemID: UUID, query: StreamRequestOptions) async throws -> JellyfinRawData

    /// Issues a `HEAD` request for the default direct video stream endpoint.
    ///
    /// - Parameters:
    ///   - itemID: The video item identifier.
    ///   - query: Streaming and transcoding options such as media source, bitrate, and subtitle selection.
    func headVideoStream(itemID: UUID, query: StreamRequestOptions) async throws

    /// Opens a container-specific direct video stream endpoint for an item.
    ///
    /// - Parameters:
    ///   - itemID: The video item identifier.
    ///   - container: The desired output container extension, such as `mp4`.
    ///   - query: Streaming and transcoding options such as media source, bitrate, and subtitle selection.
    /// - Returns: The raw response body returned by Jellyfin for the stream.
    func videoStream(itemID: UUID, container: String, query: StreamRequestOptions) async throws -> JellyfinRawData

    /// Issues a `HEAD` request for a container-specific direct video stream endpoint.
    ///
    /// - Parameters:
    ///   - itemID: The video item identifier.
    ///   - container: The desired output container extension.
    ///   - query: Streaming and transcoding options such as media source, bitrate, and subtitle selection.
    func headVideoStream(itemID: UUID, container: String, query: StreamRequestOptions) async throws

    /// Downloads bitrate-test bytes from Jellyfin.
    ///
    /// - Parameter size: An optional byte count to request.
    /// - Returns: The raw response body containing test bytes.
    func bitrateTestBytes(size: Int?) async throws -> JellyfinRawData

    /// Gets additional playable parts for a video item.
    ///
    /// - Parameters:
    ///   - itemID: The video item identifier.
    ///   - userID: The user identifier whose library context should be used. When omitted, Jellyfin uses the current user.
    /// - Returns: Additional parts related to the requested video item.
    func additionalParts(itemID: UUID, userID: UUID?) async throws -> BaseItemQueryResult

    /// Downloads a binary attachment from a specific media source.
    ///
    /// - Parameters:
    ///   - videoID: The video item identifier.
    ///   - mediaSourceID: The media source identifier that owns the attachment.
    ///   - index: The zero-based attachment index.
    /// - Returns: The raw attachment payload.
    func attachment(videoID: UUID, mediaSourceID: String, index: Int) async throws -> JellyfinRawData

    /// Gets media segments defined for an item.
    ///
    /// - Parameter itemID: The item identifier.
    /// - Returns: The media segments returned by Jellyfin for the item.
    func itemSegments(itemID: UUID) async throws -> [MediaSegment]

    /// Gets lyrics for an audio item.
    ///
    /// - Parameter itemID: The audio item identifier.
    /// - Returns: The stored lyric payload for the item.
    func lyrics(itemID: UUID) async throws -> Lyric

    /// Uploads an external lyric file for an audio item.
    ///
    /// - Parameters:
    ///   - itemID: The audio item identifier.
    ///   - fileName: The lyric file name to associate with the upload.
    ///   - contents: The lyric file contents.
    /// - Returns: The stored lyric payload returned by Jellyfin.
    func uploadLyrics(itemID: UUID, fileName: String, contents: String) async throws -> Lyric

    /// Deletes an external lyric file for an audio item.
    ///
    /// - Parameter itemID: The audio item identifier.
    func deleteLyrics(itemID: UUID) async throws

    /// Searches remote lyric providers for an audio item.
    ///
    /// - Parameter itemID: The audio item identifier.
    /// - Returns: Candidate lyric matches from Jellyfin's configured providers.
    func searchRemoteLyrics(itemID: UUID) async throws -> [RemoteLyricInfo]

    /// Downloads a remote lyric into Jellyfin for an audio item.
    ///
    /// - Parameters:
    ///   - itemID: The audio item identifier.
    ///   - lyricID: The remote lyric identifier to download.
    /// - Returns: The downloaded lyric payload returned by Jellyfin.
    func downloadRemoteLyrics(itemID: UUID, lyricID: String) async throws -> Lyric

    /// Gets a remote lyric directly from a provider.
    ///
    /// - Parameter lyricID: The remote lyric identifier.
    /// - Returns: The lyric payload fetched from the provider.
    func remoteLyrics(lyricID: String) async throws -> Lyric

    /// Searches remote subtitle providers for an item and language.
    ///
    /// - Parameters:
    ///   - itemID: The item identifier.
    ///   - language: The subtitle language to search for.
    ///   - isPerfectMatch: When `true`, Jellyfin only returns perfect subtitle matches.
    /// - Returns: Candidate subtitle matches from Jellyfin's configured providers.
    func searchRemoteSubtitles(itemID: UUID, language: String, isPerfectMatch: Bool?) async throws -> [RemoteSubtitleInfo]

    /// Downloads a remote subtitle into Jellyfin for an item.
    ///
    /// - Parameters:
    ///   - itemID: The item identifier.
    ///   - subtitleID: The remote subtitle identifier to download.
    func downloadRemoteSubtitles(itemID: UUID, subtitleID: String) async throws

    /// Gets a remote subtitle file directly from a provider.
    ///
    /// - Parameter subtitleID: The remote subtitle identifier.
    /// - Returns: The raw subtitle file payload.
    func remoteSubtitle(subtitleID: String) async throws -> JellyfinRawData

    /// Downloads a subtitle stream using the supplied subtitle request.
    ///
    /// - Parameter request: The subtitle stream request, including item, media source, stream index, and output options.
    /// - Returns: The raw subtitle payload.
    func subtitle(_ request: SubtitleStreamRequest) async throws -> JellyfinRawData

    /// Gets an HLS subtitle playlist for a specific subtitle stream.
    ///
    /// - Parameters:
    ///   - itemID: The item identifier.
    ///   - mediaSourceID: The media source identifier that owns the subtitle stream.
    ///   - index: The subtitle stream index.
    ///   - segmentLength: The requested subtitle HLS segment length.
    /// - Returns: The raw playlist payload.
    func subtitlePlaylist(itemID: UUID, mediaSourceID: String, index: Int, segmentLength: Int) async throws -> JellyfinRawData

    /// Uploads a subtitle file for a video item.
    ///
    /// - Parameters:
    ///   - itemID: The video item identifier.
    ///   - request: The subtitle upload request, including metadata and file contents.
    func uploadSubtitle(itemID: UUID, request: UploadSubtitleRequest) async throws

    /// Deletes a subtitle stream from a video item.
    ///
    /// - Parameters:
    ///   - itemID: The video item identifier.
    ///   - index: The subtitle stream index to remove.
    func deleteSubtitle(itemID: UUID, index: Int) async throws

    /// Opens a live stream for a media source.
    ///
    /// - Parameter request: The live stream request, including media source and playback context.
    /// - Returns: The opened live stream information returned by Jellyfin.
    func openLiveStream(_ request: OpenLiveStreamRequest) async throws -> LiveStreamResponse

    /// Closes an opened live stream.
    ///
    /// - Parameter liveStreamID: The live stream identifier to close.
    func closeLiveStream(liveStreamID: String) async throws

    /// Gets the master HLS audio playlist for an item.
    ///
    /// - Parameters:
    ///   - itemID: The audio item identifier.
    ///   - query: Streaming and transcoding options for the playlist request.
    /// - Returns: The raw playlist payload.
    func masterHlsAudioPlaylist(itemID: UUID, query: StreamRequestOptions) async throws -> JellyfinRawData

    /// Issues a `HEAD` request for the master HLS audio playlist.
    ///
    /// - Parameters:
    ///   - itemID: The audio item identifier.
    ///   - query: Streaming and transcoding options for the playlist request.
    func headMasterHlsAudioPlaylist(itemID: UUID, query: StreamRequestOptions) async throws

    /// Gets the variant HLS audio playlist for an item.
    ///
    /// - Parameters:
    ///   - itemID: The audio item identifier.
    ///   - query: Streaming and transcoding options for the playlist request.
    /// - Returns: The raw playlist payload.
    func variantHlsAudioPlaylist(itemID: UUID, query: StreamRequestOptions) async throws -> JellyfinRawData

    /// Downloads an HLS audio segment.
    ///
    /// - Parameter request: The segment request, including item, playlist, segment, and container details.
    /// - Returns: The raw segment payload.
    func hlsAudioSegment(_ request: HLSAudioSegmentRequest) async throws -> JellyfinRawData

    /// Downloads a legacy HLS audio segment endpoint.
    ///
    /// - Parameters:
    ///   - itemID: The audio item identifier.
    ///   - segmentID: The HLS segment identifier.
    ///   - container: The audio segment container format.
    /// - Returns: The raw segment payload.
    func legacyHlsAudioSegment(itemID: UUID, segmentID: String, container: AudioSegmentContainer) async throws -> JellyfinRawData

    /// Gets the master HLS video playlist for an item.
    ///
    /// - Parameters:
    ///   - itemID: The video item identifier.
    ///   - query: Streaming and transcoding options for the playlist request.
    /// - Returns: The raw playlist payload.
    func masterHlsVideoPlaylist(itemID: UUID, query: StreamRequestOptions) async throws -> JellyfinRawData

    /// Issues a `HEAD` request for the master HLS video playlist.
    ///
    /// - Parameters:
    ///   - itemID: The video item identifier.
    ///   - query: Streaming and transcoding options for the playlist request.
    func headMasterHlsVideoPlaylist(itemID: UUID, query: StreamRequestOptions) async throws

    /// Gets the variant HLS video playlist for an item.
    ///
    /// - Parameters:
    ///   - itemID: The video item identifier.
    ///   - query: Streaming and transcoding options for the playlist request.
    /// - Returns: The raw playlist payload.
    func variantHlsVideoPlaylist(itemID: UUID, query: StreamRequestOptions) async throws -> JellyfinRawData

    /// Gets the live HLS video playlist for an item.
    ///
    /// - Parameters:
    ///   - itemID: The video item identifier.
    ///   - query: Streaming and transcoding options for the playlist request.
    /// - Returns: The raw playlist payload.
    func liveHlsVideoPlaylist(itemID: UUID, query: StreamRequestOptions) async throws -> JellyfinRawData

    /// Downloads an HLS video segment.
    ///
    /// - Parameter request: The segment request, including item, playlist, segment, and container details.
    /// - Returns: The raw segment payload.
    func hlsVideoSegment(_ request: HLSVideoSegmentRequest) async throws -> JellyfinRawData

    /// Downloads a legacy HLS video segment endpoint.
    ///
    /// - Parameters:
    ///   - itemID: The video item identifier.
    ///   - playlistID: The HLS playlist identifier.
    ///   - segmentID: The HLS segment identifier.
    ///   - segmentContainer: The video segment container extension.
    /// - Returns: The raw segment payload.
    func legacyHlsVideoSegment(itemID: UUID, playlistID: String, segmentID: String, segmentContainer: String) async throws -> JellyfinRawData

    /// Gets the trickplay tile playlist for a video item.
    ///
    /// - Parameters:
    ///   - itemID: The video item identifier.
    ///   - width: The requested trickplay tile width.
    ///   - mediaSourceID: An optional media source identifier when the item has multiple sources.
    /// - Returns: The raw trickplay playlist payload.
    func trickplayPlaylist(itemID: UUID, width: Int, mediaSourceID: String?) async throws -> JellyfinRawData

    /// Gets a trickplay tile image for a video item.
    ///
    /// - Parameters:
    ///   - itemID: The video item identifier.
    ///   - width: The requested trickplay tile width.
    ///   - index: The tile index to fetch.
    ///   - mediaSourceID: An optional media source identifier when the item has multiple sources.
    /// - Returns: The raw tile image payload.
    func trickplayTile(itemID: UUID, width: Int, index: Int, mediaSourceID: String?) async throws -> JellyfinRawData

    /// Stops an active transcoding or encoding session.
    ///
    /// - Parameters:
    ///   - deviceID: The client device identifier that opened the encoding session.
    ///   - playSessionID: The playback session identifier to stop.
    func stopEncodingProcess(deviceID: String, playSessionID: String) async throws

    /// Merges multiple video items into a single versioned record.
    ///
    /// - Parameter itemIDs: The video item identifiers to merge. Jellyfin expects at least two items.
    func mergeVersions(itemIDs: [UUID]) async throws

    /// Deletes alternate sources for a video item.
    ///
    /// - Parameter itemID: The video item identifier.
    func deleteAlternateSources(itemID: UUID) async throws

    /// Gets the list of available fallback subtitle font files.
    ///
    /// - Returns: Available fallback font descriptors.
    func fallbackFontList() async throws -> [FontFile]

    /// Downloads a fallback subtitle font file by name.
    ///
    /// - Parameter name: The fallback font file name.
    /// - Returns: The raw font file payload.
    func fallbackFont(named name: String) async throws -> JellyfinRawData
}
