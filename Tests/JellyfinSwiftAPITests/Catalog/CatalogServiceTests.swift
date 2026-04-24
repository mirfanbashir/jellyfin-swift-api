import Foundation
import XCTest
@testable import JellyfinSwiftAPI

final class CatalogServiceTests: XCTestCase {
    func testArtistsUsesSharedCatalogQuery() async throws {
        let responseData = try FixtureLoader.data(service: "Catalog", named: "artists")
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: responseData,
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200)
            )
        }
        let service = makeCatalogService(
            authorization: .header("MediaBrowser Token=test-token"),
            transport: transport
        )

        let result = try await service.artists(
            CatalogQuery(
                userID: UUID(uuidString: "5F6D5A13-4B25-4F8D-B9FB-A3B4699EF001"),
                limit: 20,
                searchTerm: "john",
                sortBy: ["SortName"],
                sortOrder: ["Ascending"]
            )
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/Artists?userId=5F6D5A13-4B25-4F8D-B9FB-A3B4699EF001&limit=20&searchTerm=john&sortBy=SortName&sortOrder=Ascending"
        )
        XCTAssertEqual(result.items.first?.name, "John Williams")
    }

    func testArtistByNameUsesPathAndOptionalUser() async throws {
        let responseData = try FixtureLoader.data(service: "Catalog", named: "artist")
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: responseData,
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200)
            )
        }
        let service = makeCatalogService(
            authorization: .header("MediaBrowser Token=test-token"),
            transport: transport
        )

        let item = try await service.artist(
            named: "John Williams",
            userID: UUID(uuidString: "5F6D5A13-4B25-4F8D-B9FB-A3B4699EF001")
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/Artists/John%20Williams?userId=5F6D5A13-4B25-4F8D-B9FB-A3B4699EF001"
        )
        XCTAssertEqual(item.name, "John Williams")
    }

    func testMovieRecommendationsUsesTypedQuery() async throws {
        let responseData = try FixtureLoader.data(service: "Catalog", named: "movie-recommendations")
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: responseData,
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200)
            )
        }
        let service = makeCatalogService(
            authorization: .header("MediaBrowser Token=test-token"),
            transport: transport
        )

        let recommendations = try await service.movieRecommendations(
            MovieRecommendationsQuery(
                userID: UUID(uuidString: "5F6D5A13-4B25-4F8D-B9FB-A3B4699EF001"),
                categoryLimit: 3,
                itemLimit: 5
            )
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/Movies/Recommendations?userId=5F6D5A13-4B25-4F8D-B9FB-A3B4699EF001&categoryLimit=3&itemLimit=5"
        )
        XCTAssertEqual(recommendations.first?.items?.first?.name, "The Empire Strikes Back")
    }

    func testEpisodesUsesSeriesPathAndQuery() async throws {
        let responseData = try FixtureLoader.data(service: "Catalog", named: "episodes")
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: responseData,
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200)
            )
        }
        let service = makeCatalogService(
            authorization: .header("MediaBrowser Token=test-token"),
            transport: transport
        )
        let seriesID = UUID(uuidString: "5F6D5A13-4B25-4F8D-B9FB-A3B4699EF111")!

        let episodes = try await service.episodes(
            seriesID: seriesID,
            query: EpisodesQuery(season: 1, limit: 10, enableImages: true)
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/Shows/5F6D5A13-4B25-4F8D-B9FB-A3B4699EF111/Episodes?season=1&limit=10&enableImages=true"
        )
        XCTAssertEqual(episodes.items.first?.name, "Pilot")
    }
}

private func makeCatalogService(
    authorization: JellyfinAuthorization = .none,
    transport: any JellyfinTransporting
) -> CatalogServiceClient {
    CatalogServiceClient(executor: makeTestExecutor(authorization: authorization, transport: transport))
}
