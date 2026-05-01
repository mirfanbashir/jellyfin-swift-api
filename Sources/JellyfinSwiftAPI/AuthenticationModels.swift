import Foundation

/// Authentication result returned by Jellyfin sign-in endpoints.
public struct AuthenticationResult: Codable, Sendable, Equatable {
    public let user: AuthenticatedUser?
    public let sessionInfo: AuthenticationSessionInfo?
    public let accessToken: String?
    public let serverId: String?

    enum CodingKeys: String, CodingKey {
        case user = "User"
        case sessionInfo = "SessionInfo"
        case accessToken = "AccessToken"
        case serverId = "ServerId"
    }
}

/// User information embedded in an authentication response.
public struct AuthenticatedUser: Codable, Sendable, Equatable {
    public let name: String?
    public let serverId: String?
    public let id: String
    public let hasPassword: Bool
    public let hasConfiguredPassword: Bool
    public let hasConfiguredEasyPassword: Bool?
    public let enableAutoLogin: Bool?
    public let lastLoginDate: Date?
    public let lastActivityDate: Date?
    public let configuration: AuthenticatedUserConfiguration?
    public let policy: AuthenticatedUserPolicy?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case serverId = "ServerId"
        case id = "Id"
        case hasPassword = "HasPassword"
        case hasConfiguredPassword = "HasConfiguredPassword"
        case hasConfiguredEasyPassword = "HasConfiguredEasyPassword"
        case enableAutoLogin = "EnableAutoLogin"
        case lastLoginDate = "LastLoginDate"
        case lastActivityDate = "LastActivityDate"
        case configuration = "Configuration"
        case policy = "Policy"
    }
}

/// User configuration embedded in an authentication response.
public struct AuthenticatedUserConfiguration: Codable, Sendable, Equatable {
    public let audioLanguagePreference: String?
    public let playDefaultAudioTrack: Bool
    public let subtitleLanguagePreference: String?
    public let displayMissingEpisodes: Bool
    public let groupedFolders: [String]
    public let subtitleMode: SubtitlePlaybackMode
    public let displayCollectionsView: Bool
    public let enableLocalPassword: Bool
    public let orderedViews: [String]
    public let latestItemsExcludes: [String]
    public let myMediaExcludes: [String]
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

/// User access policy embedded in an authentication response.
public struct AuthenticatedUserPolicy: Codable, Sendable, Equatable {
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
    public let accessSchedules: [AuthenticatedUserAccessSchedule]?
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
    public let enabledChannels: [String]?
    public let enableAllChannels: Bool
    public let enabledFolders: [String]?
    public let enableAllFolders: Bool
    public let invalidLoginAttemptCount: Int
    public let loginAttemptsBeforeLockout: Int
    public let maxActiveSessions: Int
    public let enablePublicSharing: Bool
    public let blockedMediaFolders: [String]?
    public let blockedChannels: [String]?
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

/// Access schedule embedded in an authentication response.
public struct AuthenticatedUserAccessSchedule: Codable, Sendable, Equatable {
    public let id: Int
    public let userId: String
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

/// Session information returned alongside authentication results.
public struct AuthenticationSessionInfo: Codable, Sendable, Equatable {
    public let playState: AuthenticationSessionPlayState?
    public let additionalUsers: [AuthenticationSessionUserInfo]?
    public let capabilities: ClientCapabilities?
    public let playableMediaTypes: [MediaType]?
    public let id: String?
    public let userId: String?
    public let userName: String?
    public let client: String?
    public let lastActivityDate: Date?
    public let lastPlaybackCheckIn: Date?
    public let deviceName: String?
    public let deviceId: String?
    public let applicationVersion: String?
    public let isActive: Bool?
    public let supportsMediaControl: Bool?
    public let supportsRemoteControl: Bool?
    public let nowPlayingQueue: [AuthenticationSessionQueueItem]?
    public let hasCustomDeviceName: Bool?
    public let serverId: String?
    public let supportedCommands: [String]?

    enum CodingKeys: String, CodingKey {
        case playState = "PlayState"
        case additionalUsers = "AdditionalUsers"
        case capabilities = "Capabilities"
        case playableMediaTypes = "PlayableMediaTypes"
        case id = "Id"
        case userId = "UserId"
        case userName = "UserName"
        case client = "Client"
        case lastActivityDate = "LastActivityDate"
        case lastPlaybackCheckIn = "LastPlaybackCheckIn"
        case deviceName = "DeviceName"
        case deviceId = "DeviceId"
        case applicationVersion = "ApplicationVersion"
        case isActive = "IsActive"
        case supportsMediaControl = "SupportsMediaControl"
        case supportsRemoteControl = "SupportsRemoteControl"
        case nowPlayingQueue = "NowPlayingQueue"
        case hasCustomDeviceName = "HasCustomDeviceName"
        case serverId = "ServerId"
        case supportedCommands = "SupportedCommands"
    }
}

/// Session playback state embedded in an authentication response.
public struct AuthenticationSessionPlayState: Codable, Sendable, Equatable {
    public let canSeek: Bool?
    public let isPaused: Bool?
    public let isMuted: Bool?
    public let repeatMode: SessionRepeatMode?
    public let playbackOrder: SessionPlaybackOrder?

    enum CodingKeys: String, CodingKey {
        case canSeek = "CanSeek"
        case isPaused = "IsPaused"
        case isMuted = "IsMuted"
        case repeatMode = "RepeatMode"
        case playbackOrder = "PlaybackOrder"
    }
}

/// Additional user metadata embedded in an authentication session.
public struct AuthenticationSessionUserInfo: Codable, Sendable, Equatable {
    public let userId: String?
    public let userName: String?

    enum CodingKeys: String, CodingKey {
        case userId = "UserId"
        case userName = "UserName"
    }
}

/// Queue item metadata embedded in an authentication session.
public struct AuthenticationSessionQueueItem: Codable, Sendable, Equatable {
    public let id: String?
    public let playlistItemId: String?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case playlistItemId = "PlaylistItemId"
    }
}

/// Result of a forgot-password request.
public struct ForgotPasswordResult: Codable, Sendable, Equatable {
    public let action: ForgotPasswordAction
    public let pinFile: String?
    public let pinExpirationDate: Date?

    enum CodingKeys: String, CodingKey {
        case action = "Action"
        case pinFile = "PinFile"
        case pinExpirationDate = "PinExpirationDate"
    }
}

/// Actions Jellyfin can require for password reset.
public enum ForgotPasswordAction: String, Codable, Sendable, Equatable {
    case contactAdmin = "ContactAdmin"
    case pinCode = "PinCode"
    case inNetworkRequired = "InNetworkRequired"
}

/// Result of redeeming a password-reset PIN.
public struct PinRedeemResult: Codable, Sendable, Equatable {
    public let success: Bool
    public let usersReset: [String]

    enum CodingKeys: String, CodingKey {
        case success = "Success"
        case usersReset = "UsersReset"
    }
}

/// Name/identifier pair used by authentication provider endpoints.
public struct NameIDPair: Codable, Sendable, Equatable {
    public let name: String?
    public let id: String?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case id = "Id"
    }
}

/// Quick Connect state returned by the server.
public struct QuickConnectResult: Codable, Sendable, Equatable {
    public let authenticated: Bool
    public let secret: String
    public let code: String
    public let deviceId: String
    public let deviceName: String
    public let appName: String
    public let appVersion: String
    public let dateAdded: Date

    enum CodingKeys: String, CodingKey {
        case authenticated = "Authenticated"
        case secret = "Secret"
        case code = "Code"
        case deviceId = "DeviceId"
        case deviceName = "DeviceName"
        case appName = "AppName"
        case appVersion = "AppVersion"
        case dateAdded = "DateAdded"
    }
}
