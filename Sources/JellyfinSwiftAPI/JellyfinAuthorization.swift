/// Authentication strategy used for Jellyfin requests.
public enum JellyfinAuthorization: Sendable, Equatable {
    /// Send the Jellyfin client identity header without a user access token.
    case publicAccess

    /// Send the Jellyfin client identity header with the provided user access token.
    case authenticated(token: String)
}

internal extension JellyfinAuthorization {
    var token: String? {
        switch self {
        case .publicAccess:
            return nil
        case let .authenticated(token):
            return token
        }
    }
}
