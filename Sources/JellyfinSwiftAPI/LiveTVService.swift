import Foundation

/// Service interface for Jellyfin Live TV and channel endpoints.
public protocol LiveTVService: JellyfinService {
    func channels(_ query: ChannelBrowseQuery) async throws -> BaseItemQueryResult
    func channelFeatures(channelID: String) async throws -> ChannelFeatures
    func channelItems(channelID: String, query: ChannelItemsQuery) async throws -> BaseItemQueryResult
    func allChannelFeatures() async throws -> [ChannelFeatures]
    func latestChannelItems(_ query: LatestChannelItemsQuery) async throws -> BaseItemQueryResult
    func channelMappingOptions(providerID: String?) async throws -> ChannelMappingOptions
    func setChannelMapping(_ request: SetChannelMappingRequest) async throws -> TunerChannelMapping
    func liveTVChannels(_ query: LiveTVChannelsQuery) async throws -> BaseItemQueryResult
    func channel(channelID: String, userID: UUID?) async throws -> BaseItem
    func guideInfo() async throws -> GuideInfo
    func liveTVInfo() async throws -> LiveTVInfo
    func addListingProvider(
        _ provider: ListingsProvider,
        password: String?,
        validateListings: Bool?,
        validateLogin: Bool?
    ) async throws -> ListingsProvider
    func deleteListingProvider(id: String?) async throws
    func defaultListingProvider() async throws -> ListingsProvider
    func lineups(id: String?, type: String?, location: String?, country: String?) async throws -> [NameIDPair]
    func schedulesDirectCountries() async throws -> String
    func liveRecordingFile(recordingID: String) async throws -> JellyfinRawData
    func liveStreamFile(streamID: String, container: String) async throws -> JellyfinRawData
    func programs(query: ProgramsQuery) async throws -> BaseItemQueryResult
    func programs(requestBody: ProgramsQuery) async throws -> BaseItemQueryResult
    func program(programID: String, userID: UUID?) async throws -> BaseItem
    func recommendedPrograms(_ query: RecommendedProgramsQuery) async throws -> BaseItemQueryResult
    func recordings(_ query: RecordingsQuery) async throws -> BaseItemQueryResult
    func recording(recordingID: String, userID: UUID?) async throws -> BaseItem
    func deleteRecording(recordingID: String) async throws
    func recordingFolders(userID: UUID?) async throws -> BaseItemQueryResult
    func recordingGroups(userID: UUID?) async throws -> BaseItemQueryResult
    func recordingsSeries(_ query: RecordingsQuery) async throws -> BaseItemQueryResult
    func seriesTimers(sortBy: String?, sortOrder: SortOrder?) async throws -> SeriesTimerQueryResult
    func createSeriesTimer(_ timer: SeriesTimerInfo) async throws
    func seriesTimer(timerID: String) async throws -> SeriesTimerInfo
    func cancelSeriesTimer(timerID: String) async throws
    func updateSeriesTimer(timerID: String, timer: SeriesTimerInfo) async throws
    func timers(channelID: String?, seriesTimerID: String?, isActive: Bool?, isScheduled: Bool?) async throws -> TimerQueryResult
    func createTimer(_ timer: TimerInfo) async throws
    func timer(timerID: String) async throws -> TimerInfo
    func cancelTimer(timerID: String) async throws
    func updateTimer(timerID: String, timer: TimerInfo) async throws
    func defaultTimer(programID: String?) async throws -> SeriesTimerInfo
    func addTunerHost(_ tuner: TunerHost) async throws -> TunerHost
    func deleteTunerHost(id: String?) async throws
    func tunerHostTypes() async throws -> [NameIDPair]
    func resetTuner(tunerID: String) async throws
    func discoverTuners(newDevicesOnly: Bool?, useLegacyTypoPath: Bool) async throws -> [TunerHost]
}
