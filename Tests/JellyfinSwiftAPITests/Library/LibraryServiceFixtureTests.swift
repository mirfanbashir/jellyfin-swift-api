import XCTest
@testable import JellyfinSwiftAPI

final class LibraryServiceFixtureTests: XCTestCase {
    func testItemsFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "Library", named: "items")
        let decoded = try JellyfinJSONCoder.decoder().decode(BaseItemQueryResult.self, from: data)

        XCTAssertEqual(decoded.totalRecordCount, 1)
        XCTAssertEqual(decoded.items.first?.name, "The Empire Strikes Back")
        XCTAssertEqual(decoded.items.first?.id.uuidString.uppercased(), "D2C48876-BD8F-4D6A-8734-712267F7F9F6")
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
        XCTAssertEqual(decoded.itemId?.uuidString.uppercased(), "D2C48876-BD8F-4D6A-8734-712267F7F9F6")
    }

    func testPlaylistFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "Library", named: "playlist")
        let decoded = try JellyfinJSONCoder.decoder().decode(Playlist.self, from: data)

        XCTAssertEqual(decoded.openAccess, true)
        XCTAssertEqual(decoded.shares?.first?.canEdit, true)
        XCTAssertEqual(decoded.shares?.first?.userId?.uuidString.uppercased(), "11111111-1111-1111-1111-111111111111")
        XCTAssertEqual(decoded.itemIds?.first?.uuidString.uppercased(), "D2C48876-BD8F-4D6A-8734-712267F7F9F6")
    }

    func testVirtualFoldersFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "Library", named: "virtual-folders")
        let decoded = try JellyfinJSONCoder.decoder().decode([VirtualFolderInfo].self, from: data)

        XCTAssertEqual(decoded.first?.name, "Movies")
        XCTAssertEqual(decoded.first?.collectionType, .movies)
        XCTAssertEqual(decoded.first?.itemId?.uuidString.uppercased(), "96C6C8F6-C9A0-4B0A-9F66-FCF2B9F39C66")
        XCTAssertEqual(decoded.first?.primaryImageItemId?.uuidString.uppercased(), "D2C48876-BD8F-4D6A-8734-712267F7F9F6")
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
        XCTAssertEqual(decoded.genres?.first?.id?.uuidString.uppercased(), "96C6C8F6-C9A0-4B0A-9F66-FCF2B9F39C66")
    }

    func testThemeMediaFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "Library", named: "theme-media")
        let decoded = try JellyfinJSONCoder.decoder().decode(ThemeMediaResult.self, from: data)

        XCTAssertEqual(decoded.totalRecordCount, 1)
        XCTAssertEqual(decoded.items.first?.name, "Imperial March")
        XCTAssertEqual(decoded.ownerId?.uuidString.uppercased(), "5F6D5A13-4B25-4F8D-B9FB-A3B4699EF301")
    }
}
