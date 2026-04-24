import Foundation

/// A Jellyfin user.
public struct User: Codable, Sendable, Equatable {
    public let name: String?
    public let serverId: String?
    public let serverName: String?
    public let id: UUID
    public let primaryImageTag: String?
    public let hasPassword: Bool
    public let hasConfiguredPassword: Bool
    public let hasConfiguredEasyPassword: Bool?
    public let enableAutoLogin: Bool?
    public let lastLoginDate: Date?
    public let lastActivityDate: Date?
    public let configuration: UserConfiguration?
    public let policy: UserPolicy?
    public let primaryImageAspectRatio: Double?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case serverId = "ServerId"
        case serverName = "ServerName"
        case id = "Id"
        case primaryImageTag = "PrimaryImageTag"
        case hasPassword = "HasPassword"
        case hasConfiguredPassword = "HasConfiguredPassword"
        case hasConfiguredEasyPassword = "HasConfiguredEasyPassword"
        case enableAutoLogin = "EnableAutoLogin"
        case lastLoginDate = "LastLoginDate"
        case lastActivityDate = "LastActivityDate"
        case configuration = "Configuration"
        case policy = "Policy"
        case primaryImageAspectRatio = "PrimaryImageAspectRatio"
    }
}

/// User configuration settings.
public struct UserConfiguration: Codable, Sendable, Equatable {
    public let audioLanguagePreference: String?
    public let playDefaultAudioTrack: Bool
    public let subtitleLanguagePreference: String?
    public let displayMissingEpisodes: Bool
    public let groupedFolders: [UUID]
    public let subtitleMode: SubtitlePlaybackMode
    public let displayCollectionsView: Bool
    public let enableLocalPassword: Bool
    public let orderedViews: [UUID]
    public let latestItemsExcludes: [UUID]
    public let myMediaExcludes: [UUID]
    public let hidePlayedInLatest: Bool
    public let rememberAudioSelections: Bool
    public let rememberSubtitleSelections: Bool
    public let enableNextEpisodeAutoPlay: Bool
    public let castReceiverId: String?

    enum CodingKeys: String, CodingKey {
        case audioLanguagePreference = "AudioLanguagePreference"
        case playDefaultAudioTrack = "PlayDefaultAudioTrack"
        case subtitleLanguagePreference = "SubtitleLanguagePreference"
        case displayMissingEpisodes = "DisplayMissingEpisodes"
        case groupedFolders = "GroupedFolders"
        case subtitleMode = "SubtitleMode"
        case displayCollectionsView = "DisplayCollectionsView"
        case enableLocalPassword = "EnableLocalPassword"
        case orderedViews = "OrderedViews"
        case latestItemsExcludes = "LatestItemsExcludes"
        case myMediaExcludes = "MyMediaExcludes"
        case hidePlayedInLatest = "HidePlayedInLatest"
        case rememberAudioSelections = "RememberAudioSelections"
        case rememberSubtitleSelections = "RememberSubtitleSelections"
        case enableNextEpisodeAutoPlay = "EnableNextEpisodeAutoPlay"
        case castReceiverId = "CastReceiverId"
    }
}

/// Subtitle playback behavior preference.
public enum SubtitlePlaybackMode: String, Codable, Sendable, Equatable {
    case `default` = "Default"
    case always = "Always"
    case onlyForced = "OnlyForced"
    case none = "None"
    case smart = "Smart"
}

/// User access policy.
public struct UserPolicy: Codable, Sendable, Equatable {
    public let isAdministrator: Bool
    public let isHidden: Bool
    public let enableCollectionManagement: Bool
    public let enableSubtitleManagement: Bool
    public let enableLyricManagement: Bool
    public let isDisabled: Bool
    public let maxParentalRating: Int?
    public let maxParentalSubRating: Int?
    public let blockedTags: [String]?
    public let allowedTags: [String]?
    public let enableUserPreferenceAccess: Bool
    public let accessSchedules: [AccessSchedule]?
    public let blockUnratedItems: [UnratedItem]?
    public let enableRemoteControlOfOtherUsers: Bool
    public let enableSharedDeviceControl: Bool
    public let enableRemoteAccess: Bool
    public let enableLiveTvManagement: Bool
    public let enableLiveTvAccess: Bool
    public let enableMediaPlayback: Bool
    public let enableAudioPlaybackTranscoding: Bool
    public let enableVideoPlaybackTranscoding: Bool
    public let enablePlaybackRemuxing: Bool
    public let forceRemoteSourceTranscoding: Bool
    public let enableContentDeletion: Bool
    public let enableContentDeletionFromFolders: [String]?
    public let enableContentDownloading: Bool
    public let enableSyncTranscoding: Bool
    public let enableMediaConversion: Bool
    public let enabledDevices: [String]?
    public let enableAllDevices: Bool
    public let enabledChannels: [UUID]?
    public let enableAllChannels: Bool
    public let enabledFolders: [UUID]?
    public let enableAllFolders: Bool
    public let invalidLoginAttemptCount: Int
    public let loginAttemptsBeforeLockout: Int
    public let maxActiveSessions: Int
    public let enablePublicSharing: Bool
    public let blockedMediaFolders: [UUID]?
    public let blockedChannels: [UUID]?
    public let remoteClientBitrateLimit: Int
    public let authenticationProviderId: String
    public let passwordResetProviderId: String
    public let syncPlayAccess: SyncPlayUserAccessType

    enum CodingKeys: String, CodingKey {
        case isAdministrator = "IsAdministrator"
        case isHidden = "IsHidden"
        case enableCollectionManagement = "EnableCollectionManagement"
        case enableSubtitleManagement = "EnableSubtitleManagement"
        case enableLyricManagement = "EnableLyricManagement"
        case isDisabled = "IsDisabled"
        case maxParentalRating = "MaxParentalRating"
        case maxParentalSubRating = "MaxParentalSubRating"
        case blockedTags = "BlockedTags"
        case allowedTags = "AllowedTags"
        case enableUserPreferenceAccess = "EnableUserPreferenceAccess"
        case accessSchedules = "AccessSchedules"
        case blockUnratedItems = "BlockUnratedItems"
        case enableRemoteControlOfOtherUsers = "EnableRemoteControlOfOtherUsers"
        case enableSharedDeviceControl = "EnableSharedDeviceControl"
        case enableRemoteAccess = "EnableRemoteAccess"
        case enableLiveTvManagement = "EnableLiveTvManagement"
        case enableLiveTvAccess = "EnableLiveTvAccess"
        case enableMediaPlayback = "EnableMediaPlayback"
        case enableAudioPlaybackTranscoding = "EnableAudioPlaybackTranscoding"
        case enableVideoPlaybackTranscoding = "EnableVideoPlaybackTranscoding"
        case enablePlaybackRemuxing = "EnablePlaybackRemuxing"
        case forceRemoteSourceTranscoding = "ForceRemoteSourceTranscoding"
        case enableContentDeletion = "EnableContentDeletion"
        case enableContentDeletionFromFolders = "EnableContentDeletionFromFolders"
        case enableContentDownloading = "EnableContentDownloading"
        case enableSyncTranscoding = "EnableSyncTranscoding"
        case enableMediaConversion = "EnableMediaConversion"
        case enabledDevices = "EnabledDevices"
        case enableAllDevices = "EnableAllDevices"
        case enabledChannels = "EnabledChannels"
        case enableAllChannels = "EnableAllChannels"
        case enabledFolders = "EnabledFolders"
        case enableAllFolders = "EnableAllFolders"
        case invalidLoginAttemptCount = "InvalidLoginAttemptCount"
        case loginAttemptsBeforeLockout = "LoginAttemptsBeforeLockout"
        case maxActiveSessions = "MaxActiveSessions"
        case enablePublicSharing = "EnablePublicSharing"
        case blockedMediaFolders = "BlockedMediaFolders"
        case blockedChannels = "BlockedChannels"
        case remoteClientBitrateLimit = "RemoteClientBitrateLimit"
        case authenticationProviderId = "AuthenticationProviderId"
        case passwordResetProviderId = "PasswordResetProviderId"
        case syncPlayAccess = "SyncPlayAccess"
    }
}

/// Allowed SyncPlay access for a user.
public enum SyncPlayUserAccessType: String, Codable, Sendable, Equatable {
    case createAndJoinGroups = "CreateAndJoinGroups"
    case joinGroups = "JoinGroups"
    case none = "None"
}

/// Access schedule assigned to a user.
public struct AccessSchedule: Codable, Sendable, Equatable {
    public let id: Int
    public let userId: UUID
    public let dayOfWeek: DynamicDayOfWeek
    public let startHour: Double
    public let endHour: Double

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case userId = "UserId"
        case dayOfWeek = "DayOfWeek"
        case startHour = "StartHour"
        case endHour = "EndHour"
    }
}

/// Supported day-of-week values for access schedules.
public enum DynamicDayOfWeek: String, Codable, Sendable, Equatable {
    case sunday = "Sunday"
    case monday = "Monday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
    case thursday = "Thursday"
    case friday = "Friday"
    case saturday = "Saturday"
    case everyday = "Everyday"
    case weekday = "Weekday"
    case weekend = "Weekend"
}

/// Unrated item categories blocked by policy.
public enum UnratedItem: String, Codable, Sendable, Equatable {
    case movie = "Movie"
    case trailer = "Trailer"
    case series = "Series"
    case music = "Music"
    case book = "Book"
    case liveTvChannel = "LiveTvChannel"
    case liveTvProgram = "LiveTvProgram"
    case channelContent = "ChannelContent"
    case other = "Other"
}

/// Device query result container.
public struct DeviceQueryResult: Codable, Sendable, Equatable {
    public let items: [DeviceInfo]
    public let totalRecordCount: Int
    public let startIndex: Int

    enum CodingKeys: String, CodingKey {
        case items = "Items"
        case totalRecordCount = "TotalRecordCount"
        case startIndex = "StartIndex"
    }
}

/// Device information entry.
public struct DeviceInfo: Codable, Sendable, Equatable {
    public let name: String?
    public let customName: String?
    public let accessToken: String?
    public let id: String?
    public let lastUserName: String?
    public let appName: String?
    public let appVersion: String?
    public let lastUserId: UUID?
    public let dateLastActivity: Date?
    public let capabilities: ClientCapabilities?
    public let iconUrl: String?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case customName = "CustomName"
        case accessToken = "AccessToken"
        case id = "Id"
        case lastUserName = "LastUserName"
        case appName = "AppName"
        case appVersion = "AppVersion"
        case lastUserId = "LastUserId"
        case dateLastActivity = "DateLastActivity"
        case capabilities = "Capabilities"
        case iconUrl = "IconUrl"
    }
}

/// Client capability metadata.
public struct ClientCapabilities: Codable, Sendable, Equatable {
    public let playableMediaTypes: [MediaType]?
    public let supportedCommands: [String]?
    public let supportsMediaControl: Bool?
    public let supportsPersistentIdentifier: Bool?
    public let appStoreUrl: String?
    public let iconUrl: String?

    enum CodingKeys: String, CodingKey {
        case playableMediaTypes = "PlayableMediaTypes"
        case supportedCommands = "SupportedCommands"
        case supportsMediaControl = "SupportsMediaControl"
        case supportsPersistentIdentifier = "SupportsPersistentIdentifier"
        case appStoreUrl = "AppStoreUrl"
        case iconUrl = "IconUrl"
    }
}

/// Supported media types.
public enum MediaType: String, Codable, Sendable, Equatable {
    case unknown = "Unknown"
    case video = "Video"
    case audio = "Audio"
    case photo = "Photo"
    case book = "Book"
}

/// Device custom options.
public struct DeviceOptions: Codable, Sendable, Equatable {
    public let id: Int
    public let deviceId: String?
    public let customName: String?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case deviceId = "DeviceId"
        case customName = "CustomName"
    }
}

/// Display preferences for a user/client pair.
public struct DisplayPreferences: Codable, Sendable, Equatable {
    public let id: String?
    public let viewType: String?
    public let sortBy: String?
    public let indexBy: String?
    public let rememberIndexing: Bool
    public let primaryImageHeight: Int
    public let primaryImageWidth: Int
    public let customPrefs: [String: String?]
    public let scrollDirection: ScrollDirection
    public let showBackdrop: Bool
    public let rememberSorting: Bool
    public let sortOrder: SortOrder
    public let showSidebar: Bool
    public let client: String?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case viewType = "ViewType"
        case sortBy = "SortBy"
        case indexBy = "IndexBy"
        case rememberIndexing = "RememberIndexing"
        case primaryImageHeight = "PrimaryImageHeight"
        case primaryImageWidth = "PrimaryImageWidth"
        case customPrefs = "CustomPrefs"
        case scrollDirection = "ScrollDirection"
        case showBackdrop = "ShowBackdrop"
        case rememberSorting = "RememberSorting"
        case sortOrder = "SortOrder"
        case showSidebar = "ShowSidebar"
        case client = "Client"
    }
}

/// Display scroll direction preference.
public enum ScrollDirection: String, Codable, Sendable, Equatable {
    case horizontal = "Horizontal"
    case vertical = "Vertical"
}

/// Display sort order preference.
public enum SortOrder: String, Codable, Sendable, Equatable {
    case ascending = "Ascending"
    case descending = "Descending"
}

/// Request body used to update a user's password.
public struct UpdateUserPasswordRequest: Codable, Sendable, Equatable {
    public let currentPassword: String?
    public let currentPw: String?
    public let newPw: String?
    public let resetPassword: Bool

    enum CodingKeys: String, CodingKey {
        case currentPassword = "CurrentPassword"
        case currentPw = "CurrentPw"
        case newPw = "NewPw"
        case resetPassword = "ResetPassword"
    }
}
