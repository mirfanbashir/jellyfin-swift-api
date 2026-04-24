import Foundation

/// Service interface for Jellyfin administration, configuration, environment, package, plugin, backup, and task endpoints.
public protocol AdministrationService: JellyfinService {
    func serverConfiguration() async throws -> ServerConfiguration
    func updateServerConfiguration(_ configuration: ServerConfiguration) async throws
    func namedConfiguration(key: String) async throws -> String
    func updateNamedConfiguration(key: String, value: Data, contentType: String) async throws
    func updateBrandingConfiguration(_ branding: BrandingConfiguration) async throws
    func defaultMetadataOptions() async throws -> MetadataOptions

    func configurationPages(enableInMainMenu: Bool?) async throws -> [ConfigurationPageInfo]
    func configurationPage(named name: String?) async throws -> String

    func defaultDirectoryBrowser() async throws -> DefaultDirectoryBrowserInfo
    func directoryContents(path: String, includeFiles: Bool?, includeDirectories: Bool?) async throws -> [FileSystemEntry]
    func drives() async throws -> [FileSystemEntry]
    func networkShares() async throws -> [FileSystemEntry]
    func parentPath(for path: String) async throws -> String
    func validatePath(_ request: ValidatePathRequest) async throws

    func startupConfiguration() async throws -> StartupConfiguration
    func updateStartupConfiguration(_ configuration: StartupConfiguration) async throws
    func setRemoteAccess(_ configuration: StartupRemoteAccessConfiguration) async throws
    func startupUser(useFirstUserAlias: Bool) async throws -> StartupUser
    func updateStartupUser(_ user: StartupUser) async throws
    func completeStartupWizard() async throws

    func scheduledTasks(isHidden: Bool?, isEnabled: Bool?) async throws -> [ScheduledTask]
    func scheduledTask(taskID: String) async throws -> ScheduledTask
    func updateScheduledTaskTriggers(taskID: String, triggers: [ScheduledTaskTrigger]) async throws
    func startScheduledTask(taskID: String) async throws
    func stopScheduledTask(taskID: String) async throws

    func plugins() async throws -> [PluginInfo]
    func pluginConfiguration(pluginID: String) async throws -> JellyfinRawData
    func updatePluginConfiguration(pluginID: String, data: Data, contentType: String) async throws
    func pluginImage(pluginID: String, version: String) async throws -> JellyfinRawData
    func pluginManifest(pluginID: String) async throws -> JellyfinRawData
    func enablePlugin(pluginID: String, version: String) async throws
    func disablePlugin(pluginID: String, version: String) async throws
    func uninstallPlugin(pluginID: String, version: String?) async throws

    func packages() async throws -> [PackageInfo]
    func packageInfo(name: String, assemblyGUID: UUID?) async throws -> PackageInfo
    func installPackage(name: String, assemblyGUID: UUID?, version: String?, repositoryURL: String?) async throws
    func cancelPackageInstallation(packageID: UUID) async throws
    func repositories() async throws -> [RepositoryInfo]
    func setRepositories(_ repositories: [RepositoryInfo]) async throws

    func backups() async throws -> [BackupManifest]
    func backupManifest(path: String) async throws -> BackupManifest
    func createBackup(options: BackupOptions) async throws -> BackupManifest
    func restoreBackup(_ request: BackupRestoreRequest) async throws

    func activityLogEntries(startIndex: Int?, limit: Int?, minDate: Date?, hasUserID: Bool?) async throws -> ActivityLogQueryResult
    func uploadClientLog(contents: String) async throws -> ClientLogUploadResponse

    func apiKeys() async throws -> APIKeyQueryResult
    func createAPIKey(app: String) async throws
    func revokeAPIKey(_ key: String) async throws
}
