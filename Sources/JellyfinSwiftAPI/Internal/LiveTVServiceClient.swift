import Foundation

internal struct LiveTVServiceClient: LiveTVService {
    private let executor: JellyfinRequestExecutor

    internal init(executor: JellyfinRequestExecutor) {
        self.executor = executor
    }

    internal func channels(_ query: ChannelBrowseQuery) async throws -> BaseItemQueryResult {
        try await items(path: "/Channels", queryItems: query.queryItems)
    }

    internal func channelFeatures(channelID: String) async throws -> ChannelFeatures {
        try await executor.executeJSON(
            ChannelFeatures.self,
            for: JellyfinRequest(path: "/Channels/\(channelID)/Features")
        )
    }

    internal func channelItems(channelID: String, query: ChannelItemsQuery) async throws -> BaseItemQueryResult {
        try await items(path: "/Channels/\(channelID)/Items", queryItems: query.queryItems)
    }

    internal func allChannelFeatures() async throws -> [ChannelFeatures] {
        try await executor.executeJSON(
            [ChannelFeatures].self,
            for: JellyfinRequest(path: "/Channels/Features")
        )
    }

    internal func latestChannelItems(_ query: LatestChannelItemsQuery) async throws -> BaseItemQueryResult {
        try await items(path: "/Channels/Items/Latest", queryItems: query.queryItems)
    }

    internal func channelMappingOptions(providerID: String?) async throws -> ChannelMappingOptions {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("providerId", providerID)
        return try await executor.executeJSON(
            ChannelMappingOptions.self,
            for: JellyfinRequest(path: "/LiveTv/ChannelMappingOptions", queryItems: queryItems)
        )
    }

    internal func setChannelMapping(_ request: SetChannelMappingRequest) async throws -> TunerChannelMapping {
        try await executor.executeJSON(
            TunerChannelMapping.self,
            for: JellyfinRequest(
                path: "/LiveTv/ChannelMappings",
                method: .post,
                body: .json(try JellyfinJSONCoder.encoder().encode(request))
            )
        )
    }

    internal func liveTVChannels(_ query: LiveTVChannelsQuery) async throws -> BaseItemQueryResult {
        try await items(path: "/LiveTv/Channels", queryItems: query.queryItems)
    }

    internal func channel(channelID: String, userID: UUID?) async throws -> BaseItem {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("userId", userID?.uuidString)
        return try await executor.executeJSON(
            BaseItem.self,
            for: JellyfinRequest(path: "/LiveTv/Channels/\(channelID)", queryItems: queryItems)
        )
    }

    internal func guideInfo() async throws -> GuideInfo {
        try await executor.executeJSON(
            GuideInfo.self,
            for: JellyfinRequest(path: "/LiveTv/GuideInfo")
        )
    }

    internal func liveTVInfo() async throws -> LiveTVInfo {
        try await executor.executeJSON(
            LiveTVInfo.self,
            for: JellyfinRequest(path: "/LiveTv/Info")
        )
    }

    internal func addListingProvider(
        _ provider: ListingsProvider,
        password: String?,
        validateListings: Bool?,
        validateLogin: Bool?
    ) async throws -> ListingsProvider {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("pw", password)
        queryItems.appendOptional("validateListings", validateListings)
        queryItems.appendOptional("validateLogin", validateLogin)
        return try await executor.executeJSON(
            ListingsProvider.self,
            for: JellyfinRequest(
                path: "/LiveTv/ListingProviders",
                method: .post,
                queryItems: queryItems,
                body: .json(try JellyfinJSONCoder.encoder().encode(provider))
            )
        )
    }

    internal func deleteListingProvider(id: String?) async throws {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("id", id)
        try await executor.executeEmpty(
            for: JellyfinRequest(path: "/LiveTv/ListingProviders", method: .delete, queryItems: queryItems)
        )
    }

    internal func defaultListingProvider() async throws -> ListingsProvider {
        try await executor.executeJSON(
            ListingsProvider.self,
            for: JellyfinRequest(path: "/LiveTv/ListingProviders/Default")
        )
    }

    internal func lineups(id: String?, type: String?, location: String?, country: String?) async throws -> [NameIDPair] {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("id", id)
        queryItems.appendOptional("type", type)
        queryItems.appendOptional("location", location)
        queryItems.appendOptional("country", country)
        return try await executor.executeJSON(
            [NameIDPair].self,
            for: JellyfinRequest(path: "/LiveTv/ListingProviders/Lineups", queryItems: queryItems)
        )
    }

    internal func schedulesDirectCountries() async throws -> String {
        try await executor.executeJSON(
            String.self,
            for: JellyfinRequest(path: "/LiveTv/ListingProviders/SchedulesDirect/Countries")
        )
    }

    internal func liveRecordingFile(recordingID: String) async throws -> JellyfinRawData {
        try await raw(path: "/LiveTv/LiveRecordings/\(recordingID)/stream")
    }

    internal func liveStreamFile(streamID: String, container: String) async throws -> JellyfinRawData {
        try await raw(path: "/LiveTv/LiveStreamFiles/\(streamID)/stream.\(container)")
    }

    internal func programs(query: ProgramsQuery) async throws -> BaseItemQueryResult {
        try await items(path: "/LiveTv/Programs", queryItems: query.queryItems)
    }

    internal func programs(requestBody: ProgramsQuery) async throws -> BaseItemQueryResult {
        try await executor.executeJSON(
            BaseItemQueryResult.self,
            for: JellyfinRequest(
                path: "/LiveTv/Programs",
                method: .post,
                body: .json(try JellyfinJSONCoder.encoder().encode(requestBody))
            )
        )
    }

    internal func program(programID: String, userID: UUID?) async throws -> BaseItem {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("userId", userID?.uuidString)
        return try await executor.executeJSON(
            BaseItem.self,
            for: JellyfinRequest(path: "/LiveTv/Programs/\(programID)", queryItems: queryItems)
        )
    }

    internal func recommendedPrograms(_ query: RecommendedProgramsQuery) async throws -> BaseItemQueryResult {
        try await items(path: "/LiveTv/Programs/Recommended", queryItems: query.queryItems)
    }

    internal func recordings(_ query: RecordingsQuery) async throws -> BaseItemQueryResult {
        try await items(path: "/LiveTv/Recordings", queryItems: query.queryItems)
    }

    internal func recording(recordingID: String, userID: UUID?) async throws -> BaseItem {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("userId", userID?.uuidString)
        return try await executor.executeJSON(
            BaseItem.self,
            for: JellyfinRequest(path: "/LiveTv/Recordings/\(recordingID)", queryItems: queryItems)
        )
    }

    internal func deleteRecording(recordingID: String) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(path: "/LiveTv/Recordings/\(recordingID)", method: .delete)
        )
    }

    internal func recordingFolders(userID: UUID?) async throws -> BaseItemQueryResult {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("userId", userID?.uuidString)
        return try await items(path: "/LiveTv/Recordings/Folders", queryItems: queryItems)
    }

    internal func recordingGroups(userID: UUID?) async throws -> BaseItemQueryResult {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("userId", userID?.uuidString)
        return try await items(path: "/LiveTv/Recordings/Groups", queryItems: queryItems)
    }

    internal func recordingsSeries(_ query: RecordingsQuery) async throws -> BaseItemQueryResult {
        try await items(path: "/LiveTv/Recordings/Series", queryItems: query.queryItems)
    }

    internal func seriesTimers(sortBy: String?, sortOrder: SortOrder?) async throws -> SeriesTimerQueryResult {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("sortBy", sortBy)
        queryItems.appendOptional("sortOrder", sortOrder?.rawValue)
        return try await executor.executeJSON(
            SeriesTimerQueryResult.self,
            for: JellyfinRequest(path: "/LiveTv/SeriesTimers", queryItems: queryItems)
        )
    }

    internal func createSeriesTimer(_ timer: SeriesTimerInfo) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/LiveTv/SeriesTimers",
                method: .post,
                body: .json(try JellyfinJSONCoder.encoder().encode(timer))
            )
        )
    }

    internal func seriesTimer(timerID: String) async throws -> SeriesTimerInfo {
        try await executor.executeJSON(
            SeriesTimerInfo.self,
            for: JellyfinRequest(path: "/LiveTv/SeriesTimers/\(timerID)")
        )
    }

    internal func cancelSeriesTimer(timerID: String) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(path: "/LiveTv/SeriesTimers/\(timerID)", method: .delete)
        )
    }

    internal func updateSeriesTimer(timerID: String, timer: SeriesTimerInfo) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/LiveTv/SeriesTimers/\(timerID)",
                method: .post,
                body: .json(try JellyfinJSONCoder.encoder().encode(timer))
            )
        )
    }

    internal func timers(channelID: String?, seriesTimerID: String?, isActive: Bool?, isScheduled: Bool?) async throws -> TimerQueryResult {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("channelId", channelID)
        queryItems.appendOptional("seriesTimerId", seriesTimerID)
        queryItems.appendOptional("isActive", isActive)
        queryItems.appendOptional("isScheduled", isScheduled)
        return try await executor.executeJSON(
            TimerQueryResult.self,
            for: JellyfinRequest(path: "/LiveTv/Timers", queryItems: queryItems)
        )
    }

    internal func createTimer(_ timer: TimerInfo) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/LiveTv/Timers",
                method: .post,
                body: .json(try JellyfinJSONCoder.encoder().encode(timer))
            )
        )
    }

    internal func timer(timerID: String) async throws -> TimerInfo {
        try await executor.executeJSON(
            TimerInfo.self,
            for: JellyfinRequest(path: "/LiveTv/Timers/\(timerID)")
        )
    }

    internal func cancelTimer(timerID: String) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(path: "/LiveTv/Timers/\(timerID)", method: .delete)
        )
    }

    internal func updateTimer(timerID: String, timer: TimerInfo) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/LiveTv/Timers/\(timerID)",
                method: .post,
                body: .json(try JellyfinJSONCoder.encoder().encode(timer))
            )
        )
    }

    internal func defaultTimer(programID: String?) async throws -> SeriesTimerInfo {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("programId", programID)
        return try await executor.executeJSON(
            SeriesTimerInfo.self,
            for: JellyfinRequest(path: "/LiveTv/Timers/Defaults", queryItems: queryItems)
        )
    }

    internal func addTunerHost(_ tuner: TunerHost) async throws -> TunerHost {
        try await executor.executeJSON(
            TunerHost.self,
            for: JellyfinRequest(
                path: "/LiveTv/TunerHosts",
                method: .post,
                body: .json(try JellyfinJSONCoder.encoder().encode(tuner))
            )
        )
    }

    internal func deleteTunerHost(id: String?) async throws {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("id", id)
        try await executor.executeEmpty(
            for: JellyfinRequest(path: "/LiveTv/TunerHosts", method: .delete, queryItems: queryItems)
        )
    }

    internal func tunerHostTypes() async throws -> [NameIDPair] {
        try await executor.executeJSON(
            [NameIDPair].self,
            for: JellyfinRequest(path: "/LiveTv/TunerHosts/Types")
        )
    }

    internal func resetTuner(tunerID: String) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(path: "/LiveTv/Tuners/\(tunerID)/Reset", method: .post)
        )
    }

    internal func discoverTuners(newDevicesOnly: Bool?, useLegacyTypoPath: Bool = false) async throws -> [TunerHost] {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("newDevicesOnly", newDevicesOnly)
        let path = useLegacyTypoPath ? "/LiveTv/Tuners/Discvover" : "/LiveTv/Tuners/Discover"
        return try await executor.executeJSON(
            [TunerHost].self,
            for: JellyfinRequest(path: path, queryItems: queryItems)
        )
    }

    private func items(path: String, queryItems: [URLQueryItem]) async throws -> BaseItemQueryResult {
        try await executor.executeJSON(
            BaseItemQueryResult.self,
            for: JellyfinRequest(path: path, queryItems: queryItems)
        )
    }

    private func raw(path: String) async throws -> JellyfinRawData {
        let response = try await executor.executeData(for: JellyfinRequest(path: path))
        return JellyfinRawData(data: response.data, mimeType: response.mimeType, statusCode: response.statusCode)
    }
}

private extension ChannelBrowseQuery {
    var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = []
        items.appendOptional("userId", userID?.uuidString)
        items.appendOptional("startIndex", startIndex)
        items.appendOptional("limit", limit)
        items.appendOptional("supportsLatestItems", supportsLatestItems)
        items.appendOptional("supportsMediaDeletion", supportsMediaDeletion)
        items.appendOptional("isFavorite", isFavorite)
        return items
    }
}

private extension ChannelItemsQuery {
    var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = []
        items.appendOptional("folderId", folderID)
        items.appendOptional("userId", userID?.uuidString)
        items.appendOptional("startIndex", startIndex)
        items.appendOptional("limit", limit)
        items.appendArray("sortOrder", sortOrder.map(\.rawValue))
        items.appendArray("filters", filters)
        items.appendArray("sortBy", sortBy)
        items.appendArray("fields", fields)
        return items
    }
}

private extension LatestChannelItemsQuery {
    var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = []
        items.appendOptional("userId", userID?.uuidString)
        items.appendOptional("startIndex", startIndex)
        items.appendOptional("limit", limit)
        items.appendArray("filters", filters)
        items.appendArray("fields", fields)
        items.appendArray("channelIds", channelIDs)
        return items
    }
}

private extension LiveTVChannelsQuery {
    var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = []
        items.appendOptional("type", type)
        items.appendOptional("userId", userID?.uuidString)
        items.appendOptional("startIndex", startIndex)
        items.appendOptional("limit", limit)
        items.appendOptional("isMovie", isMovie)
        items.appendOptional("isSeries", isSeries)
        items.appendOptional("isNews", isNews)
        items.appendOptional("isKids", isKids)
        items.appendOptional("isSports", isSports)
        items.appendOptional("isFavorite", isFavorite)
        items.appendOptional("isLiked", isLiked)
        items.appendOptional("isDisliked", isDisliked)
        items.appendOptional("enableImages", enableImages)
        items.appendOptional("imageTypeLimit", imageTypeLimit)
        items.appendArray("enableImageTypes", enableImageTypes.map(\.rawValue))
        items.appendArray("fields", fields)
        items.appendOptional("enableUserData", enableUserData)
        items.appendArray("sortBy", sortBy)
        items.appendArray("sortOrder", sortOrder.map(\.rawValue))
        items.appendOptional("enableFavoriteSorting", enableFavoriteSorting)
        items.appendOptional("addCurrentProgram", addCurrentProgram)
        return items
    }
}

private extension ProgramsQuery {
    var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = []
        items.appendArray("channelIds", channelIDs)
        items.appendOptional("userId", userID?.uuidString)
        items.appendOptional("minStartDate", iso8601(minStartDate))
        items.appendOptional("hasAired", hasAired)
        items.appendOptional("isAiring", isAiring)
        items.appendOptional("maxStartDate", iso8601(maxStartDate))
        items.appendOptional("minEndDate", iso8601(minEndDate))
        items.appendOptional("maxEndDate", iso8601(maxEndDate))
        items.appendOptional("isMovie", isMovie)
        items.appendOptional("isSeries", isSeries)
        items.appendOptional("isNews", isNews)
        items.appendOptional("isKids", isKids)
        items.appendOptional("isSports", isSports)
        items.appendOptional("startIndex", startIndex)
        items.appendOptional("limit", limit)
        items.appendArray("sortBy", sortBy)
        items.appendArray("sortOrder", sortOrder.map(\.rawValue))
        items.appendArray("genres", genres)
        items.appendArray("genreIds", genreIDs)
        items.appendOptional("enableImages", enableImages)
        items.appendOptional("imageTypeLimit", imageTypeLimit)
        items.appendArray("enableImageTypes", enableImageTypes.map(\.rawValue))
        items.appendOptional("enableUserData", enableUserData)
        items.appendOptional("seriesTimerId", seriesTimerID)
        items.appendOptional("librarySeriesId", librarySeriesID)
        items.appendArray("fields", fields)
        items.appendOptional("enableTotalRecordCount", enableTotalRecordCount)
        return items
    }
}

private extension RecommendedProgramsQuery {
    var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = []
        items.appendOptional("userId", userID?.uuidString)
        items.appendOptional("startIndex", startIndex)
        items.appendOptional("limit", limit)
        items.appendOptional("isAiring", isAiring)
        items.appendOptional("hasAired", hasAired)
        items.appendOptional("isSeries", isSeries)
        items.appendOptional("isMovie", isMovie)
        items.appendOptional("isNews", isNews)
        items.appendOptional("isKids", isKids)
        items.appendOptional("isSports", isSports)
        items.appendOptional("enableImages", enableImages)
        items.appendOptional("imageTypeLimit", imageTypeLimit)
        items.appendArray("enableImageTypes", enableImageTypes.map(\.rawValue))
        items.appendArray("genreIds", genreIDs)
        items.appendArray("fields", fields)
        items.appendOptional("enableUserData", enableUserData)
        items.appendOptional("enableTotalRecordCount", enableTotalRecordCount)
        return items
    }
}

private extension RecordingsQuery {
    var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = []
        items.appendOptional("channelId", channelID)
        items.appendOptional("userId", userID?.uuidString)
        items.appendOptional("groupId", groupID)
        items.appendOptional("startIndex", startIndex)
        items.appendOptional("limit", limit)
        items.appendOptional("status", status)
        items.appendOptional("isInProgress", isInProgress)
        items.appendOptional("seriesTimerId", seriesTimerID)
        items.appendOptional("enableImages", enableImages)
        items.appendOptional("imageTypeLimit", imageTypeLimit)
        items.appendArray("enableImageTypes", enableImageTypes.map(\.rawValue))
        items.appendArray("fields", fields)
        items.appendOptional("enableUserData", enableUserData)
        items.appendOptional("isMovie", isMovie)
        items.appendOptional("isSeries", isSeries)
        items.appendOptional("isKids", isKids)
        items.appendOptional("isSports", isSports)
        items.appendOptional("isNews", isNews)
        items.appendOptional("isLibraryItem", isLibraryItem)
        items.appendOptional("enableTotalRecordCount", enableTotalRecordCount)
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

private func iso8601(_ value: Date?) -> String? {
    guard let value else { return nil }
    return ISO8601DateFormatter().string(from: value)
}
