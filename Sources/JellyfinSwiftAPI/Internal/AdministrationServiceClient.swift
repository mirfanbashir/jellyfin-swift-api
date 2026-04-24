import Foundation

internal struct AdministrationServiceClient: AdministrationService {
    private let executor: JellyfinRequestExecutor

    internal init(executor: JellyfinRequestExecutor) {
        self.executor = executor
    }

    internal func serverConfiguration() async throws -> ServerConfiguration {
        try await executor.executeJSON(
            ServerConfiguration.self,
            for: JellyfinRequest(path: "/System/Configuration")
        )
    }

    internal func updateServerConfiguration(_ configuration: ServerConfiguration) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/System/Configuration",
                method: .post,
                body: .json(try JellyfinJSONCoder.encoder().encode(configuration))
            )
        )
    }

    internal func namedConfiguration(key: String) async throws -> String {
        try await executor.executeString(
            for: JellyfinRequest(path: "/System/Configuration/\(key)")
        )
    }

    internal func updateNamedConfiguration(key: String, value: Data, contentType: String = "application/json") async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/System/Configuration/\(key)",
                method: .post,
                body: .raw(value, contentType: contentType)
            )
        )
    }

    internal func updateBrandingConfiguration(_ branding: BrandingConfiguration) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/System/Configuration/Branding",
                method: .post,
                body: .json(try JellyfinJSONCoder.encoder().encode(branding))
            )
        )
    }

    internal func defaultMetadataOptions() async throws -> MetadataOptions {
        try await executor.executeJSON(
            MetadataOptions.self,
            for: JellyfinRequest(path: "/System/Configuration/MetadataOptions/Default")
        )
    }

    internal func configurationPages(enableInMainMenu: Bool?) async throws -> [ConfigurationPageInfo] {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("enableInMainMenu", enableInMainMenu)
        return try await executor.executeJSON(
            [ConfigurationPageInfo].self,
            for: JellyfinRequest(path: "/web/ConfigurationPages", queryItems: queryItems)
        )
    }

    internal func configurationPage(named name: String?) async throws -> String {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("name", name)
        return try await executor.executeString(
            for: JellyfinRequest(path: "/web/ConfigurationPage", queryItems: queryItems)
        )
    }

    internal func defaultDirectoryBrowser() async throws -> DefaultDirectoryBrowserInfo {
        try await executor.executeJSON(
            DefaultDirectoryBrowserInfo.self,
            for: JellyfinRequest(path: "/Environment/DefaultDirectoryBrowser")
        )
    }

    internal func directoryContents(path: String, includeFiles: Bool?, includeDirectories: Bool?) async throws -> [FileSystemEntry] {
        var queryItems = [URLQueryItem(name: "path", value: path)]
        queryItems.appendOptional("includeFiles", includeFiles)
        queryItems.appendOptional("includeDirectories", includeDirectories)
        return try await executor.executeJSON(
            [FileSystemEntry].self,
            for: JellyfinRequest(path: "/Environment/DirectoryContents", queryItems: queryItems)
        )
    }

    internal func drives() async throws -> [FileSystemEntry] {
        try await executor.executeJSON(
            [FileSystemEntry].self,
            for: JellyfinRequest(path: "/Environment/Drives")
        )
    }

    internal func networkShares() async throws -> [FileSystemEntry] {
        try await executor.executeJSON(
            [FileSystemEntry].self,
            for: JellyfinRequest(path: "/Environment/NetworkShares")
        )
    }

    internal func parentPath(for path: String) async throws -> String {
        try await executor.executeString(
            for: JellyfinRequest(path: "/Environment/ParentPath", queryItems: [URLQueryItem(name: "path", value: path)])
        )
    }

    internal func validatePath(_ request: ValidatePathRequest) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Environment/ValidatePath",
                method: .post,
                body: .json(try JellyfinJSONCoder.encoder().encode(request))
            )
        )
    }

    internal func startupConfiguration() async throws -> StartupConfiguration {
        try await executor.executeJSON(
            StartupConfiguration.self,
            for: JellyfinRequest(path: "/Startup/Configuration")
        )
    }

    internal func updateStartupConfiguration(_ configuration: StartupConfiguration) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Startup/Configuration",
                method: .post,
                body: .json(try JellyfinJSONCoder.encoder().encode(configuration))
            )
        )
    }

    internal func setRemoteAccess(_ configuration: StartupRemoteAccessConfiguration) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Startup/RemoteAccess",
                method: .post,
                body: .json(try JellyfinJSONCoder.encoder().encode(configuration))
            )
        )
    }

    internal func startupUser(useFirstUserAlias: Bool = false) async throws -> StartupUser {
        let path = useFirstUserAlias ? "/Startup/FirstUser" : "/Startup/User"
        return try await executor.executeJSON(
            StartupUser.self,
            for: JellyfinRequest(path: path)
        )
    }

    internal func updateStartupUser(_ user: StartupUser) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Startup/User",
                method: .post,
                body: .json(try JellyfinJSONCoder.encoder().encode(user))
            )
        )
    }

    internal func completeStartupWizard() async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(path: "/Startup/Complete", method: .post)
        )
    }

    internal func scheduledTasks(isHidden: Bool?, isEnabled: Bool?) async throws -> [ScheduledTask] {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("isHidden", isHidden)
        queryItems.appendOptional("isEnabled", isEnabled)
        return try await executor.executeJSON(
            [ScheduledTask].self,
            for: JellyfinRequest(path: "/ScheduledTasks", queryItems: queryItems)
        )
    }

    internal func scheduledTask(taskID: String) async throws -> ScheduledTask {
        try await executor.executeJSON(
            ScheduledTask.self,
            for: JellyfinRequest(path: "/ScheduledTasks/\(taskID)")
        )
    }

    internal func updateScheduledTaskTriggers(taskID: String, triggers: [ScheduledTaskTrigger]) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/ScheduledTasks/\(taskID)/Triggers",
                method: .post,
                body: .json(try JellyfinJSONCoder.encoder().encode(triggers))
            )
        )
    }

    internal func startScheduledTask(taskID: String) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(path: "/ScheduledTasks/Running/\(taskID)", method: .post)
        )
    }

    internal func stopScheduledTask(taskID: String) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(path: "/ScheduledTasks/Running/\(taskID)", method: .delete)
        )
    }

    internal func plugins() async throws -> [PluginInfo] {
        try await executor.executeJSON(
            [PluginInfo].self,
            for: JellyfinRequest(path: "/Plugins")
        )
    }

    internal func pluginConfiguration(pluginID: String) async throws -> JellyfinRawData {
        try await raw(path: "/Plugins/\(pluginID)/Configuration")
    }

    internal func updatePluginConfiguration(pluginID: String, data: Data, contentType: String = "application/json") async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Plugins/\(pluginID)/Configuration",
                method: .post,
                body: .raw(data, contentType: contentType)
            )
        )
    }

    internal func pluginImage(pluginID: String, version: String) async throws -> JellyfinRawData {
        try await raw(path: "/Plugins/\(pluginID)/\(version)/Image")
    }

    internal func pluginManifest(pluginID: String) async throws -> JellyfinRawData {
        try await raw(path: "/Plugins/\(pluginID)/Manifest", method: .post)
    }

    internal func enablePlugin(pluginID: String, version: String) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(path: "/Plugins/\(pluginID)/\(version)/Enable", method: .post)
        )
    }

    internal func disablePlugin(pluginID: String, version: String) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(path: "/Plugins/\(pluginID)/\(version)/Disable", method: .post)
        )
    }

    internal func uninstallPlugin(pluginID: String, version: String? = nil) async throws {
        let path = if let version {
            "/Plugins/\(pluginID)/\(version)"
        } else {
            "/Plugins/\(pluginID)"
        }
        try await executor.executeEmpty(for: JellyfinRequest(path: path, method: .delete))
    }

    internal func packages() async throws -> [PackageInfo] {
        try await executor.executeJSON(
            [PackageInfo].self,
            for: JellyfinRequest(path: "/Packages")
        )
    }

    internal func packageInfo(name: String, assemblyGUID: UUID?) async throws -> PackageInfo {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("assemblyGuid", assemblyGUID?.uuidString)
        return try await executor.executeJSON(
            PackageInfo.self,
            for: JellyfinRequest(path: "/Packages/\(name)", queryItems: queryItems)
        )
    }

    internal func installPackage(name: String, assemblyGUID: UUID?, version: String?, repositoryURL: String?) async throws {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("assemblyGuid", assemblyGUID?.uuidString)
        queryItems.appendOptional("version", version)
        queryItems.appendOptional("repositoryUrl", repositoryURL)
        try await executor.executeEmpty(
            for: JellyfinRequest(path: "/Packages/Installed/\(name)", method: .post, queryItems: queryItems)
        )
    }

    internal func cancelPackageInstallation(packageID: UUID) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(path: "/Packages/Installing/\(packageID.uuidString)", method: .delete)
        )
    }

    internal func repositories() async throws -> [RepositoryInfo] {
        try await executor.executeJSON(
            [RepositoryInfo].self,
            for: JellyfinRequest(path: "/Repositories")
        )
    }

    internal func setRepositories(_ repositories: [RepositoryInfo]) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Repositories",
                method: .post,
                body: .json(try JellyfinJSONCoder.encoder().encode(repositories))
            )
        )
    }

    internal func backups() async throws -> [BackupManifest] {
        try await executor.executeJSON(
            [BackupManifest].self,
            for: JellyfinRequest(path: "/Backup")
        )
    }

    internal func backupManifest(path: String) async throws -> BackupManifest {
        try await executor.executeJSON(
            BackupManifest.self,
            for: JellyfinRequest(path: "/Backup/Manifest", queryItems: [URLQueryItem(name: "path", value: path)])
        )
    }

    internal func createBackup(options: BackupOptions) async throws -> BackupManifest {
        try await executor.executeJSON(
            BackupManifest.self,
            for: JellyfinRequest(
                path: "/Backup/Create",
                method: .post,
                body: .json(try JellyfinJSONCoder.encoder().encode(options))
            )
        )
    }

    internal func restoreBackup(_ request: BackupRestoreRequest) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Backup/Restore",
                method: .post,
                body: .json(try JellyfinJSONCoder.encoder().encode(request))
            )
        )
    }

    internal func activityLogEntries(
        startIndex: Int?,
        limit: Int?,
        minDate: Date?,
        hasUserID: Bool?
    ) async throws -> ActivityLogQueryResult {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("startIndex", startIndex)
        queryItems.appendOptional("limit", limit)
        queryItems.appendOptional("minDate", minDate.map(iso8601))
        queryItems.appendOptional("hasUserId", hasUserID)
        return try await executor.executeJSON(
            ActivityLogQueryResult.self,
            for: JellyfinRequest(path: "/System/ActivityLog/Entries", queryItems: queryItems)
        )
    }

    internal func uploadClientLog(contents: String) async throws -> ClientLogUploadResponse {
        try await executor.executeJSON(
            ClientLogUploadResponse.self,
            for: JellyfinRequest(
                path: "/ClientLog/Document",
                method: .post,
                body: .raw(Data(contents.utf8), contentType: "text/plain")
            )
        )
    }

    internal func apiKeys() async throws -> APIKeyQueryResult {
        try await executor.executeJSON(
            APIKeyQueryResult.self,
            for: JellyfinRequest(path: "/Auth/Keys")
        )
    }

    internal func createAPIKey(app: String) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(path: "/Auth/Keys", method: .post, queryItems: [URLQueryItem(name: "app", value: app)])
        )
    }

    internal func revokeAPIKey(_ key: String) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(path: "/Auth/Keys/\(key)", method: .delete)
        )
    }

    private func raw(path: String, method: JellyfinHTTPMethod = .get) async throws -> JellyfinRawData {
        let response = try await executor.executeData(for: JellyfinRequest(path: path, method: method))
        return JellyfinRawData(data: response.data, mimeType: response.mimeType, statusCode: response.statusCode)
    }
}

private extension Array where Element == URLQueryItem {
    mutating func appendOptional<T: CustomStringConvertible>(_ name: String, _ value: T?) {
        guard let value else { return }
        append(URLQueryItem(name: name, value: value.description))
    }
}

private func iso8601(_ value: Date) -> String {
    ISO8601DateFormatter().string(from: value)
}
