import Foundation

/// Service interface for Jellyfin administration, configuration, environment, package, plugin, backup, and task endpoints.
public protocol AdministrationService: JellyfinService {
    /// Gets the full server configuration.
    func serverConfiguration() async throws -> ServerConfiguration

    /// Replaces the full server configuration.
    func updateServerConfiguration(_ configuration: ServerConfiguration) async throws

    /// Gets a named raw configuration document by key.
    func namedConfiguration(key: String) async throws -> String

    /// Replaces a named raw configuration document.
    func updateNamedConfiguration(key: String, value: Data, contentType: String) async throws

    /// Updates branding configuration such as login and splash assets metadata.
    func updateBrandingConfiguration(_ branding: BrandingConfiguration) async throws

    /// Gets the default metadata options used for new libraries.
    func defaultMetadataOptions() async throws -> MetadataOptions
 
    /// Gets configuration pages exposed by the web configuration UI.
    func configurationPages(enableInMainMenu: Bool?) async throws -> [ConfigurationPageInfo]

    /// Gets the raw payload for a named web configuration page.
    func configurationPage(named name: String?) async throws -> String
 
    /// Gets the default starting directory for server-side browsing.
    func defaultDirectoryBrowser() async throws -> DefaultDirectoryBrowserInfo

    /// Gets the contents of a filesystem directory visible to the server.
    func directoryContents(path: String, includeFiles: Bool?, includeDirectories: Bool?) async throws -> [FileSystemEntry]

    /// Gets available local drives visible to the server.
    func drives() async throws -> [FileSystemEntry]

    /// Gets available network shares visible to the server.
    func networkShares() async throws -> [FileSystemEntry]

    /// Gets the parent path for a filesystem location.
    func parentPath(for path: String) async throws -> String

    /// Validates a filesystem path for server use.
    func validatePath(_ request: ValidatePathRequest) async throws
 
    /// Gets startup wizard configuration.
    func startupConfiguration() async throws -> StartupConfiguration

    /// Updates startup wizard configuration.
    func updateStartupConfiguration(_ configuration: StartupConfiguration) async throws

    /// Updates startup remote access settings.
    func setRemoteAccess(_ configuration: StartupRemoteAccessConfiguration) async throws

    /// Gets the startup wizard user payload.
    func startupUser(useFirstUserAlias: Bool) async throws -> StartupUser

    /// Updates the startup wizard user payload.
    func updateStartupUser(_ user: StartupUser) async throws

    /// Marks the startup wizard as completed.
    func completeStartupWizard() async throws
 
    /// Gets scheduled tasks, optionally filtered by hidden and enabled state.
    func scheduledTasks(isHidden: Bool?, isEnabled: Bool?) async throws -> [ScheduledTask]

    /// Gets a single scheduled task.
    func scheduledTask(taskID: String) async throws -> ScheduledTask

    /// Replaces the trigger set for a scheduled task.
    func updateScheduledTaskTriggers(taskID: String, triggers: [ScheduledTaskTrigger]) async throws

    /// Starts a scheduled task immediately.
    func startScheduledTask(taskID: String) async throws

    /// Stops a running scheduled task.
    func stopScheduledTask(taskID: String) async throws
 
    /// Gets installed plugins.
    func plugins() async throws -> [PluginInfo]

    /// Gets the raw configuration payload for a plugin.
    func pluginConfiguration(pluginID: String) async throws -> JellyfinRawData

    /// Replaces the raw configuration payload for a plugin.
    func updatePluginConfiguration(pluginID: String, data: Data, contentType: String) async throws

    /// Gets the plugin image for a specific plugin version.
    func pluginImage(pluginID: String, version: String) async throws -> JellyfinRawData

    /// Gets the raw manifest payload for a plugin.
    func pluginManifest(pluginID: String) async throws -> JellyfinRawData

    /// Enables a specific plugin version.
    func enablePlugin(pluginID: String, version: String) async throws

    /// Disables a specific plugin version.
    func disablePlugin(pluginID: String, version: String) async throws

    /// Uninstalls a plugin, optionally targeting a specific version.
    func uninstallPlugin(pluginID: String, version: String?) async throws
 
    /// Gets available packages from configured repositories.
    func packages() async throws -> [PackageInfo]

    /// Gets package metadata for a package name and optional assembly GUID.
    func packageInfo(name: String, assemblyGUID: UUID?) async throws -> PackageInfo

    /// Starts installation of a package.
    func installPackage(name: String, assemblyGUID: UUID?, version: String?, repositoryURL: String?) async throws

    /// Cancels an in-progress package installation.
    func cancelPackageInstallation(packageID: UUID) async throws

    /// Gets configured package repositories.
    func repositories() async throws -> [RepositoryInfo]

    /// Replaces configured package repositories.
    func setRepositories(_ repositories: [RepositoryInfo]) async throws
 
    /// Gets known backups.
    func backups() async throws -> [BackupManifest]

    /// Gets the backup manifest for a backup path.
    func backupManifest(path: String) async throws -> BackupManifest

    /// Creates a new backup.
    func createBackup(options: BackupOptions) async throws -> BackupManifest

    /// Starts a backup restore operation.
    func restoreBackup(_ request: BackupRestoreRequest) async throws
 
    /// Gets activity log entries with optional paging and filtering.
    func activityLogEntries(startIndex: Int?, limit: Int?, minDate: Date?, hasUserID: Bool?) async throws -> ActivityLogQueryResult

    /// Uploads a client log document to the server.
    func uploadClientLog(contents: String) async throws -> ClientLogUploadResponse
 
    /// Gets API keys.
    func apiKeys() async throws -> APIKeyQueryResult

    /// Creates an API key for an application name.
    func createAPIKey(app: String) async throws

    /// Revokes an API key by value.
    func revokeAPIKey(_ key: String) async throws
}
