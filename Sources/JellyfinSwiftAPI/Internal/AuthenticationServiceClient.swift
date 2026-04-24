import Foundation

internal struct AuthenticationServiceClient: AuthenticationService {
    private let executor: JellyfinRequestExecutor

    internal init(executor: JellyfinRequestExecutor) {
        self.executor = executor
    }

    internal func authenticate(
        username: String,
        password: String?
    ) async throws -> AuthenticationResult {
        let payload = AuthenticateByNameRequest(username: username, pw: password)
        return try await executor.executeJSON(
            AuthenticationResult.self,
            for: JellyfinRequest(
                path: "/Users/AuthenticateByName",
                method: .post,
                body: .json(try JellyfinJSONCoder.encoder().encode(payload)),
                requiresAuthorization: false
            )
        )
    }

    internal func authenticateWithQuickConnect(secret: String) async throws -> AuthenticationResult {
        let payload = QuickConnectAuthenticationRequest(secret: secret)
        return try await executor.executeJSON(
            AuthenticationResult.self,
            for: JellyfinRequest(
                path: "/Users/AuthenticateWithQuickConnect",
                method: .post,
                body: .json(try JellyfinJSONCoder.encoder().encode(payload)),
                requiresAuthorization: false
            )
        )
    }

    internal func forgotPassword(for username: String) async throws -> ForgotPasswordResult {
        let payload = ForgotPasswordRequest(enteredUsername: username)
        return try await executor.executeJSON(
            ForgotPasswordResult.self,
            for: JellyfinRequest(
                path: "/Users/ForgotPassword",
                method: .post,
                body: .json(try JellyfinJSONCoder.encoder().encode(payload)),
                requiresAuthorization: false
            )
        )
    }

    internal func redeemPasswordResetPin(_ pin: String) async throws -> PinRedeemResult {
        let payload = ForgotPasswordPinRequest(pin: pin)
        return try await executor.executeJSON(
            PinRedeemResult.self,
            for: JellyfinRequest(
                path: "/Users/ForgotPassword/Pin",
                method: .post,
                body: .json(try JellyfinJSONCoder.encoder().encode(payload)),
                requiresAuthorization: false
            )
        )
    }

    internal func publicUsers() async throws -> [User] {
        try await executor.executeJSON(
            [User].self,
            for: JellyfinRequest(path: "/Users/Public", requiresAuthorization: false)
        )
    }

    internal func passwordResetProviders() async throws -> [NameIDPair] {
        try await executor.executeJSON(
            [NameIDPair].self,
            for: JellyfinRequest(path: "/Auth/PasswordResetProviders")
        )
    }

    internal func authProviders() async throws -> [NameIDPair] {
        try await executor.executeJSON(
            [NameIDPair].self,
            for: JellyfinRequest(path: "/Auth/Providers")
        )
    }

    internal func authorizeQuickConnect(code: String, userID: UUID?) async throws {
        var queryItems = [URLQueryItem(name: "code", value: code)]
        if let userID {
            queryItems.append(URLQueryItem(name: "userId", value: userID.uuidString))
        }

        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/QuickConnect/Authorize",
                method: .post,
                queryItems: queryItems
            )
        )
    }

    internal func quickConnectState(secret: String) async throws -> QuickConnectResult {
        try await executor.executeJSON(
            QuickConnectResult.self,
            for: JellyfinRequest(
                path: "/QuickConnect/Connect",
                queryItems: [URLQueryItem(name: "secret", value: secret)],
                requiresAuthorization: false
            )
        )
    }

    internal func quickConnectEnabled() async throws -> Bool {
        try await executor.executeJSON(
            Bool.self,
            for: JellyfinRequest(path: "/QuickConnect/Enabled", requiresAuthorization: false)
        )
    }

    internal func initiateQuickConnect() async throws -> QuickConnectResult {
        try await executor.executeJSON(
            QuickConnectResult.self,
            for: JellyfinRequest(
                path: "/QuickConnect/Initiate",
                method: .post,
                requiresAuthorization: false
            )
        )
    }
}

private struct AuthenticateByNameRequest: Codable, Sendable {
    let username: String
    let pw: String?

    enum CodingKeys: String, CodingKey {
        case username = "Username"
        case pw = "Pw"
    }
}

private struct QuickConnectAuthenticationRequest: Codable, Sendable {
    let secret: String

    enum CodingKeys: String, CodingKey {
        case secret = "Secret"
    }
}

private struct ForgotPasswordRequest: Codable, Sendable {
    let enteredUsername: String

    enum CodingKeys: String, CodingKey {
        case enteredUsername = "EnteredUsername"
    }
}

private struct ForgotPasswordPinRequest: Codable, Sendable {
    let pin: String

    enum CodingKeys: String, CodingKey {
        case pin = "Pin"
    }
}
