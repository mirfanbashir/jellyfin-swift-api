import Foundation

/// Service interface for Jellyfin authentication and Quick Connect endpoints.
public protocol AuthenticationService: JellyfinService {
    /// Authenticates a user by username and password.
    func authenticate(
        username: String,
        password: String?
    ) async throws -> AuthenticationResult

    /// Authenticates a user with an existing Quick Connect secret.
    func authenticateWithQuickConnect(secret: String) async throws -> AuthenticationResult

    /// Starts a forgot-password flow for the given username.
    func forgotPassword(for username: String) async throws -> ForgotPasswordResult

    /// Redeems a forgot-password PIN.
    func redeemPasswordResetPin(_ pin: String) async throws -> PinRedeemResult

    /// Returns users visible before authentication.
    func publicUsers() async throws -> [User]

    /// Returns password reset providers.
    func passwordResetProviders() async throws -> [NameIDPair]

    /// Returns authentication providers.
    func authProviders() async throws -> [NameIDPair]

    /// Authorizes a Quick Connect code for a user.
    func authorizeQuickConnect(code: String, userID: UUID?) async throws

    /// Returns the current state of a Quick Connect request.
    func quickConnectState(secret: String) async throws -> QuickConnectResult

    /// Returns whether Quick Connect is enabled.
    func quickConnectEnabled() async throws -> Bool

    /// Initiates a new Quick Connect request.
    func initiateQuickConnect() async throws -> QuickConnectResult
}
