import XCTest
@testable import JellyfinSwiftAPI

final class CatalogServiceFixtureTests: XCTestCase {
    func testArtistsFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "Catalog", named: "artists")
        let decoded = try JellyfinJSONCoder.decoder().decode(BaseItemQueryResult.self, from: data)

        XCTAssertEqual(decoded.totalRecordCount, 1)
        XCTAssertEqual(decoded.items.first?.name, "John Williams")
    }

    func testArtistFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "Catalog", named: "artist")
        let decoded = try JellyfinJSONCoder.decoder().decode(BaseItem.self, from: data)

        XCTAssertEqual(decoded.name, "John Williams")
        XCTAssertEqual(decoded.mediaType, .audio)
        XCTAssertEqual(decoded.type, .musicArtist)
    }

    func testRecommendationsFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "Catalog", named: "movie-recommendations")
        let decoded = try JellyfinJSONCoder.decoder().decode([Recommendation].self, from: data)

        XCTAssertEqual(decoded.count, 1)
        XCTAssertEqual(decoded.first?.recommendationType, .similarToRecentlyPlayed)
    }
}
