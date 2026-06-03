import Foundation

/// Service interface for Jellyfin Live TV and channel endpoints.
public protocol LiveTVService: JellyfinService {
    /// Gets channels exposed by installed channel plugins.
    func channels(_ query: ChannelBrowseQuery) async throws -> BaseItemQueryResult

    /// Gets capability details for a specific channel plugin.
    func channelFeatures(channelID: String) async throws -> ChannelFeatures

    /// Gets items exposed by a specific channel plugin.
    func channelItems(channelID: String, query: ChannelItemsQuery) async throws -> BaseItemQueryResult

    /// Gets capability details for all installed channel plugins.
    func allChannelFeatures() async throws -> [ChannelFeatures]

    /// Gets the latest items from channel plugins.
    func latestChannelItems(_ query: LatestChannelItemsQuery) async throws -> BaseItemQueryResult

    /// Gets channel mapping options for a listings provider.
    func channelMappingOptions(providerID: String?) async throws -> ChannelMappingOptions

    /// Creates or updates a tuner-to-guide channel mapping.
    func setChannelMapping(_ request: SetChannelMappingRequest) async throws -> TunerChannelMapping

    /// Gets Live TV channels from configured tuners and guide providers.
    func liveTVChannels(_ query: LiveTVChannelsQuery) async throws -> BaseItemQueryResult

    /// Gets a single Live TV channel.
    func channel(channelID: String, userID: UUID?) async throws -> BaseItem

    /// Gets Live TV guide configuration and scheduling information.
    func guideInfo() async throws -> GuideInfo

    /// Gets overall Live TV server configuration and status.
    func liveTVInfo() async throws -> LiveTVInfo

    /// Adds a listings provider and optionally validates credentials or guide data.
    func addListingProvider(
        _ provider: ListingsProvider,
        password: String?,
        validateListings: Bool?,
        validateLogin: Bool?
    ) async throws -> ListingsProvider

    /// Deletes a listings provider by identifier.
    func deleteListingProvider(id: String?) async throws

    /// Gets the default listings provider template.
    func defaultListingProvider() async throws -> ListingsProvider

    /// Gets lineup choices for a listings provider search.
    func lineups(id: String?, type: String?, location: String?, country: String?) async throws -> [NameIDPair]

    /// Gets the raw country payload used for Schedules Direct setup.
    func schedulesDirectCountries() async throws -> String

    /// Opens the live recording stream file for a recording.
    func liveRecordingFile(recordingID: String) async throws -> JellyfinRawData

    /// Opens a transient Live TV stream file in the requested container.
    func liveStreamFile(streamID: String, container: String) async throws -> JellyfinRawData

    /// Gets Live TV guide programs using query-string parameters.
    func programs(query: ProgramsQuery) async throws -> BaseItemQueryResult

    /// Gets Live TV guide programs using a JSON request body.
    func programs(requestBody: ProgramsQuery) async throws -> BaseItemQueryResult

    /// Gets a single guide program.
    func program(programID: String, userID: UUID?) async throws -> BaseItem

    /// Gets recommended guide programs for the supplied filters.
    func recommendedPrograms(_ query: RecommendedProgramsQuery) async throws -> BaseItemQueryResult

    /// Gets Live TV recordings.
    func recordings(_ query: RecordingsQuery) async throws -> BaseItemQueryResult

    /// Gets a single recording.
    func recording(recordingID: String, userID: UUID?) async throws -> BaseItem

    /// Deletes a recording.
    func deleteRecording(recordingID: String) async throws

    /// Gets recording folders visible to the selected user context.
    func recordingFolders(userID: UUID?) async throws -> BaseItemQueryResult

    /// Gets grouped recording views visible to the selected user context.
    func recordingGroups(userID: UUID?) async throws -> BaseItemQueryResult

    /// Gets recording series views.
    func recordingsSeries(_ query: RecordingsQuery) async throws -> BaseItemQueryResult

    /// Gets series timers, optionally sorted by the supplied fields.
    func seriesTimers(sortBy: String?, sortOrder: SortOrder?) async throws -> SeriesTimerQueryResult

    /// Creates a new series timer.
    func createSeriesTimer(_ timer: SeriesTimerInfo) async throws

    /// Gets a single series timer.
    func seriesTimer(timerID: String) async throws -> SeriesTimerInfo

    /// Cancels a series timer.
    func cancelSeriesTimer(timerID: String) async throws

    /// Updates an existing series timer.
    func updateSeriesTimer(timerID: String, timer: SeriesTimerInfo) async throws

    /// Gets one-time timers filtered by channel, series timer, or scheduling state.
    func timers(channelID: String?, seriesTimerID: String?, isActive: Bool?, isScheduled: Bool?) async throws -> TimerQueryResult

    /// Creates a new one-time recording timer.
    func createTimer(_ timer: TimerInfo) async throws

    /// Gets a single recording timer.
    func timer(timerID: String) async throws -> TimerInfo

    /// Cancels a recording timer.
    func cancelTimer(timerID: String) async throws

    /// Updates an existing recording timer.
    func updateTimer(timerID: String, timer: TimerInfo) async throws

    /// Gets the default timer template, optionally seeded from a program.
    func defaultTimer(programID: String?) async throws -> SeriesTimerInfo

    /// Adds a tuner host.
    func addTunerHost(_ tuner: TunerHost) async throws -> TunerHost

    /// Deletes a tuner host by identifier.
    func deleteTunerHost(id: String?) async throws

    /// Gets supported tuner host types.
    func tunerHostTypes() async throws -> [NameIDPair]

    /// Resets a tuner by identifier.
    func resetTuner(tunerID: String) async throws

    /// Discovers tuner devices, optionally using Jellyfin's legacy typo route for compatibility.
    func discoverTuners(newDevicesOnly: Bool?, useLegacyTypoPath: Bool) async throws -> [TunerHost]
}
