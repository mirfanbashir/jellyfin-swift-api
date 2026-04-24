import Foundation
import XCTest
@testable import JellyfinSwiftAPI

final class MetadataServiceTests: XCTestCase {
    func testExternalIDInfosUsesItemPath() async throws {
        let responseData = try FixtureLoader.data(service: "Metadata", named: "external-id-infos")
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: responseData,
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200)
            )
        }
        let service = makeMetadataService(
            authorization: .header("MediaBrowser Token=test-token"),
            transport: transport
        )
        let itemID = UUID(uuidString: "5F6D5A13-4B25-4F8D-B9FB-A3B4699EF301")!

        let ids = try await service.externalIDInfos(itemID: itemID)

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/Items/5F6D5A13-4B25-4F8D-B9FB-A3B4699EF301/ExternalIdInfos"
        )
        XCTAssertEqual(ids.first?.name, "IMDb")
    }

    func testMovieRemoteSearchBuildsBody() async throws {
        let responseData = try FixtureLoader.data(service: "Metadata", named: "remote-search-results")
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: responseData,
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200)
            )
        }
        let service = makeMetadataService(
            authorization: .header("MediaBrowser Token=test-token"),
            transport: transport
        )

        let results = try await service.movieRemoteSearchResults(
            MovieRemoteSearchQuery(
                searchInfo: MetadataSearchInfo(
                    name: "Star Wars",
                    originalTitle: nil,
                    path: nil,
                    metadataLanguage: "en",
                    metadataCountryCode: "US",
                    providerIds: nil,
                    year: 1977,
                    indexNumber: nil,
                    parentIndexNumber: nil,
                    premiereDate: nil,
                    isAutomated: false
                ),
                itemId: UUID(uuidString: "5F6D5A13-4B25-4F8D-B9FB-A3B4699EF301")!,
                searchProviderName: "TheMovieDB",
                includeDisabledProviders: false
            )
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        let bodyString = try XCTUnwrap(String(data: try XCTUnwrap(request.httpBody), encoding: .utf8))
        XCTAssertEqual(request.url?.absoluteString, "https://jellyfin.example.com/Items/RemoteSearch/Movie")
        XCTAssertTrue(bodyString.contains(#""Name":"Star Wars""#))
        XCTAssertTrue(bodyString.contains(#""SearchProviderName":"TheMovieDB""#))
        XCTAssertEqual(results.first?.name, "Star Wars")
    }

    func testRefreshItemUsesQueryOptions() async throws {
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: Data(),
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 204)
            )
        }
        let service = makeMetadataService(
            authorization: .header("MediaBrowser Token=test-token"),
            transport: transport
        )
        let itemID = UUID(uuidString: "5F6D5A13-4B25-4F8D-B9FB-A3B4699EF301")!

        try await service.refreshItem(
            id: itemID,
            options: MetadataRefreshOptions(
                metadataRefreshMode: .fullRefresh,
                imageRefreshMode: .default,
                replaceAllMetadata: true,
                replaceAllImages: false,
                regenerateTrickplay: true
            )
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/Items/5F6D5A13-4B25-4F8D-B9FB-A3B4699EF301/Refresh?metadataRefreshMode=FullRefresh&imageRefreshMode=Default&replaceAllMetadata=true&replaceAllImages=false&regenerateTrickplay=true"
        )
    }

    func testRemoteImagesUsesTypedQuery() async throws {
        let responseData = try FixtureLoader.data(service: "Metadata", named: "remote-images")
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: responseData,
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200)
            )
        }
        let service = makeMetadataService(
            authorization: .header("MediaBrowser Token=test-token"),
            transport: transport
        )
        let itemID = UUID(uuidString: "5F6D5A13-4B25-4F8D-B9FB-A3B4699EF301")!

        let images = try await service.remoteImages(
            itemID: itemID,
            query: RemoteImagesQuery(type: .primary, startIndex: 0, limit: 10, providerName: "TheMovieDB", includeAllLanguages: true)
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/Items/5F6D5A13-4B25-4F8D-B9FB-A3B4699EF301/RemoteImages?type=Primary&startIndex=0&limit=10&providerName=TheMovieDB&includeAllLanguages=true"
        )
        XCTAssertEqual(images.images?.first?.providerName, "TheMovieDB")
    }
}

private func makeMetadataService(
    authorization: JellyfinAuthorization = .none,
    transport: any JellyfinTransporting
) -> MetadataServiceClient {
    MetadataServiceClient(executor: makeTestExecutor(authorization: authorization, transport: transport))
}
