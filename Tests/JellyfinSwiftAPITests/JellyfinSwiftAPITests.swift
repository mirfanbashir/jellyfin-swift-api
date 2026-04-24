import XCTest
import JellyfinSwiftAPI

final class JellyfinSwiftAPITests: XCTestCase {
    func testInitializationExposesServices() throws {
        let url = try XCTUnwrap(URL(string: "https://jellyfin.example.com"))
        let client = JellyfinSwiftAPI(serverURL: url)

        let authenticationService: any AuthenticationService = client.authentication
        let catalogService: any CatalogService = client.catalog
        let sessionsService: any SessionsService = client.sessions
        let imagesService: any ImagesService = client.images
        let libraryService: any LibraryService = client.library
        let playbackService: any PlaybackService = client.playback
        let liveTVService: any LiveTVService = client.liveTV
        let administrationService: any AdministrationService = client.administration
        let metadataService: any MetadataService = client.metadata
        let systemService: any SystemService = client.system
        let usersService: any UsersService = client.users

        XCTAssertNotNil(authenticationService as Any)
        XCTAssertNotNil(catalogService as Any)
        XCTAssertNotNil(sessionsService as Any)
        XCTAssertNotNil(imagesService as Any)
        XCTAssertNotNil(libraryService as Any)
        XCTAssertNotNil(playbackService as Any)
        XCTAssertNotNil(liveTVService as Any)
        XCTAssertNotNil(administrationService as Any)
        XCTAssertNotNil(metadataService as Any)
        XCTAssertNotNil(systemService as Any)
        XCTAssertNotNil(usersService as Any)
    }

    func testClientCanCrossConcurrencyDomains() async throws {
        let url = try XCTUnwrap(URL(string: "https://jellyfin.example.com"))
        let client = JellyfinSwiftAPI(serverURL: url)

        let serviceNames = await Task.detached {
            [
                String(describing: type(of: client.authentication)),
                String(describing: type(of: client.catalog)),
                String(describing: type(of: client.sessions)),
                String(describing: type(of: client.images)),
                String(describing: type(of: client.library)),
                String(describing: type(of: client.playback)),
                String(describing: type(of: client.liveTV)),
                String(describing: type(of: client.administration)),
                String(describing: type(of: client.metadata)),
                String(describing: type(of: client.system)),
                String(describing: type(of: client.users)),
            ]
        }.value

        XCTAssertTrue(serviceNames.allSatisfy { !$0.isEmpty })
    }
}
