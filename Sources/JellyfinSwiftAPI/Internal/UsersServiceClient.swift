import Foundation

internal struct UsersServiceClient: UsersService {
    private let executor: JellyfinRequestExecutor

    internal init(executor: JellyfinRequestExecutor) {
        self.executor = executor
    }

    internal func users(isHidden: Bool?, isDisabled: Bool?) async throws -> [User] {
        var queryItems: [URLQueryItem] = []
        if let isHidden {
            queryItems.append(URLQueryItem(name: "isHidden", value: String(isHidden)))
        }
        if let isDisabled {
            queryItems.append(URLQueryItem(name: "isDisabled", value: String(isDisabled)))
        }

        return try await executor.executeJSON(
            [User].self,
            for: JellyfinRequest(path: "/Users", queryItems: queryItems)
        )
    }

    internal func updateUser(_ user: User, userID: UUID?) async throws {
        var queryItems: [URLQueryItem] = []
        if let userID {
            queryItems.append(URLQueryItem(name: "userId", value: userID.uuidString))
        }

        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Users",
                method: .post,
                queryItems: queryItems,
                body: .json(try JellyfinJSONCoder.encoder().encode(user))
            )
        )
    }

    internal func user(id: UUID) async throws -> User {
        try await executor.executeJSON(
            User.self,
            for: JellyfinRequest(path: "/Users/\(id.uuidString)")
        )
    }

    internal func deleteUser(id: UUID) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(path: "/Users/\(id.uuidString)", method: .delete)
        )
    }

    internal func updateUserPolicy(_ policy: UserPolicy, userID: UUID) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Users/\(userID.uuidString)/Policy",
                method: .post,
                body: .json(try JellyfinJSONCoder.encoder().encode(policy))
            )
        )
    }

    internal func updateUserConfiguration(_ configuration: UserConfiguration, userID: UUID?) async throws {
        var queryItems: [URLQueryItem] = []
        if let userID {
            queryItems.append(URLQueryItem(name: "userId", value: userID.uuidString))
        }

        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Users/Configuration",
                method: .post,
                queryItems: queryItems,
                body: .json(try JellyfinJSONCoder.encoder().encode(configuration))
            )
        )
    }

    internal func currentUser() async throws -> User {
        try await executor.executeJSON(
            User.self,
            for: JellyfinRequest(path: "/Users/Me")
        )
    }

    internal func createUser(name: String, password: String?) async throws -> User {
        let payload = CreateUserRequest(name: name, password: password)
        return try await executor.executeJSON(
            User.self,
            for: JellyfinRequest(
                path: "/Users/New",
                method: .post,
                body: .json(try JellyfinJSONCoder.encoder().encode(payload))
            )
        )
    }

    internal func updateUserPassword(_ password: UpdateUserPasswordRequest, userID: UUID?) async throws {
        var queryItems: [URLQueryItem] = []
        if let userID {
            queryItems.append(URLQueryItem(name: "userId", value: userID.uuidString))
        }

        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Users/Password",
                method: .post,
                queryItems: queryItems,
                body: .json(try JellyfinJSONCoder.encoder().encode(password))
            )
        )
    }

    internal func devices(userID: UUID?) async throws -> DeviceQueryResult {
        var queryItems: [URLQueryItem] = []
        if let userID {
            queryItems.append(URLQueryItem(name: "userId", value: userID.uuidString))
        }

        return try await executor.executeJSON(
            DeviceQueryResult.self,
            for: JellyfinRequest(path: "/Devices", queryItems: queryItems)
        )
    }

    internal func deleteDevice(id: String) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Devices",
                method: .delete,
                queryItems: [URLQueryItem(name: "id", value: id)]
            )
        )
    }

    internal func deviceInfo(id: String) async throws -> DeviceInfo {
        try await executor.executeJSON(
            DeviceInfo.self,
            for: JellyfinRequest(
                path: "/Devices/Info",
                queryItems: [URLQueryItem(name: "id", value: id)]
            )
        )
    }

    internal func deviceOptions(id: String) async throws -> DeviceOptions {
        try await executor.executeJSON(
            DeviceOptions.self,
            for: JellyfinRequest(
                path: "/Devices/Options",
                queryItems: [URLQueryItem(name: "id", value: id)]
            )
        )
    }

    internal func updateDeviceOptions(_ options: DeviceOptions, id: String) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Devices/Options",
                method: .post,
                queryItems: [URLQueryItem(name: "id", value: id)],
                body: .json(try JellyfinJSONCoder.encoder().encode(options))
            )
        )
    }

    internal func displayPreferences(
        id: String,
        userID: UUID?,
        client: String
    ) async throws -> DisplayPreferences {
        try await executor.executeJSON(
            DisplayPreferences.self,
            for: JellyfinRequest(
                path: "/DisplayPreferences/\(id)",
                queryItems: makeDisplayPreferencesQueryItems(userID: userID, client: client)
            )
        )
    }

    internal func updateDisplayPreferences(
        _ preferences: DisplayPreferences,
        id: String,
        userID: UUID?,
        client: String
    ) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/DisplayPreferences/\(id)",
                method: .post,
                queryItems: makeDisplayPreferencesQueryItems(userID: userID, client: client),
                body: .json(try JellyfinJSONCoder.encoder().encode(preferences))
            )
        )
    }

    private func makeDisplayPreferencesQueryItems(userID: UUID?, client: String) -> [URLQueryItem] {
        var queryItems = [URLQueryItem(name: "client", value: client)]
        if let userID {
            queryItems.append(URLQueryItem(name: "userId", value: userID.uuidString))
        }
        return queryItems
    }
}

private struct CreateUserRequest: Codable, Sendable {
    let name: String
    let password: String?
}
