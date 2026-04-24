import Foundation

/// Service interface for Jellyfin user, device, and display-preference endpoints.
public protocol UsersService: JellyfinService {
    /// Returns users known to the server.
    func users(isHidden: Bool?, isDisabled: Bool?) async throws -> [User]

    /// Updates a user by identifier.
    func updateUser(_ user: User, userID: UUID?) async throws

    /// Returns a user by identifier.
    func user(id: UUID) async throws -> User

    /// Deletes a user by identifier.
    func deleteUser(id: UUID) async throws

    /// Updates a user's policy.
    func updateUserPolicy(_ policy: UserPolicy, userID: UUID) async throws

    /// Updates a user's configuration.
    func updateUserConfiguration(_ configuration: UserConfiguration, userID: UUID?) async throws

    /// Returns the authenticated user.
    func currentUser() async throws -> User

    /// Creates a new user.
    func createUser(name: String, password: String?) async throws -> User

    /// Updates a user's password.
    func updateUserPassword(_ password: UpdateUserPasswordRequest, userID: UUID?) async throws

    /// Returns devices, optionally filtered by user.
    func devices(userID: UUID?) async throws -> DeviceQueryResult

    /// Deletes a device by identifier.
    func deleteDevice(id: String) async throws

    /// Returns device information by identifier.
    func deviceInfo(id: String) async throws -> DeviceInfo

    /// Returns device options by identifier.
    func deviceOptions(id: String) async throws -> DeviceOptions

    /// Updates device options by identifier.
    func updateDeviceOptions(_ options: DeviceOptions, id: String) async throws

    /// Returns display preferences for a user and client.
    func displayPreferences(
        id: String,
        userID: UUID?,
        client: String
    ) async throws -> DisplayPreferences

    /// Updates display preferences for a user and client.
    func updateDisplayPreferences(
        _ preferences: DisplayPreferences,
        id: String,
        userID: UUID?,
        client: String
    ) async throws
}
