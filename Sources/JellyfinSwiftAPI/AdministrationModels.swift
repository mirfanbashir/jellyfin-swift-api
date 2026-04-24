import Foundation

/// Server-wide Jellyfin configuration.
public struct ServerConfiguration: Codable, Sendable, Equatable {
    public let serverName: String?
    public let uICulture: String?
    public let metadataCountryCode: String?
    public let preferredMetadataLanguage: String?
    public let metadataOptions: [MetadataOptions]?
    public let contentTypes: [NameValuePair]?
    public let pluginRepositories: [RepositoryInfo]?

    enum CodingKeys: String, CodingKey {
        case serverName = "ServerName"
        case uICulture = "UICulture"
        case metadataCountryCode = "MetadataCountryCode"
        case preferredMetadataLanguage = "PreferredMetadataLanguage"
        case metadataOptions = "MetadataOptions"
        case contentTypes = "ContentTypes"
        case pluginRepositories = "PluginRepositories"
    }
}

/// Metadata ordering and disablement options for an item type.
public struct MetadataOptions: Codable, Sendable, Equatable {
    public let itemType: String?
    public let disabledMetadataSavers: [String]?
    public let localMetadataReaderOrder: [String]?
    public let disabledMetadataFetchers: [String]?
    public let metadataFetcherOrder: [String]?
    public let disabledImageFetchers: [String]?
    public let imageFetcherOrder: [String]?

    enum CodingKeys: String, CodingKey {
        case itemType = "ItemType"
        case disabledMetadataSavers = "DisabledMetadataSavers"
        case localMetadataReaderOrder = "LocalMetadataReaderOrder"
        case disabledMetadataFetchers = "DisabledMetadataFetchers"
        case metadataFetcherOrder = "MetadataFetcherOrder"
        case disabledImageFetchers = "DisabledImageFetchers"
        case imageFetcherOrder = "ImageFetcherOrder"
    }
}

/// Branding configuration fields.
public struct BrandingConfiguration: Codable, Sendable, Equatable {
    public let loginDisclaimer: String?
    public let customCss: String?
    public let splashscreenEnabled: Bool?

    enum CodingKeys: String, CodingKey {
        case loginDisclaimer = "LoginDisclaimer"
        case customCss = "CustomCss"
        case splashscreenEnabled = "SplashscreenEnabled"
    }

    public init(loginDisclaimer: String? = nil, customCss: String? = nil, splashscreenEnabled: Bool? = nil) {
        self.loginDisclaimer = loginDisclaimer
        self.customCss = customCss
        self.splashscreenEnabled = splashscreenEnabled
    }
}

/// Dashboard page metadata.
public struct ConfigurationPageInfo: Codable, Sendable, Equatable {
    public let name: String?
    public let enableInMainMenu: Bool?
    public let menuSection: String?
    public let menuIcon: String?
    public let displayName: String?
    public let pluginId: String?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case enableInMainMenu = "EnableInMainMenu"
        case menuSection = "MenuSection"
        case menuIcon = "MenuIcon"
        case displayName = "DisplayName"
        case pluginId = "PluginId"
    }
}

/// Default directory-browser response.
public struct DefaultDirectoryBrowserInfo: Codable, Sendable, Equatable {
    public let path: String?

    enum CodingKeys: String, CodingKey {
        case path = "Path"
    }
}

/// File-system entry returned by environment endpoints.
public struct FileSystemEntry: Codable, Sendable, Equatable {
    public let name: String?
    public let path: String?
    public let type: FileSystemEntryType?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case path = "Path"
        case type = "Type"
    }
}

/// File-system entry categories returned by environment endpoints.
public enum FileSystemEntryType: String, Codable, Sendable, Equatable {
    case file = "File"
    case directory = "Directory"
    case networkComputer = "NetworkComputer"
    case networkShare = "NetworkShare"
}

/// Path validation request.
public struct ValidatePathRequest: Codable, Sendable, Equatable {
    public let validateWritable: Bool?
    public let path: String
    public let isFile: Bool?

    enum CodingKeys: String, CodingKey {
        case validateWritable = "ValidateWritable"
        case path = "Path"
        case isFile = "IsFile"
    }

    public init(path: String, validateWritable: Bool? = nil, isFile: Bool? = nil) {
        self.validateWritable = validateWritable
        self.path = path
        self.isFile = isFile
    }
}

/// Startup wizard configuration.
public struct StartupConfiguration: Codable, Sendable, Equatable {
    public let serverName: String?
    public let uICulture: String?
    public let metadataCountryCode: String?
    public let preferredMetadataLanguage: String?

    enum CodingKeys: String, CodingKey {
        case serverName = "ServerName"
        case uICulture = "UICulture"
        case metadataCountryCode = "MetadataCountryCode"
        case preferredMetadataLanguage = "PreferredMetadataLanguage"
    }

    public init(
        serverName: String? = nil,
        uICulture: String? = nil,
        metadataCountryCode: String? = nil,
        preferredMetadataLanguage: String? = nil
    ) {
        self.serverName = serverName
        self.uICulture = uICulture
        self.metadataCountryCode = metadataCountryCode
        self.preferredMetadataLanguage = preferredMetadataLanguage
    }
}

/// Startup remote-access options.
public struct StartupRemoteAccessConfiguration: Codable, Sendable, Equatable {
    public let enableRemoteAccess: Bool?
    public let enableAutomaticPortMapping: Bool?

    enum CodingKeys: String, CodingKey {
        case enableRemoteAccess = "EnableRemoteAccess"
        case enableAutomaticPortMapping = "EnableAutomaticPortMapping"
    }

    public init(enableRemoteAccess: Bool? = nil, enableAutomaticPortMapping: Bool? = nil) {
        self.enableRemoteAccess = enableRemoteAccess
        self.enableAutomaticPortMapping = enableAutomaticPortMapping
    }
}

/// Startup wizard user payload.
public struct StartupUser: Codable, Sendable, Equatable {
    public let name: String?
    public let password: String?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case password = "Password"
    }

    public init(name: String? = nil, password: String? = nil) {
        self.name = name
        self.password = password
    }
}

/// Scheduled task status.
public struct ScheduledTask: Codable, Sendable, Equatable {
    public let name: String?
    public let state: TaskState?
    public let currentProgressPercentage: Double?
    public let id: String?
    public let lastExecutionResult: ScheduledTaskResult?
    public let triggers: [ScheduledTaskTrigger]?
    public let description: String?
    public let category: String?
    public let isHidden: Bool?
    public let key: String?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case state = "State"
        case currentProgressPercentage = "CurrentProgressPercentage"
        case id = "Id"
        case lastExecutionResult = "LastExecutionResult"
        case triggers = "Triggers"
        case description = "Description"
        case category = "Category"
        case isHidden = "IsHidden"
        case key = "Key"
    }
}

/// Scheduled task trigger information.
public struct ScheduledTaskTrigger: Codable, Sendable, Equatable {
    public let type: ScheduledTaskTriggerType?
    public let timeOfDayTicks: Int64?
    public let intervalTicks: Int64?
    public let dayOfWeek: DayOfWeek?
    public let maxRuntimeTicks: Int64?

    enum CodingKeys: String, CodingKey {
        case type = "Type"
        case timeOfDayTicks = "TimeOfDayTicks"
        case intervalTicks = "IntervalTicks"
        case dayOfWeek = "DayOfWeek"
        case maxRuntimeTicks = "MaxRuntimeTicks"
    }
}

/// Scheduled task execution state.
public enum TaskState: String, Codable, Sendable, Equatable {
    case idle = "Idle"
    case cancelling = "Cancelling"
    case running = "Running"
}

/// Scheduled task trigger categories.
public enum ScheduledTaskTriggerType: String, Codable, Sendable, Equatable {
    case dailyTrigger = "DailyTrigger"
    case weeklyTrigger = "WeeklyTrigger"
    case intervalTrigger = "IntervalTrigger"
    case startupTrigger = "StartupTrigger"
}

/// Day-of-week values used by weekly task triggers.
public enum DayOfWeek: String, Codable, Sendable, Equatable {
    case sunday = "Sunday"
    case monday = "Monday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
    case thursday = "Thursday"
    case friday = "Friday"
    case saturday = "Saturday"
}

/// Last scheduled task result.
public struct ScheduledTaskResult: Codable, Sendable, Equatable {
    public let startTimeUtc: Date?
    public let endTimeUtc: Date?
    public let status: TaskCompletionStatus?
    public let name: String?
    public let key: String?
    public let id: String?
    public let errorMessage: String?
    public let longErrorMessage: String?

    enum CodingKeys: String, CodingKey {
        case startTimeUtc = "StartTimeUtc"
        case endTimeUtc = "EndTimeUtc"
        case status = "Status"
        case name = "Name"
        case key = "Key"
        case id = "Id"
        case errorMessage = "ErrorMessage"
        case longErrorMessage = "LongErrorMessage"
    }
}

/// Scheduled task completion status.
public enum TaskCompletionStatus: String, Codable, Sendable, Equatable {
    case completed = "Completed"
    case failed = "Failed"
    case cancelled = "Cancelled"
    case aborted = "Aborted"
}

/// Plugin metadata.
public struct PluginInfo: Codable, Sendable, Equatable {
    public let name: String?
    public let version: String?
    public let configurationFileName: String?
    public let description: String?
    public let id: String?
    public let canUninstall: Bool?
    public let hasImage: Bool?
    public let status: PluginStatus?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case version = "Version"
        case configurationFileName = "ConfigurationFileName"
        case description = "Description"
        case id = "Id"
        case canUninstall = "CanUninstall"
        case hasImage = "HasImage"
        case status = "Status"
    }
}

/// Plugin lifecycle status.
public enum PluginStatus: String, Codable, Sendable, Equatable {
    case active = "Active"
    case restart = "Restart"
    case deleted = "Deleted"
    case superseded = "Superseded"
    case superceded = "Superceded"
    case malfunctioned = "Malfunctioned"
    case notSupported = "NotSupported"
    case disabled = "Disabled"
}

/// Plugin repository entry.
public struct RepositoryInfo: Codable, Sendable, Equatable {
    public let name: String?
    public let url: String?
    public let enabled: Bool?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case url = "Url"
        case enabled = "Enabled"
    }

    public init(name: String? = nil, url: String? = nil, enabled: Bool? = nil) {
        self.name = name
        self.url = url
        self.enabled = enabled
    }
}

/// Backup manifest returned by backup endpoints.
public struct BackupManifest: Codable, Sendable, Equatable {
    public let serverVersion: String?
    public let backupEngineVersion: String?
    public let dateCreated: Date?
    public let path: String?
    public let options: BackupOptions?

    enum CodingKeys: String, CodingKey {
        case serverVersion = "ServerVersion"
        case backupEngineVersion = "BackupEngineVersion"
        case dateCreated = "DateCreated"
        case path = "Path"
        case options = "Options"
    }
}

/// Backup creation options.
public struct BackupOptions: Codable, Sendable, Equatable {
    public let metadata: Bool?
    public let trickplay: Bool?
    public let subtitles: Bool?
    public let database: Bool?

    enum CodingKeys: String, CodingKey {
        case metadata = "Metadata"
        case trickplay = "Trickplay"
        case subtitles = "Subtitles"
        case database = "Database"
    }

    public init(metadata: Bool? = nil, trickplay: Bool? = nil, subtitles: Bool? = nil, database: Bool? = nil) {
        self.metadata = metadata
        self.trickplay = trickplay
        self.subtitles = subtitles
        self.database = database
    }
}

/// Backup restore request.
public struct BackupRestoreRequest: Codable, Sendable, Equatable {
    public let archiveFileName: String?

    enum CodingKeys: String, CodingKey {
        case archiveFileName = "ArchiveFileName"
    }

    public init(archiveFileName: String? = nil) {
        self.archiveFileName = archiveFileName
    }
}

/// Activity log query result.
public struct ActivityLogQueryResult: Codable, Sendable, Equatable {
    public let items: [ActivityLogEntry]
    public let totalRecordCount: Int?
    public let startIndex: Int?

    enum CodingKeys: String, CodingKey {
        case items = "Items"
        case totalRecordCount = "TotalRecordCount"
        case startIndex = "StartIndex"
    }
}

/// Activity log entry.
public struct ActivityLogEntry: Codable, Sendable, Equatable {
    public let id: Int?
    public let name: String?
    public let overview: String?
    public let shortOverview: String?
    public let type: String?
    public let itemId: String?
    public let date: Date?
    public let userId: String?
    public let userPrimaryImageTag: String?
    public let severity: LogLevel?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case overview = "Overview"
        case shortOverview = "ShortOverview"
        case type = "Type"
        case itemId = "ItemId"
        case date = "Date"
        case userId = "UserId"
        case userPrimaryImageTag = "UserPrimaryImageTag"
        case severity = "Severity"
    }
}

/// Activity-log severity level.
public enum LogLevel: String, Codable, Sendable, Equatable {
    case trace = "Trace"
    case debug = "Debug"
    case information = "Information"
    case warning = "Warning"
    case error = "Error"
    case critical = "Critical"
    case none = "None"
}

/// Client-log upload response.
public struct ClientLogUploadResponse: Codable, Sendable, Equatable {
    public let fileName: String?

    enum CodingKeys: String, CodingKey {
        case fileName = "FileName"
    }
}

/// API key query result.
public struct APIKeyQueryResult: Codable, Sendable, Equatable {
    public let items: [APIKeyInfo]
    public let totalRecordCount: Int?
    public let startIndex: Int?

    enum CodingKeys: String, CodingKey {
        case items = "Items"
        case totalRecordCount = "TotalRecordCount"
        case startIndex = "StartIndex"
    }
}

/// API key metadata.
public struct APIKeyInfo: Codable, Sendable, Equatable {
    public let id: Int?
    public let accessToken: String?
    public let deviceId: String?
    public let appName: String?
    public let appVersion: String?
    public let deviceName: String?
    public let userId: String?
    public let isActive: Bool?
    public let dateCreated: Date?
    public let dateRevoked: Date?
    public let dateLastActivity: Date?
    public let userName: String?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case accessToken = "AccessToken"
        case deviceId = "DeviceId"
        case appName = "AppName"
        case appVersion = "AppVersion"
        case deviceName = "DeviceName"
        case userId = "UserId"
        case isActive = "IsActive"
        case dateCreated = "DateCreated"
        case dateRevoked = "DateRevoked"
        case dateLastActivity = "DateLastActivity"
        case userName = "UserName"
    }
}
