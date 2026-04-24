/// Authorization strategy used for Jellyfin requests that require authentication.
public enum JellyfinAuthorization: Sendable, Equatable {
    /// Execute requests without an `Authorization` header.
    case none

    /// Send the provided `Authorization` header value with authenticated requests.
    case header(String)
}
