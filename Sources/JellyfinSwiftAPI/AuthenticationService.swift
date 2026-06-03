import Foundation

/// Service interface for Jellyfin authentication and Quick Connect endpoints.
public protocol AuthenticationService: JellyfinService {
    /// Authenticates a user by username and password.
    ///
    /// - Parameters:
    ///   - username: The Jellyfin username.
    ///   - password: The user's password. Pass `nil` when authenticating an account that does not require one.
    /// - Returns: The authentication result containing the access token, user, and session details.
    func authenticate(
        username: String,
        password: String?
    ) async throws -> AuthenticationResult
    
    /// Authenticates a user with an existing Quick Connect secret.
    ///
    /// - Parameter secret: The Quick Connect secret returned when the request was initiated.
    /// - Returns: The authentication result containing the access token, user, and session details.
    func authenticateWithQuickConnect(secret: String) async throws -> AuthenticationResult
    
    /// Starts a forgot-password flow for the given username.
    ///
    /// - Parameter username: The Jellyfin username to start the password reset flow for.
    /// - Returns: The server response describing how the reset flow should continue.
    func forgotPassword(for username: String) async throws -> ForgotPasswordResult
    
    /// Redeems a forgot-password PIN.
    ///
    /// - Parameter pin: The password reset PIN supplied by Jellyfin.
    /// - Returns: The result of the PIN redemption request.
    func redeemPasswordResetPin(_ pin: String) async throws -> PinRedeemResult
    
    /// Gets the users visible before authentication.
    ///
    /// - Returns: Publicly visible users that can be shown on a sign-in screen.
    func publicUsers() async throws -> [User]
    
    /// Gets the password reset providers supported by the server.
    ///
    /// - Returns: Available password reset providers.
    func passwordResetProviders() async throws -> [NameIDPair]
    
    /// Gets the authentication providers supported by the server.
    ///
    /// - Returns: Available authentication providers.
    func authProviders() async throws -> [NameIDPair]
    
    /// Authorizes a Quick Connect code for a user.
    ///
    /// - Parameters:
    ///   - code: The Quick Connect code shown on the target device.
    ///   - userID: The user identifier authorizing the request. When omitted, Jellyfin uses the current authenticated user.
    func authorizeQuickConnect(code: String, userID: UUID?) async throws
    
    /// Gets the current state of a Quick Connect request.
    ///
    /// - Parameter secret: The Quick Connect secret returned when the request was initiated.
    /// - Returns: The current Quick Connect state, including whether the code has been authorized.
    func quickConnectState(secret: String) async throws -> QuickConnectResult
    
    /// Gets whether Quick Connect is enabled on the server.
    ///
    /// - Returns: `true` when Quick Connect is available for use.
    func quickConnectEnabled() async throws -> Bool
    
    /// Initiates a new Quick Connect request.
    ///
    /// - Returns: The newly created Quick Connect code and secret pair.
    func initiateQuickConnect() async throws -> QuickConnectResult
}
