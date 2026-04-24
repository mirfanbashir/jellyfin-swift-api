import Foundation

internal struct PlaybackServiceClient: PlaybackService {
    private let executor: JellyfinRequestExecutor

    internal init(executor: JellyfinRequestExecutor) {
        self.executor = executor
    }

    internal func playbackInfo(itemID: UUID, userID: UUID?) async throws -> PlaybackInfoResponse {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("userId", userID?.uuidString)

        return try await executor.executeJSON(
            PlaybackInfoResponse.self,
            for: JellyfinRequest(path: "/Items/\(itemID.uuidString)/PlaybackInfo", queryItems: queryItems)
        )
    }

    internal func postedPlaybackInfo(
        itemID: UUID,
        userID: UUID?,
        request: PlaybackInfoRequest
    ) async throws -> PlaybackInfoResponse {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("userId", userID?.uuidString)
        queryItems.appendOptional("maxStreamingBitrate", request.maxStreamingBitrate)
        queryItems.appendOptional("startTimeTicks", request.startTimeTicks)
        queryItems.appendOptional("audioStreamIndex", request.audioStreamIndex)
        queryItems.appendOptional("subtitleStreamIndex", request.subtitleStreamIndex)
        queryItems.appendOptional("maxAudioChannels", request.maxAudioChannels)
        queryItems.appendOptional("mediaSourceId", request.mediaSourceId)
        queryItems.appendOptional("liveStreamId", request.liveStreamId)
        queryItems.appendOptional("autoOpenLiveStream", request.autoOpenLiveStream)
        queryItems.appendOptional("enableDirectPlay", request.enableDirectPlay)
        queryItems.appendOptional("enableDirectStream", request.enableDirectStream)
        queryItems.appendOptional("enableTranscoding", request.enableTranscoding)
        queryItems.appendOptional("allowVideoStreamCopy", request.allowVideoStreamCopy)
        queryItems.appendOptional("allowAudioStreamCopy", request.allowAudioStreamCopy)

        return try await executor.executeJSON(
            PlaybackInfoResponse.self,
            for: JellyfinRequest(
                path: "/Items/\(itemID.uuidString)/PlaybackInfo",
                method: .post,
                queryItems: queryItems,
                body: .json(try JellyfinJSONCoder.encoder().encode(request))
            )
        )
    }

    internal func audioStream(itemID: UUID, query: StreamRequestOptions = StreamRequestOptions()) async throws -> JellyfinRawData {
        try await raw(path: "/Audio/\(itemID.uuidString)/stream", queryItems: query.queryItems)
    }

    internal func headAudioStream(itemID: UUID, query: StreamRequestOptions = StreamRequestOptions()) async throws {
        try await head(path: "/Audio/\(itemID.uuidString)/stream", queryItems: query.queryItems)
    }

    internal func audioStream(
        itemID: UUID,
        container: String,
        query: StreamRequestOptions = StreamRequestOptions()
    ) async throws -> JellyfinRawData {
        var query = query
        query.container = nil
        return try await raw(path: "/Audio/\(itemID.uuidString)/stream.\(container)", queryItems: query.queryItems)
    }

    internal func headAudioStream(
        itemID: UUID,
        container: String,
        query: StreamRequestOptions = StreamRequestOptions()
    ) async throws {
        var query = query
        query.container = nil
        try await head(path: "/Audio/\(itemID.uuidString)/stream.\(container)", queryItems: query.queryItems)
    }

    internal func universalAudioStream(
        itemID: UUID,
        query: UniversalAudioRequestOptions = UniversalAudioRequestOptions()
    ) async throws -> JellyfinRawData {
        try await raw(path: "/Audio/\(itemID.uuidString)/universal", queryItems: query.queryItems)
    }

    internal func headUniversalAudioStream(
        itemID: UUID,
        query: UniversalAudioRequestOptions = UniversalAudioRequestOptions()
    ) async throws {
        try await head(path: "/Audio/\(itemID.uuidString)/universal", queryItems: query.queryItems)
    }

    internal func videoStream(itemID: UUID, query: StreamRequestOptions = StreamRequestOptions()) async throws -> JellyfinRawData {
        try await raw(path: "/Videos/\(itemID.uuidString)/stream", queryItems: query.queryItems)
    }

    internal func headVideoStream(itemID: UUID, query: StreamRequestOptions = StreamRequestOptions()) async throws {
        try await head(path: "/Videos/\(itemID.uuidString)/stream", queryItems: query.queryItems)
    }

    internal func videoStream(
        itemID: UUID,
        container: String,
        query: StreamRequestOptions = StreamRequestOptions()
    ) async throws -> JellyfinRawData {
        var query = query
        query.container = nil
        return try await raw(path: "/Videos/\(itemID.uuidString)/stream.\(container)", queryItems: query.queryItems)
    }

    internal func headVideoStream(
        itemID: UUID,
        container: String,
        query: StreamRequestOptions = StreamRequestOptions()
    ) async throws {
        var query = query
        query.container = nil
        try await head(path: "/Videos/\(itemID.uuidString)/stream.\(container)", queryItems: query.queryItems)
    }

    internal func bitrateTestBytes(size: Int?) async throws -> JellyfinRawData {
        let queryItems = size.map { [URLQueryItem(name: "size", value: String($0))] } ?? []
        return try await raw(path: "/Playback/BitrateTest", queryItems: queryItems)
    }

    internal func additionalParts(itemID: UUID, userID: UUID?) async throws -> BaseItemQueryResult {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("userId", userID?.uuidString)
        return try await executor.executeJSON(
            BaseItemQueryResult.self,
            for: JellyfinRequest(path: "/Videos/\(itemID.uuidString)/AdditionalParts", queryItems: queryItems)
        )
    }

    internal func attachment(videoID: UUID, mediaSourceID: String, index: Int) async throws -> JellyfinRawData {
        try await raw(
            path: "/Videos/\(videoID.uuidString)/\(mediaSourceID)/Attachments/\(index)",
            queryItems: []
        )
    }

    internal func itemSegments(itemID: UUID) async throws -> [MediaSegment] {
        try await executor.executeJSON(
            [MediaSegment].self,
            for: JellyfinRequest(path: "/MediaSegments/\(itemID.uuidString)")
        )
    }

    internal func lyrics(itemID: UUID) async throws -> Lyric {
        try await executor.executeJSON(
            Lyric.self,
            for: JellyfinRequest(path: "/Audio/\(itemID.uuidString)/Lyrics")
        )
    }

    internal func uploadLyrics(itemID: UUID, fileName: String, contents: String) async throws -> Lyric {
        try await executor.executeJSON(
            Lyric.self,
            for: JellyfinRequest(
                path: "/Audio/\(itemID.uuidString)/Lyrics",
                method: .post,
                queryItems: [URLQueryItem(name: "fileName", value: fileName)],
                body: .raw(Data(contents.utf8), contentType: "text/plain")
            )
        )
    }

    internal func deleteLyrics(itemID: UUID) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(path: "/Audio/\(itemID.uuidString)/Lyrics", method: .delete)
        )
    }

    internal func searchRemoteLyrics(itemID: UUID) async throws -> [RemoteLyricInfo] {
        try await executor.executeJSON(
            [RemoteLyricInfo].self,
            for: JellyfinRequest(path: "/Audio/\(itemID.uuidString)/RemoteSearch/Lyrics")
        )
    }

    internal func downloadRemoteLyrics(itemID: UUID, lyricID: String) async throws -> Lyric {
        try await executor.executeJSON(
            Lyric.self,
            for: JellyfinRequest(path: "/Audio/\(itemID.uuidString)/RemoteSearch/Lyrics/\(lyricID)", method: .post)
        )
    }

    internal func remoteLyrics(lyricID: String) async throws -> Lyric {
        try await executor.executeJSON(
            Lyric.self,
            for: JellyfinRequest(path: "/Providers/Lyrics/\(lyricID)")
        )
    }

    internal func searchRemoteSubtitles(itemID: UUID, language: String, isPerfectMatch: Bool?) async throws -> [RemoteSubtitleInfo] {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("isPerfectMatch", isPerfectMatch)
        return try await executor.executeJSON(
            [RemoteSubtitleInfo].self,
            for: JellyfinRequest(path: "/Items/\(itemID.uuidString)/RemoteSearch/Subtitles/\(language)", queryItems: queryItems)
        )
    }

    internal func downloadRemoteSubtitles(itemID: UUID, subtitleID: String) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(path: "/Items/\(itemID.uuidString)/RemoteSearch/Subtitles/\(subtitleID)", method: .post)
        )
    }

    internal func remoteSubtitle(subtitleID: String) async throws -> JellyfinRawData {
        try await raw(path: "/Providers/Subtitles/Subtitles/\(subtitleID)", queryItems: [])
    }

    internal func subtitle(_ request: SubtitleStreamRequest) async throws -> JellyfinRawData {
        let path: String
        if let startPositionTicks = request.startPositionTicks {
            path = "/Videos/\(request.itemID.uuidString)/\(request.mediaSourceID)/Subtitles/\(request.index)/\(startPositionTicks)/Stream.\(request.format)"
        } else {
            path = "/Videos/\(request.itemID.uuidString)/\(request.mediaSourceID)/Subtitles/\(request.index)/Stream.\(request.format)"
        }
        return try await raw(path: path, queryItems: request.queryItems)
    }

    internal func subtitlePlaylist(itemID: UUID, mediaSourceID: String, index: Int, segmentLength: Int) async throws -> JellyfinRawData {
        try await raw(
            path: "/Videos/\(itemID.uuidString)/\(mediaSourceID)/Subtitles/\(index)/subtitles.m3u8",
            queryItems: [URLQueryItem(name: "segmentLength", value: String(segmentLength))]
        )
    }

    internal func uploadSubtitle(itemID: UUID, request: UploadSubtitleRequest) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Videos/\(itemID.uuidString)/Subtitles",
                method: .post,
                body: .json(try JellyfinJSONCoder.encoder().encode(request))
            )
        )
    }

    internal func deleteSubtitle(itemID: UUID, index: Int) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(path: "/Videos/\(itemID.uuidString)/Subtitles/\(index)", method: .delete)
        )
    }

    internal func openLiveStream(_ request: OpenLiveStreamRequest) async throws -> LiveStreamResponse {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("openToken", request.openToken)
        queryItems.appendOptional("userId", request.userID?.uuidString)
        queryItems.appendOptional("playSessionId", request.playSessionId)
        queryItems.appendOptional("maxStreamingBitrate", request.maxStreamingBitrate)
        queryItems.appendOptional("startTimeTicks", request.startTimeTicks)
        queryItems.appendOptional("audioStreamIndex", request.audioStreamIndex)
        queryItems.appendOptional("subtitleStreamIndex", request.subtitleStreamIndex)
        queryItems.appendOptional("maxAudioChannels", request.maxAudioChannels)
        queryItems.appendOptional("itemId", request.itemID?.uuidString)
        queryItems.appendOptional("enableDirectPlay", request.enableDirectPlay)
        queryItems.appendOptional("enableDirectStream", request.enableDirectStream)
        queryItems.appendOptional("alwaysBurnInSubtitleWhenTranscoding", request.alwaysBurnInSubtitleWhenTranscoding)

        return try await executor.executeJSON(
            LiveStreamResponse.self,
            for: JellyfinRequest(
                path: "/LiveStreams/Open",
                method: .post,
                queryItems: queryItems,
                body: .json(try JellyfinJSONCoder.encoder().encode(request))
            )
        )
    }

    internal func closeLiveStream(liveStreamID: String) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/LiveStreams/Close",
                method: .post,
                queryItems: [URLQueryItem(name: "liveStreamId", value: liveStreamID)]
            )
        )
    }

    internal func masterHlsAudioPlaylist(itemID: UUID, query: StreamRequestOptions = StreamRequestOptions()) async throws -> JellyfinRawData {
        try await raw(path: "/Audio/\(itemID.uuidString)/master.m3u8", queryItems: query.queryItems)
    }

    internal func headMasterHlsAudioPlaylist(itemID: UUID, query: StreamRequestOptions = StreamRequestOptions()) async throws {
        try await head(path: "/Audio/\(itemID.uuidString)/master.m3u8", queryItems: query.queryItems)
    }

    internal func variantHlsAudioPlaylist(itemID: UUID, query: StreamRequestOptions = StreamRequestOptions()) async throws -> JellyfinRawData {
        try await raw(path: "/Audio/\(itemID.uuidString)/main.m3u8", queryItems: query.queryItems)
    }

    internal func hlsAudioSegment(_ request: HLSAudioSegmentRequest) async throws -> JellyfinRawData {
        var query = request.query
        query.additionalQueryItems.append(URLQueryItem(name: "runtimeTicks", value: String(request.runtimeTicks)))
        query.additionalQueryItems.append(URLQueryItem(name: "actualSegmentLengthTicks", value: String(request.actualSegmentLengthTicks)))
        return try await raw(
            path: "/Audio/\(request.itemID.uuidString)/hls1/\(request.playlistID)/\(request.segmentID).\(request.container)",
            queryItems: query.queryItems
        )
    }

    internal func legacyHlsAudioSegment(itemID: UUID, segmentID: String, container: AudioSegmentContainer) async throws -> JellyfinRawData {
        try await raw(path: "/Audio/\(itemID.uuidString)/hls/\(segmentID)/stream.\(container.rawValue)", queryItems: [])
    }

    internal func masterHlsVideoPlaylist(itemID: UUID, query: StreamRequestOptions = StreamRequestOptions()) async throws -> JellyfinRawData {
        try await raw(path: "/Videos/\(itemID.uuidString)/master.m3u8", queryItems: query.queryItems)
    }

    internal func headMasterHlsVideoPlaylist(itemID: UUID, query: StreamRequestOptions = StreamRequestOptions()) async throws {
        try await head(path: "/Videos/\(itemID.uuidString)/master.m3u8", queryItems: query.queryItems)
    }

    internal func variantHlsVideoPlaylist(itemID: UUID, query: StreamRequestOptions = StreamRequestOptions()) async throws -> JellyfinRawData {
        try await raw(path: "/Videos/\(itemID.uuidString)/main.m3u8", queryItems: query.queryItems)
    }

    internal func liveHlsVideoPlaylist(itemID: UUID, query: StreamRequestOptions = StreamRequestOptions()) async throws -> JellyfinRawData {
        try await raw(path: "/Videos/\(itemID.uuidString)/live.m3u8", queryItems: query.queryItems)
    }

    internal func hlsVideoSegment(_ request: HLSVideoSegmentRequest) async throws -> JellyfinRawData {
        var query = request.query
        query.additionalQueryItems.append(URLQueryItem(name: "runtimeTicks", value: String(request.runtimeTicks)))
        query.additionalQueryItems.append(URLQueryItem(name: "actualSegmentLengthTicks", value: String(request.actualSegmentLengthTicks)))
        return try await raw(
            path: "/Videos/\(request.itemID.uuidString)/hls1/\(request.playlistID)/\(request.segmentID).\(request.container)",
            queryItems: query.queryItems
        )
    }

    internal func legacyHlsVideoSegment(
        itemID: UUID,
        playlistID: String,
        segmentID: String,
        segmentContainer: String
    ) async throws -> JellyfinRawData {
        try await raw(
            path: "/Videos/\(itemID.uuidString)/hls/\(playlistID)/\(segmentID).\(segmentContainer)",
            queryItems: []
        )
    }

    internal func trickplayPlaylist(itemID: UUID, width: Int, mediaSourceID: String?) async throws -> JellyfinRawData {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("mediaSourceId", mediaSourceID)
        return try await raw(path: "/Videos/\(itemID.uuidString)/Trickplay/\(width)/tiles.m3u8", queryItems: queryItems)
    }

    internal func trickplayTile(itemID: UUID, width: Int, index: Int, mediaSourceID: String?) async throws -> JellyfinRawData {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("mediaSourceId", mediaSourceID)
        return try await raw(path: "/Videos/\(itemID.uuidString)/Trickplay/\(width)/\(index).jpg", queryItems: queryItems)
    }

    internal func stopEncodingProcess(deviceID: String, playSessionID: String) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Videos/ActiveEncodings",
                method: .delete,
                queryItems: [
                    URLQueryItem(name: "deviceId", value: deviceID),
                    URLQueryItem(name: "playSessionId", value: playSessionID),
                ]
            )
        )
    }

    internal func mergeVersions(itemIDs: [UUID]) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Videos/MergeVersions",
                method: .post,
                queryItems: [URLQueryItem(name: "ids", value: itemIDs.map(\.uuidString).joined(separator: ","))]
            )
        )
    }

    internal func deleteAlternateSources(itemID: UUID) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(path: "/Videos/\(itemID.uuidString)/AlternateSources", method: .delete)
        )
    }

    internal func fallbackFontList() async throws -> [FontFile] {
        try await executor.executeJSON(
            [FontFile].self,
            for: JellyfinRequest(path: "/FallbackFont/Fonts", requiresAuthorization: false)
        )
    }

    internal func fallbackFont(named name: String) async throws -> JellyfinRawData {
        try await raw(path: "/FallbackFont/Fonts/\(name)", queryItems: [], requiresAuthorization: false)
    }

    private func raw(path: String, queryItems: [URLQueryItem], requiresAuthorization: Bool = true) async throws -> JellyfinRawData {
        let response = try await executor.executeData(
            for: JellyfinRequest(path: path, queryItems: queryItems, requiresAuthorization: requiresAuthorization)
        )
        return JellyfinRawData(data: response.data, mimeType: response.mimeType, statusCode: response.statusCode)
    }

    private func head(path: String, queryItems: [URLQueryItem]) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(path: path, method: .head, queryItems: queryItems)
        )
    }
}

private extension StreamRequestOptions {
    var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = []
        items.appendOptional("container", container)
        items.appendOptional("static", isStatic)
        items.appendOptional("params", params)
        items.appendOptional("tag", tag)
        items.appendOptional("deviceProfileId", deviceProfileId)
        items.appendOptional("playSessionId", playSessionId)
        items.appendOptional("segmentContainer", segmentContainer)
        items.appendOptional("segmentLength", segmentLength)
        items.appendOptional("minSegments", minSegments)
        items.appendOptional("mediaSourceId", mediaSourceId)
        items.appendOptional("deviceId", deviceId)
        items.appendOptional("audioCodec", audioCodec)
        items.appendOptional("enableAutoStreamCopy", enableAutoStreamCopy)
        items.appendOptional("allowVideoStreamCopy", allowVideoStreamCopy)
        items.appendOptional("allowAudioStreamCopy", allowAudioStreamCopy)
        items.appendOptional("breakOnNonKeyFrames", breakOnNonKeyFrames)
        items.appendOptional("audioSampleRate", audioSampleRate)
        items.appendOptional("maxAudioBitDepth", maxAudioBitDepth)
        items.appendOptional("maxStreamingBitrate", maxStreamingBitrate)
        items.appendOptional("audioBitRate", audioBitRate)
        items.appendOptional("audioChannels", audioChannels)
        items.appendOptional("maxAudioChannels", maxAudioChannels)
        items.appendOptional("profile", profile)
        items.appendOptional("level", level)
        items.appendOptional("framerate", frameRate)
        items.appendOptional("maxFramerate", maxFrameRate)
        items.appendOptional("copyTimestamps", copyTimestamps)
        items.appendOptional("startTimeTicks", startTimeTicks)
        items.appendOptional("width", width)
        items.appendOptional("height", height)
        items.appendOptional("maxWidth", maxWidth)
        items.appendOptional("maxHeight", maxHeight)
        items.appendOptional("videoBitRate", videoBitRate)
        items.appendOptional("subtitleStreamIndex", subtitleStreamIndex)
        items.appendOptional("maxRefFrames", maxRefFrames)
        items.appendOptional("maxVideoBitDepth", maxVideoBitDepth)
        items.appendOptional("requireAvc", requireAVC)
        items.appendOptional("deInterlace", deinterlace)
        items.appendOptional("requireNonAnamorphic", requireNonAnamorphic)
        items.appendOptional("transcodingMaxAudioChannels", transcodingMaxAudioChannels)
        items.appendOptional("cpuCoreLimit", cpuCoreLimit)
        items.appendOptional("liveStreamId", liveStreamId)
        items.appendOptional("enableMpegtsM2TsMode", enableMpegtsM2TsMode)
        items.appendOptional("videoCodec", videoCodec)
        items.appendOptional("subtitleCodec", subtitleCodec)
        items.appendOptional("transcodeReasons", transcodeReasons)
        items.appendOptional("audioStreamIndex", audioStreamIndex)
        items.appendOptional("videoStreamIndex", videoStreamIndex)
        items.appendOptional("enableAdaptiveBitrateStreaming", enableAdaptiveBitrateStreaming)
        items.appendOptional("enableSubtitlesInManifest", enableSubtitlesInManifest)
        items.appendOptional("enableAudioVbrEncoding", enableAudioVbrEncoding)
        items.appendOptional("alwaysBurnInSubtitleWhenTranscoding", alwaysBurnInSubtitleWhenTranscoding)
        items.append(contentsOf: additionalQueryItems)
        return items
    }
}

private extension UniversalAudioRequestOptions {
    var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = []
        items.appendArray("container", containers)
        items.appendOptional("mediaSourceId", mediaSourceId)
        items.appendOptional("deviceId", deviceId)
        items.appendOptional("userId", userID?.uuidString)
        items.appendOptional("audioCodec", audioCodec)
        items.appendOptional("maxAudioChannels", maxAudioChannels)
        items.appendOptional("transcodingAudioChannels", transcodingAudioChannels)
        items.appendOptional("maxStreamingBitrate", maxStreamingBitrate)
        items.appendOptional("audioBitRate", audioBitRate)
        items.appendOptional("startTimeTicks", startTimeTicks)
        items.appendOptional("transcodingContainer", transcodingContainer)
        items.appendOptional("maxAudioSampleRate", maxAudioSampleRate)
        items.appendOptional("maxAudioBitDepth", maxAudioBitDepth)
        items.appendOptional("enableRemoteMedia", enableRemoteMedia)
        items.appendOptional("enableAudioVbrEncoding", enableAudioVbrEncoding)
        items.appendOptional("breakOnNonKeyFrames", breakOnNonKeyFrames)
        items.appendOptional("enableRedirection", enableRedirection)
        items.append(contentsOf: additionalQueryItems)
        return items
    }
}

private extension Array where Element == URLQueryItem {
    mutating func appendOptional<T: CustomStringConvertible>(_ name: String, _ value: T?) {
        guard let value else { return }
        append(URLQueryItem(name: name, value: value.description))
    }

    mutating func appendArray(_ name: String, _ values: [String]) {
        guard !values.isEmpty else { return }
        append(URLQueryItem(name: name, value: values.joined(separator: ",")))
    }
}

private extension SubtitleStreamRequest {
    var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = [
            URLQueryItem(name: "itemId", value: itemID.uuidString),
            URLQueryItem(name: "mediaSourceId", value: mediaSourceID),
            URLQueryItem(name: "index", value: String(index)),
            URLQueryItem(name: "format", value: format),
        ]
        items.appendOptional("startPositionTicks", startPositionTicks)
        items.appendOptional("endPositionTicks", endPositionTicks)
        items.appendOptional("copyTimestamps", copyTimestamps)
        items.appendOptional("addVttTimeMap", addVTTTimeMap)
        return items
    }
}
