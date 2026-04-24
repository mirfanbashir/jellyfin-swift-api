import Foundation

/// Authentication result returned by Jellyfin sign-in endpoints.
public struct AuthenticationResult: Codable, Sendable, Equatable {
    public let user: User?
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

/// Session information returned alongside authentication results.
public struct AuthenticationSessionInfo: Codable, Sendable, Equatable {
    public let id: String?
    public let userId: UUID
    public let userName: String?
    public let client: String?
    public let lastActivityDate: Date
    public let lastPlaybackCheckIn: Date
    public let lastPausedDate: Date?
    public let deviceName: String?
    public let deviceType: String?
    public let deviceId: String?
    public let applicationVersion: String?
    public let isActive: Bool
    public let supportsMediaControl: Bool
    public let supportsRemoteControl: Bool
    public let serverId: String?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case userId = "UserId"
        case userName = "UserName"
        case client = "Client"
        case lastActivityDate = "LastActivityDate"
        case lastPlaybackCheckIn = "LastPlaybackCheckIn"
        case lastPausedDate = "LastPausedDate"
        case deviceName = "DeviceName"
        case deviceType = "DeviceType"
        case deviceId = "DeviceId"
        case applicationVersion = "ApplicationVersion"
        case isActive = "IsActive"
        case supportsMediaControl = "SupportsMediaControl"
        case supportsRemoteControl = "SupportsRemoteControl"
        case serverId = "ServerId"
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
