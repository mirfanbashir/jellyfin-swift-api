import Foundation

/// JellyfinSwiftAPI — A Swift client library for the Jellyfin Media Server API.
///
/// This library provides a type-safe, async/await-based interface for communicating
/// with a Jellyfin server. Future versions will expose endpoints for authentication,
/// library browsing, media playback, and more.
public struct JellyfinSwiftAPI {
    /// The base URL of the Jellyfin server (e.g. `https://jellyfin.example.com`).
    public let serverURL: URL

    /// Creates a new client configured to talk to the given server.
    ///
    /// - Parameter serverURL: The root URL of the Jellyfin server.
    public init(serverURL: URL) {
        self.serverURL = serverURL
    }
}
