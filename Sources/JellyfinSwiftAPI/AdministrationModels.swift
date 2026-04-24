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
}

/// Branding configuration fields.
public struct BrandingConfiguration: Codable, Sendable, Equatable {
    public let loginDisclaimer: String?
    public let customCss: String?
    public let splashscreenEnabled: Bool?

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
}

/// Default directory-browser response.
public struct DefaultDirectoryBrowserInfo: Codable, Sendable, Equatable {
    public let path: String?
}

/// File-system entry returned by environment endpoints.
public struct FileSystemEntry: Codable, Sendable, Equatable {
    public let name: String?
    public let path: String?
    public let type: String?
}

/// Path validation request.
public struct ValidatePathRequest: Codable, Sendable, Equatable {
    public let validateWritable: Bool?
    public let path: String
    public let isFile: Bool?

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

    public init(enableRemoteAccess: Bool? = nil, enableAutomaticPortMapping: Bool? = nil) {
        self.enableRemoteAccess = enableRemoteAccess
        self.enableAutomaticPortMapping = enableAutomaticPortMapping
    }
}

/// Startup wizard user payload.
public struct StartupUser: Codable, Sendable, Equatable {
    public let name: String?
    public let password: String?

    public init(name: String? = nil, password: String? = nil) {
        self.name = name
        self.password = password
    }
}

/// Scheduled task status.
public struct ScheduledTask: Codable, Sendable, Equatable {
    public let name: String?
    public let state: String?
    public let currentProgressPercentage: Double?
    public let id: String?
    public let lastExecutionResult: ScheduledTaskResult?
    public let triggers: [ScheduledTaskTrigger]?
    public let description: String?
    public let category: String?
    public let isHidden: Bool?
    public let key: String?
}

/// Scheduled task trigger information.
public struct ScheduledTaskTrigger: Codable, Sendable, Equatable {
    public let type: String?
    public let timeOfDayTicks: Int64?
    public let intervalTicks: Int64?
    public let dayOfWeek: String?
    public let maxRuntimeTicks: Int64?
}

/// Last scheduled task result.
public struct ScheduledTaskResult: Codable, Sendable, Equatable {
    public let startTimeUtc: Date?
    public let endTimeUtc: Date?
    public let status: String?
    public let name: String?
    public let key: String?
    public let id: String?
    public let errorMessage: String?
    public let longErrorMessage: String?
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
    public let status: String?
}

/// Plugin repository entry.
public struct RepositoryInfo: Codable, Sendable, Equatable {
    public let name: String?
    public let url: String?
    public let enabled: Bool?

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
}

/// Backup creation options.
public struct BackupOptions: Codable, Sendable, Equatable {
    public let metadata: Bool?
    public let trickplay: Bool?
    public let subtitles: Bool?
    public let database: Bool?

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

    public init(archiveFileName: String? = nil) {
        self.archiveFileName = archiveFileName
    }
}

/// Activity log query result.
public struct ActivityLogQueryResult: Codable, Sendable, Equatable {
    public let items: [ActivityLogEntry]
    public let totalRecordCount: Int?
    public let startIndex: Int?
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
    public let severity: String?
}

/// Client-log upload response.
public struct ClientLogUploadResponse: Codable, Sendable, Equatable {
    public let fileName: String?
}

/// API key query result.
public struct APIKeyQueryResult: Codable, Sendable, Equatable {
    public let items: [APIKeyInfo]
    public let totalRecordCount: Int?
    public let startIndex: Int?
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
}
