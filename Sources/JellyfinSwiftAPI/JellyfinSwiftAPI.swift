import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// JellyfinSwiftAPI — A Swift client library for the Jellyfin Media Server API.
///
/// This library provides a type-safe, async/await-based interface for communicating
/// with a Jellyfin server. The public surface exposes protocol-typed services while
/// concrete transport and service implementations remain internal to the package.
public struct JellyfinSwiftAPI: Sendable {
    /// Service for Jellyfin authentication endpoints.
    public let authentication: any AuthenticationService

    /// Service for Jellyfin catalog browse endpoints.
    public let catalog: any CatalogService

    /// Service for Jellyfin sessions, remote control, playstate, and SyncPlay endpoints.
    public let sessions: any SessionsService

    /// Service for Jellyfin library browse, search, and user library endpoints.
    public let library: any LibraryService

    /// Service for Jellyfin image retrieval and upload endpoints.
    public let images: any ImagesService

    /// Service for Jellyfin playback-info and direct stream endpoints.
    public let playback: any PlaybackService

    /// Service for Jellyfin Live TV, channels, recordings, and timers.
    public let liveTV: any LiveTVService

    /// Service for Jellyfin administration, configuration, plugins, packages, and tasks.
    public let administration: any AdministrationService

    /// Service for Jellyfin metadata lookup and update endpoints.
    public let metadata: any MetadataService

    /// Service for Jellyfin system endpoints.
    public let system: any SystemService

    /// Service for Jellyfin user and device endpoints.
    public let users: any UsersService

    /// Creates a new client configured to talk to the given server.
    ///
    /// - Parameters:
    ///   - serverURL: The root URL of the Jellyfin server.
    ///   - authorization: The authorization strategy used for authenticated requests.
    ///   - session: The session used for future HTTP requests. On Linux this uses
    ///     `FoundationNetworking` when available.
    public init(
        serverURL: URL,
        authorization: JellyfinAuthorization = .none,
        session: URLSession = .shared
    ) {
        let transport = JellyfinTransport(session: session)
        let executor = JellyfinRequestExecutor(
            serverURL: serverURL,
            authorization: authorization,
            transport: transport
        )
        let serviceFactory = JellyfinServiceFactory(executor: executor)

        self.authentication = serviceFactory.makeAuthenticationService()
        self.catalog = serviceFactory.makeCatalogService()
        self.sessions = serviceFactory.makeSessionsService()
        self.library = serviceFactory.makeLibraryService()
        self.images = serviceFactory.makeImagesService()
        self.playback = serviceFactory.makePlaybackService()
        self.liveTV = serviceFactory.makeLiveTVService()
        self.administration = serviceFactory.makeAdministrationService()
        self.metadata = serviceFactory.makeMetadataService()
        self.system = serviceFactory.makeSystemService()
        self.users = serviceFactory.makeUsersService()
    }
}
