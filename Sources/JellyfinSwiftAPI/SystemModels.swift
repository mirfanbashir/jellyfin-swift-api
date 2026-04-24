import Foundation

/// Network visibility information for the current Jellyfin endpoint.
public struct EndpointInfo: Codable, Sendable, Equatable {
    public let isLocal: Bool
    public let isInNetwork: Bool
}

/// Detailed information about the Jellyfin server instance.
public struct SystemInfo: Codable, Sendable, Equatable {
    public let localAddress: String?
    public let serverName: String?
    public let version: String?
    public let productName: String?
    public let operatingSystem: String?
    public let id: String?
    public let startupWizardCompleted: Bool?
    public let operatingSystemDisplayName: String?
    public let packageName: String?
    public let hasPendingRestart: Bool
    public let isShuttingDown: Bool
    public let supportsLibraryMonitor: Bool
    public let webSocketPortNumber: Int
    public let completedInstallations: [InstallationInfo]?
    public let canSelfRestart: Bool?
    public let canLaunchWebBrowser: Bool?
    public let programDataPath: String?
    public let webPath: String?
    public let itemsByNamePath: String?
    public let cachePath: String?
    public let logPath: String?
    public let internalMetadataPath: String?
    public let transcodingTempPath: String?
    public let castReceiverApplications: [CastReceiverApplication]?
    public let hasUpdateAvailable: Bool?
    public let encoderLocation: String?
    public let systemArchitecture: String?
}

/// Publicly available Jellyfin server information.
public struct PublicSystemInfo: Codable, Sendable, Equatable {
    public let localAddress: String?
    public let serverName: String?
    public let version: String?
    public let productName: String?
    public let operatingSystem: String?
    public let id: String?
    public let startupWizardCompleted: Bool?
}

/// Storage information for the Jellyfin server.
public struct SystemStorage: Codable, Sendable, Equatable {
    public let programDataFolder: FolderStorage?
    public let webFolder: FolderStorage?
    public let imageCacheFolder: FolderStorage?
    public let cacheFolder: FolderStorage?
    public let logFolder: FolderStorage?
    public let internalMetadataFolder: FolderStorage?
    public let transcodingTempFolder: FolderStorage?
    public let libraries: [LibraryStorage]?
}

/// A single folder storage description.
public struct FolderStorage: Codable, Sendable, Equatable {
    public let path: String
    public let freeSpace: Int64
    public let usedSpace: Int64
    public let storageType: String?
    public let deviceId: String?
}

/// Storage information for a Jellyfin library.
public struct LibraryStorage: Codable, Sendable, Equatable {
    public let id: UUID
    public let name: String
    public let folders: [FolderStorage]
}

/// A server log file entry.
public struct LogFile: Codable, Sendable, Equatable {
    public let dateCreated: Date
    public let dateModified: Date
    public let size: Int64
    public let name: String
}

/// Public branding settings.
public struct BrandingOptions: Codable, Sendable, Equatable {
    public let loginDisclaimer: String?
    public let customCss: String?
    public let splashscreenEnabled: Bool
}

/// A country entry returned by localization endpoints.
public struct CountryInfo: Codable, Sendable, Equatable {
    public let name: String?
    public let displayName: String?
    public let twoLetterISORegionName: String?
    public let threeLetterISORegionName: String?
}

/// A culture entry returned by localization endpoints.
public struct Culture: Codable, Sendable, Equatable {
    public let name: String
    public let displayName: String
    public let twoLetterISOLanguageName: String
    public let threeLetterISOLanguageName: String?
    public let threeLetterISOLanguageNames: [String]
}

/// A localization option entry.
public struct LocalizationOption: Codable, Sendable, Equatable {
    public let name: String?
    public let value: String?
}

/// A parental rating entry.
public struct ParentalRating: Codable, Sendable, Equatable {
    public let name: String
    public let value: Int?
    public let ratingScore: ParentalRatingScore?
}

/// A parental rating score entry.
public struct ParentalRatingScore: Codable, Sendable, Equatable {
    public let score: Int
    public let subScore: Int?
}

/// UTC synchronization timestamps returned by the server.
public struct UtcTimeResponse: Codable, Sendable, Equatable {
    public let requestReceptionTime: Date
    public let responseTransmissionTime: Date
}

/// TMDb image configuration used by the server.
public struct TmdbClientConfiguration: Codable, Sendable, Equatable {
    public let backdropSizes: [String]?
    public let baseUrl: String?
    public let logoSizes: [String]?
    public let posterSizes: [String]?
    public let profileSizes: [String]?
    public let secureBaseUrl: String?
    public let stillSizes: [String]?
}

/// Installation information reported by the server.
public struct InstallationInfo: Codable, Sendable, Equatable {
    public let guid: UUID
    public let name: String?
    public let version: String?
    public let changelog: String?
    public let sourceUrl: String?
    public let checksum: String?
    public let packageInfo: PackageInfo?
}

/// Package metadata associated with an installation.
public struct PackageInfo: Codable, Sendable, Equatable {
    public let name: String
    public let description: String
    public let overview: String
    public let owner: String
    public let category: String
    public let guid: UUID
    public let versions: [PackageVersionInfo]
    public let imageUrl: String?
}

/// Version metadata for a package.
public struct PackageVersionInfo: Codable, Sendable, Equatable {
    public let version: String
    public let versionNumber: String
    public let changelog: String?
    public let targetAbi: String?
    public let sourceUrl: String?
    public let checksum: String?
    public let timestamp: String?
    public let repositoryName: String
    public let repositoryUrl: String
}

/// A cast receiver application supported by the server.
public struct CastReceiverApplication: Codable, Sendable, Equatable {
    public let id: String
    public let name: String
}
