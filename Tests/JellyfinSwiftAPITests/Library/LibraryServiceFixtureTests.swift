import XCTest
@testable import JellyfinSwiftAPI

final class LibraryServiceFixtureTests: XCTestCase {
    func testItemsFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "Library", named: "items")
        let decoded = try JellyfinJSONCoder.decoder().decode(BaseItemQueryResult.self, from: data)

        XCTAssertEqual(decoded.totalRecordCount, 1)
        XCTAssertEqual(decoded.items.first?.name, "The Empire Strikes Back")
    }

    func testSearchHintsFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "Library", named: "search-hints")
        let decoded = try JellyfinJSONCoder.decoder().decode(SearchHintResult.self, from: data)

        XCTAssertEqual(decoded.totalRecordCount, 1)
        XCTAssertEqual(decoded.searchHints.first?.matchedTerm, "empire")
    }

    func testUserItemDataFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "Library", named: "user-item-data")
        let decoded = try JellyfinJSONCoder.decoder().decode(UserItemData.self, from: data)

        XCTAssertEqual(decoded.playCount, 2)
        XCTAssertEqual(decoded.isFavorite, true)
    }

    func testPlaylistFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "Library", named: "playlist")
        let decoded = try JellyfinJSONCoder.decoder().decode(Playlist.self, from: data)

        XCTAssertEqual(decoded.openAccess, true)
        XCTAssertEqual(decoded.shares?.first?.canEdit, true)
    }

    func testVirtualFoldersFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "Library", named: "virtual-folders")
        let decoded = try JellyfinJSONCoder.decoder().decode([VirtualFolderInfo].self, from: data)

        XCTAssertEqual(decoded.first?.name, "Movies")
        XCTAssertEqual(decoded.first?.collectionType, .movies)
    }

    func testLibraryOptionsFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "Library", named: "library-options")
        let decoded = try JellyfinJSONCoder.decoder().decode(LibraryOptionsResult.self, from: data)

        XCTAssertEqual(decoded.metadataSavers?.first?.name, "NfoSaver")
        XCTAssertEqual(decoded.typeOptions?.first?.type, "movies")
    }

    func testQueryFiltersFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "Library", named: "query-filters")
        let decoded = try JellyfinJSONCoder.decoder().decode(QueryFilters.self, from: data)

        XCTAssertEqual(decoded.tags?.first, "favorite")
        XCTAssertEqual(decoded.genres?.first?.name, "Sci-Fi")
    }

    func testThemeMediaFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "Library", named: "theme-media")
        let decoded = try JellyfinJSONCoder.decoder().decode(ThemeMediaResult.self, from: data)

        XCTAssertEqual(decoded.totalRecordCount, 1)
        XCTAssertEqual(decoded.items.first?.name, "Imperial March")
    }
}
