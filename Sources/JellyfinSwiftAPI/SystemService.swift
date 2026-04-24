/// Service interface for Jellyfin system, branding, localization, and time endpoints.
public protocol SystemService: JellyfinService {
    /// Returns network information about the current endpoint.
    func endpointInfo() async throws -> EndpointInfo

    /// Returns system information for the authenticated server instance.
    func systemInfo() async throws -> SystemInfo

    /// Returns public system information without requiring authentication.
    func publicSystemInfo() async throws -> PublicSystemInfo

    /// Returns storage information for the server.
    func systemStorage() async throws -> SystemStorage

    /// Returns the list of available server log files.
    func serverLogs() async throws -> [LogFile]

    /// Returns the contents of a specific server log file.
    func logFile(named name: String) async throws -> String

    /// Performs a GET ping against the server.
    func ping() async throws -> String

    /// Performs a POST ping against the server.
    func postPing() async throws -> String

    /// Requests that the server restart.
    func restart() async throws

    /// Requests that the server shut down.
    func shutdown() async throws

    /// Returns the public branding configuration.
    func brandingOptions() async throws -> BrandingOptions

    /// Returns the branding CSS stylesheet, if any.
    func brandingCSS() async throws -> String

    /// Returns the list of supported countries.
    func countries() async throws -> [CountryInfo]

    /// Returns the list of supported cultures.
    func cultures() async throws -> [Culture]

    /// Returns localization key/value options.
    func localizationOptions() async throws -> [LocalizationOption]

    /// Returns parental ratings.
    func parentalRatings() async throws -> [ParentalRating]

    /// Returns synchronized UTC timing information from the server.
    func utcTime() async throws -> UtcTimeResponse

    /// Returns the TMDb client image configuration used by the server.
    func tmdbClientConfiguration() async throws -> TmdbClientConfiguration
}
