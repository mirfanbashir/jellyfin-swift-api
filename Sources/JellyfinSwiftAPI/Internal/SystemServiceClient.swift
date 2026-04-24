import Foundation

internal struct SystemServiceClient: SystemService {
    private let executor: JellyfinRequestExecutor

    internal init(executor: JellyfinRequestExecutor) {
        self.executor = executor
    }

    internal func endpointInfo() async throws -> EndpointInfo {
        try await executor.executeJSON(
            EndpointInfo.self,
            for: JellyfinRequest(path: "/System/Endpoint")
        )
    }

    internal func systemInfo() async throws -> SystemInfo {
        try await executor.executeJSON(
            SystemInfo.self,
            for: JellyfinRequest(path: "/System/Info")
        )
    }

    internal func publicSystemInfo() async throws -> PublicSystemInfo {
        try await executor.executeJSON(
            PublicSystemInfo.self,
            for: JellyfinRequest(path: "/System/Info/Public", requiresAuthorization: false)
        )
    }

    internal func systemStorage() async throws -> SystemStorage {
        try await executor.executeJSON(
            SystemStorage.self,
            for: JellyfinRequest(path: "/System/Info/Storage")
        )
    }

    internal func serverLogs() async throws -> [LogFile] {
        try await executor.executeJSON(
            [LogFile].self,
            for: JellyfinRequest(path: "/System/Logs")
        )
    }

    internal func logFile(named name: String) async throws -> String {
        try await executor.executeString(
            for: JellyfinRequest(
                path: "/System/Logs/Log",
                queryItems: [URLQueryItem(name: "name", value: name)]
            )
        )
    }

    internal func ping() async throws -> String {
        try await executor.executeString(
            for: JellyfinRequest(path: "/System/Ping", requiresAuthorization: false)
        )
    }

    internal func postPing() async throws -> String {
        try await executor.executeString(
            for: JellyfinRequest(
                path: "/System/Ping",
                method: .post,
                requiresAuthorization: false
            )
        )
    }

    internal func restart() async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(path: "/System/Restart", method: .post)
        )
    }

    internal func shutdown() async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(path: "/System/Shutdown", method: .post)
        )
    }

    internal func brandingOptions() async throws -> BrandingOptions {
        try await executor.executeJSON(
            BrandingOptions.self,
            for: JellyfinRequest(path: "/Branding/Configuration", requiresAuthorization: false)
        )
    }

    internal func brandingCSS() async throws -> String {
        try await executor.executeString(
            for: JellyfinRequest(path: "/Branding/Css", requiresAuthorization: false)
        )
    }

    internal func countries() async throws -> [CountryInfo] {
        try await executor.executeJSON(
            [CountryInfo].self,
            for: JellyfinRequest(path: "/Localization/Countries")
        )
    }

    internal func cultures() async throws -> [Culture] {
        try await executor.executeJSON(
            [Culture].self,
            for: JellyfinRequest(path: "/Localization/Cultures")
        )
    }

    internal func localizationOptions() async throws -> [LocalizationOption] {
        try await executor.executeJSON(
            [LocalizationOption].self,
            for: JellyfinRequest(path: "/Localization/Options")
        )
    }

    internal func parentalRatings() async throws -> [ParentalRating] {
        try await executor.executeJSON(
            [ParentalRating].self,
            for: JellyfinRequest(path: "/Localization/ParentalRatings")
        )
    }

    internal func utcTime() async throws -> UtcTimeResponse {
        try await executor.executeJSON(
            UtcTimeResponse.self,
            for: JellyfinRequest(path: "/GetUtcTime", requiresAuthorization: false)
        )
    }

    internal func tmdbClientConfiguration() async throws -> TmdbClientConfiguration {
        try await executor.executeJSON(
            TmdbClientConfiguration.self,
            for: JellyfinRequest(path: "/Tmdb/ClientConfiguration")
        )
    }
}
