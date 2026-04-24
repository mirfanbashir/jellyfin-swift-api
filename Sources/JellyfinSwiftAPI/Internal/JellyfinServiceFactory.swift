internal struct JellyfinServiceFactory: Sendable {
    private let executor: JellyfinRequestExecutor

    internal init(executor: JellyfinRequestExecutor) {
        self.executor = executor
    }

    internal func makeSystemService() -> any SystemService {
        SystemServiceClient(executor: executor)
    }

    internal func makeAuthenticationService() -> any AuthenticationService {
        AuthenticationServiceClient(executor: executor)
    }

    internal func makeCatalogService() -> any CatalogService {
        CatalogServiceClient(executor: executor)
    }

    internal func makeSessionsService() -> any SessionsService {
        SessionsServiceClient(executor: executor)
    }

    internal func makeLibraryService() -> any LibraryService {
        LibraryServiceClient(executor: executor)
    }

    internal func makeImagesService() -> any ImagesService {
        ImagesServiceClient(executor: executor)
    }

    internal func makePlaybackService() -> any PlaybackService {
        PlaybackServiceClient(executor: executor)
    }

    internal func makeLiveTVService() -> any LiveTVService {
        LiveTVServiceClient(executor: executor)
    }

    internal func makeAdministrationService() -> any AdministrationService {
        AdministrationServiceClient(executor: executor)
    }

    internal func makeMetadataService() -> any MetadataService {
        MetadataServiceClient(executor: executor)
    }

    internal func makeUsersService() -> any UsersService {
        UsersServiceClient(executor: executor)
    }
}
