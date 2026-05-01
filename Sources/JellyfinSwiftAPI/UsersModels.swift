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

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        serverId = try container.decodeIfPresent(String.self, forKey: .serverId)
        serverName = try container.decodeIfPresent(String.self, forKey: .serverName)
        id = try container.decodeJellyfinUUID(forKey: .id)
        primaryImageTag = try container.decodeIfPresent(String.self, forKey: .primaryImageTag)
        hasPassword = try container.decode(Bool.self, forKey: .hasPassword)
        hasConfiguredPassword = try container.decode(Bool.self, forKey: .hasConfiguredPassword)
        hasConfiguredEasyPassword = try container.decodeIfPresent(Bool.self, forKey: .hasConfiguredEasyPassword)
        enableAutoLogin = try container.decodeIfPresent(Bool.self, forKey: .enableAutoLogin)
        lastLoginDate = try container.decodeIfPresent(Date.self, forKey: .lastLoginDate)
        lastActivityDate = try container.decodeIfPresent(Date.self, forKey: .lastActivityDate)
        configuration = try container.decodeIfPresent(UserConfiguration.self, forKey: .configuration)
        policy = try container.decodeIfPresent(UserPolicy.self, forKey: .policy)
        primaryImageAspectRatio = try container.decodeIfPresent(Double.self, forKey: .primaryImageAspectRatio)
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

    public init(
        audioLanguagePreference: String? = nil,
        playDefaultAudioTrack: Bool,
        subtitleLanguagePreference: String? = nil,
        displayMissingEpisodes: Bool,
        groupedFolders: [UUID] = [],
        subtitleMode: SubtitlePlaybackMode,
        displayCollectionsView: Bool,
        enableLocalPassword: Bool,
        orderedViews: [UUID] = [],
        latestItemsExcludes: [UUID] = [],
        myMediaExcludes: [UUID] = [],
        hidePlayedInLatest: Bool,
        rememberAudioSelections: Bool,
        rememberSubtitleSelections: Bool,
        enableNextEpisodeAutoPlay: Bool,
        castReceiverId: String? = nil
    ) {
        self.audioLanguagePreference = audioLanguagePreference
        self.playDefaultAudioTrack = playDefaultAudioTrack
        self.subtitleLanguagePreference = subtitleLanguagePreference
        self.displayMissingEpisodes = displayMissingEpisodes
        self.groupedFolders = groupedFolders
        self.subtitleMode = subtitleMode
        self.displayCollectionsView = displayCollectionsView
        self.enableLocalPassword = enableLocalPassword
        self.orderedViews = orderedViews
        self.latestItemsExcludes = latestItemsExcludes
        self.myMediaExcludes = myMediaExcludes
        self.hidePlayedInLatest = hidePlayedInLatest
        self.rememberAudioSelections = rememberAudioSelections
        self.rememberSubtitleSelections = rememberSubtitleSelections
        self.enableNextEpisodeAutoPlay = enableNextEpisodeAutoPlay
        self.castReceiverId = castReceiverId
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        audioLanguagePreference = try container.decodeIfPresent(String.self, forKey: .audioLanguagePreference)
        playDefaultAudioTrack = try container.decode(Bool.self, forKey: .playDefaultAudioTrack)
        subtitleLanguagePreference = try container.decodeIfPresent(String.self, forKey: .subtitleLanguagePreference)
        displayMissingEpisodes = try container.decode(Bool.self, forKey: .displayMissingEpisodes)
        groupedFolders = try container.decodeJellyfinUUIDArray(forKey: .groupedFolders)
        subtitleMode = try container.decode(SubtitlePlaybackMode.self, forKey: .subtitleMode)
        displayCollectionsView = try container.decode(Bool.self, forKey: .displayCollectionsView)
        enableLocalPassword = try container.decode(Bool.self, forKey: .enableLocalPassword)
        orderedViews = try container.decodeJellyfinUUIDArray(forKey: .orderedViews)
        latestItemsExcludes = try container.decodeJellyfinUUIDArray(forKey: .latestItemsExcludes)
        myMediaExcludes = try container.decodeJellyfinUUIDArray(forKey: .myMediaExcludes)
        hidePlayedInLatest = try container.decode(Bool.self, forKey: .hidePlayedInLatest)
        rememberAudioSelections = try container.decode(Bool.self, forKey: .rememberAudioSelections)
        rememberSubtitleSelections = try container.decode(Bool.self, forKey: .rememberSubtitleSelections)
        enableNextEpisodeAutoPlay = try container.decode(Bool.self, forKey: .enableNextEpisodeAutoPlay)
        castReceiverId = try container.decodeIfPresent(String.self, forKey: .castReceiverId)
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

    public init(
        isAdministrator: Bool,
        isHidden: Bool,
        enableCollectionManagement: Bool,
        enableSubtitleManagement: Bool,
        enableLyricManagement: Bool,
        isDisabled: Bool,
        maxParentalRating: Int? = nil,
        maxParentalSubRating: Int? = nil,
        blockedTags: [String]? = nil,
        allowedTags: [String]? = nil,
        enableUserPreferenceAccess: Bool,
        accessSchedules: [AccessSchedule]? = nil,
        blockUnratedItems: [UnratedItem]? = nil,
        enableRemoteControlOfOtherUsers: Bool,
        enableSharedDeviceControl: Bool,
        enableRemoteAccess: Bool,
        enableLiveTvManagement: Bool,
        enableLiveTvAccess: Bool,
        enableMediaPlayback: Bool,
        enableAudioPlaybackTranscoding: Bool,
        enableVideoPlaybackTranscoding: Bool,
        enablePlaybackRemuxing: Bool,
        forceRemoteSourceTranscoding: Bool,
        enableContentDeletion: Bool,
        enableContentDeletionFromFolders: [String]? = nil,
        enableContentDownloading: Bool,
        enableSyncTranscoding: Bool,
        enableMediaConversion: Bool,
        enabledDevices: [String]? = nil,
        enableAllDevices: Bool,
        enabledChannels: [UUID]? = nil,
        enableAllChannels: Bool,
        enabledFolders: [UUID]? = nil,
        enableAllFolders: Bool,
        invalidLoginAttemptCount: Int,
        loginAttemptsBeforeLockout: Int,
        maxActiveSessions: Int,
        enablePublicSharing: Bool,
        blockedMediaFolders: [UUID]? = nil,
        blockedChannels: [UUID]? = nil,
        remoteClientBitrateLimit: Int,
        authenticationProviderId: String,
        passwordResetProviderId: String,
        syncPlayAccess: SyncPlayUserAccessType
    ) {
        self.isAdministrator = isAdministrator
        self.isHidden = isHidden
        self.enableCollectionManagement = enableCollectionManagement
        self.enableSubtitleManagement = enableSubtitleManagement
        self.enableLyricManagement = enableLyricManagement
        self.isDisabled = isDisabled
        self.maxParentalRating = maxParentalRating
        self.maxParentalSubRating = maxParentalSubRating
        self.blockedTags = blockedTags
        self.allowedTags = allowedTags
        self.enableUserPreferenceAccess = enableUserPreferenceAccess
        self.accessSchedules = accessSchedules
        self.blockUnratedItems = blockUnratedItems
        self.enableRemoteControlOfOtherUsers = enableRemoteControlOfOtherUsers
        self.enableSharedDeviceControl = enableSharedDeviceControl
        self.enableRemoteAccess = enableRemoteAccess
        self.enableLiveTvManagement = enableLiveTvManagement
        self.enableLiveTvAccess = enableLiveTvAccess
        self.enableMediaPlayback = enableMediaPlayback
        self.enableAudioPlaybackTranscoding = enableAudioPlaybackTranscoding
        self.enableVideoPlaybackTranscoding = enableVideoPlaybackTranscoding
        self.enablePlaybackRemuxing = enablePlaybackRemuxing
        self.forceRemoteSourceTranscoding = forceRemoteSourceTranscoding
        self.enableContentDeletion = enableContentDeletion
        self.enableContentDeletionFromFolders = enableContentDeletionFromFolders
        self.enableContentDownloading = enableContentDownloading
        self.enableSyncTranscoding = enableSyncTranscoding
        self.enableMediaConversion = enableMediaConversion
        self.enabledDevices = enabledDevices
        self.enableAllDevices = enableAllDevices
        self.enabledChannels = enabledChannels
        self.enableAllChannels = enableAllChannels
        self.enabledFolders = enabledFolders
        self.enableAllFolders = enableAllFolders
        self.invalidLoginAttemptCount = invalidLoginAttemptCount
        self.loginAttemptsBeforeLockout = loginAttemptsBeforeLockout
        self.maxActiveSessions = maxActiveSessions
        self.enablePublicSharing = enablePublicSharing
        self.blockedMediaFolders = blockedMediaFolders
        self.blockedChannels = blockedChannels
        self.remoteClientBitrateLimit = remoteClientBitrateLimit
        self.authenticationProviderId = authenticationProviderId
        self.passwordResetProviderId = passwordResetProviderId
        self.syncPlayAccess = syncPlayAccess
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isAdministrator = try container.decode(Bool.self, forKey: .isAdministrator)
        isHidden = try container.decode(Bool.self, forKey: .isHidden)
        enableCollectionManagement = try container.decode(Bool.self, forKey: .enableCollectionManagement)
        enableSubtitleManagement = try container.decode(Bool.self, forKey: .enableSubtitleManagement)
        enableLyricManagement = try container.decode(Bool.self, forKey: .enableLyricManagement)
        isDisabled = try container.decode(Bool.self, forKey: .isDisabled)
        maxParentalRating = try container.decodeIfPresent(Int.self, forKey: .maxParentalRating)
        maxParentalSubRating = try container.decodeIfPresent(Int.self, forKey: .maxParentalSubRating)
        blockedTags = try container.decodeIfPresent([String].self, forKey: .blockedTags)
        allowedTags = try container.decodeIfPresent([String].self, forKey: .allowedTags)
        enableUserPreferenceAccess = try container.decode(Bool.self, forKey: .enableUserPreferenceAccess)
        accessSchedules = try container.decodeIfPresent([AccessSchedule].self, forKey: .accessSchedules)
        blockUnratedItems = try container.decodeIfPresent([UnratedItem].self, forKey: .blockUnratedItems)
        enableRemoteControlOfOtherUsers = try container.decode(Bool.self, forKey: .enableRemoteControlOfOtherUsers)
        enableSharedDeviceControl = try container.decode(Bool.self, forKey: .enableSharedDeviceControl)
        enableRemoteAccess = try container.decode(Bool.self, forKey: .enableRemoteAccess)
        enableLiveTvManagement = try container.decode(Bool.self, forKey: .enableLiveTvManagement)
        enableLiveTvAccess = try container.decode(Bool.self, forKey: .enableLiveTvAccess)
        enableMediaPlayback = try container.decode(Bool.self, forKey: .enableMediaPlayback)
        enableAudioPlaybackTranscoding = try container.decode(Bool.self, forKey: .enableAudioPlaybackTranscoding)
        enableVideoPlaybackTranscoding = try container.decode(Bool.self, forKey: .enableVideoPlaybackTranscoding)
        enablePlaybackRemuxing = try container.decode(Bool.self, forKey: .enablePlaybackRemuxing)
        forceRemoteSourceTranscoding = try container.decode(Bool.self, forKey: .forceRemoteSourceTranscoding)
        enableContentDeletion = try container.decode(Bool.self, forKey: .enableContentDeletion)
        enableContentDeletionFromFolders = try container.decodeIfPresent([String].self, forKey: .enableContentDeletionFromFolders)
        enableContentDownloading = try container.decode(Bool.self, forKey: .enableContentDownloading)
        enableSyncTranscoding = try container.decode(Bool.self, forKey: .enableSyncTranscoding)
        enableMediaConversion = try container.decode(Bool.self, forKey: .enableMediaConversion)
        enabledDevices = try container.decodeIfPresent([String].self, forKey: .enabledDevices)
        enableAllDevices = try container.decode(Bool.self, forKey: .enableAllDevices)
        enabledChannels = try container.decodeJellyfinUUIDArrayIfPresent(forKey: .enabledChannels)
        enableAllChannels = try container.decode(Bool.self, forKey: .enableAllChannels)
        enabledFolders = try container.decodeJellyfinUUIDArrayIfPresent(forKey: .enabledFolders)
        enableAllFolders = try container.decode(Bool.self, forKey: .enableAllFolders)
        invalidLoginAttemptCount = try container.decode(Int.self, forKey: .invalidLoginAttemptCount)
        loginAttemptsBeforeLockout = try container.decode(Int.self, forKey: .loginAttemptsBeforeLockout)
        maxActiveSessions = try container.decode(Int.self, forKey: .maxActiveSessions)
        enablePublicSharing = try container.decode(Bool.self, forKey: .enablePublicSharing)
        blockedMediaFolders = try container.decodeJellyfinUUIDArrayIfPresent(forKey: .blockedMediaFolders)
        blockedChannels = try container.decodeJellyfinUUIDArrayIfPresent(forKey: .blockedChannels)
        remoteClientBitrateLimit = try container.decode(Int.self, forKey: .remoteClientBitrateLimit)
        authenticationProviderId = try container.decode(String.self, forKey: .authenticationProviderId)
        passwordResetProviderId = try container.decode(String.self, forKey: .passwordResetProviderId)
        syncPlayAccess = try container.decode(SyncPlayUserAccessType.self, forKey: .syncPlayAccess)
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

    public init(
        id: Int,
        userId: UUID,
        dayOfWeek: DynamicDayOfWeek,
        startHour: Double,
        endHour: Double
    ) {
        self.id = id
        self.userId = userId
        self.dayOfWeek = dayOfWeek
        self.startHour = startHour
        self.endHour = endHour
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        userId = try container.decodeJellyfinUUID(forKey: .userId)
        dayOfWeek = try container.decode(DynamicDayOfWeek.self, forKey: .dayOfWeek)
        startHour = try container.decode(Double.self, forKey: .startHour)
        endHour = try container.decode(Double.self, forKey: .endHour)
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

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        customName = try container.decodeIfPresent(String.self, forKey: .customName)
        accessToken = try container.decodeIfPresent(String.self, forKey: .accessToken)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        lastUserName = try container.decodeIfPresent(String.self, forKey: .lastUserName)
        appName = try container.decodeIfPresent(String.self, forKey: .appName)
        appVersion = try container.decodeIfPresent(String.self, forKey: .appVersion)
        lastUserId = try container.decodeJellyfinUUIDIfPresent(forKey: .lastUserId)
        dateLastActivity = try container.decodeIfPresent(Date.self, forKey: .dateLastActivity)
        capabilities = try container.decodeIfPresent(ClientCapabilities.self, forKey: .capabilities)
        iconUrl = try container.decodeIfPresent(String.self, forKey: .iconUrl)
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
