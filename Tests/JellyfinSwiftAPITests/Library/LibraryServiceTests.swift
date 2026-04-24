import Foundation
import XCTest
@testable import JellyfinSwiftAPI

final class LibraryServiceTests: XCTestCase {
    func testItemsUsesTypedQuery() async throws {
        let responseData = try FixtureLoader.data(service: "Library", named: "items")
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: responseData,
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200)
            )
        }
        let service = makeLibraryService(transport: transport)

        let items = try await service.items(
            LibraryItemsQuery(
                userID: UUID(uuidString: "5F6D5A13-4B25-4F8D-B9FB-A3B4699EF301"),
                limit: 25,
                recursive: true,
                searchTerm: "star",
                includeItemTypes: ["Movie"],
                enableImages: true
            )
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/Items?userId=5F6D5A13-4B25-4F8D-B9FB-A3B4699EF301&limit=25&recursive=true&searchTerm=star&includeItemTypes=Movie&enableImages=true"
        )
        XCTAssertEqual(items.items.first?.name, "The Empire Strikes Back")
    }

    func testLatestMediaUsesArrayResponse() async throws {
        let responseData = try FixtureLoader.data(service: "Library", named: "latest-media")
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: responseData,
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200)
            )
        }
        let service = makeLibraryService(transport: transport)

        let items = try await service.latestMedia(
            LatestMediaQuery(includeItemTypes: ["Episode"], limit: 10, groupItems: true)
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/Items/Latest?includeItemTypes=Episode&limit=10&groupItems=true"
        )
        XCTAssertEqual(items.first?.name, "Andor")
    }

    func testSearchHintsRequiresSearchTermAndBuildsQuery() async throws {
        let responseData = try FixtureLoader.data(service: "Library", named: "search-hints")
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: responseData,
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200)
            )
        }
        let service = makeLibraryService(transport: transport)

        let result = try await service.searchHints(
            SearchHintsQuery(
                limit: 5,
                userID: UUID(uuidString: "5F6D5A13-4B25-4F8D-B9FB-A3B4699EF301"),
                searchTerm: "empire",
                includeItemTypes: ["Movie"],
                includeArtists: true
            )
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/Search/Hints?limit=5&userId=5F6D5A13-4B25-4F8D-B9FB-A3B4699EF301&searchTerm=empire&includeItemTypes=Movie&includeArtists=true"
        )
        XCTAssertEqual(result.searchHints.first?.name, "The Empire Strikes Back")
    }

    func testUpdateItemUserDataPostsJSONBody() async throws {
        let responseData = try FixtureLoader.data(service: "Library", named: "user-item-data")
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: responseData,
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200)
            )
        }
        let service = makeLibraryService(transport: transport)
        let itemID = UUID(uuidString: "D2C48876-BD8F-4D6A-8734-712267F7F9F6")!

        let userData = try await service.updateItemUserData(
            UserItemData(
                rating: 8.5,
                playedPercentage: 87.5,
                unplayedItemCount: 0,
                playbackPositionTicks: 1200,
                playCount: 2,
                isFavorite: true,
                likes: true,
                lastPlayedDate: Date(timeIntervalSince1970: 1_711_936_000),
                played: true,
                key: "item-key",
                itemId: itemID
            ),
            itemID: itemID,
            userID: UUID(uuidString: "5F6D5A13-4B25-4F8D-B9FB-A3B4699EF301")
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        let bodyString = try XCTUnwrap(String(data: try XCTUnwrap(request.httpBody), encoding: .utf8))
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/UserItems/D2C48876-BD8F-4D6A-8734-712267F7F9F6/UserData?userId=5F6D5A13-4B25-4F8D-B9FB-A3B4699EF301"
        )
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertTrue(bodyString.contains(#""Rating":8.5"#))
        XCTAssertTrue(bodyString.contains(#""IsFavorite":true"#))
        XCTAssertEqual(userData.playCount, 2)
    }

    func testUpdateUserItemRatingUsesLikesQuery() async throws {
        let responseData = try FixtureLoader.data(service: "Library", named: "user-item-data")
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: responseData,
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200)
            )
        }
        let service = makeLibraryService(transport: transport)
        let itemID = UUID(uuidString: "D2C48876-BD8F-4D6A-8734-712267F7F9F6")!

        let userData = try await service.updateUserItemRating(
            itemID: itemID,
            userID: UUID(uuidString: "5F6D5A13-4B25-4F8D-B9FB-A3B4699EF301"),
            likes: true
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/UserItems/D2C48876-BD8F-4D6A-8734-712267F7F9F6/Rating?userId=5F6D5A13-4B25-4F8D-B9FB-A3B4699EF301&likes=true"
        )
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(userData.likes, true)
    }

    func testUserViewsUsesOptionalFlags() async throws {
        let responseData = try FixtureLoader.data(service: "Library", named: "items")
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: responseData,
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200)
            )
        }
        let service = makeLibraryService(transport: transport)

        _ = try await service.userViews(
            UserViewsQuery(
                userID: UUID(uuidString: "5F6D5A13-4B25-4F8D-B9FB-A3B4699EF301"),
                includeExternalContent: true,
                presetViews: ["movies", "tvshows"],
                includeHidden: false
            )
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/UserViews?userId=5F6D5A13-4B25-4F8D-B9FB-A3B4699EF301&includeExternalContent=true&presetViews=movies,tvshows&includeHidden=false"
        )
    }

    func testCreateCollectionBuildsQuery() async throws {
        let responseData = try FixtureLoader.data(service: "Library", named: "creation-result")
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: responseData,
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200)
            )
        }
        let service = makeLibraryService(transport: transport)
        let collectionID = try await service.createCollection(
            name: "Favorites",
            ids: [UUID(uuidString: "D2C48876-BD8F-4D6A-8734-712267F7F9F6")!],
            parentID: UUID(uuidString: "5F6D5A13-4B25-4F8D-B9FB-A3B4699EF301"),
            isLocked: true
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/Collections?name=Favorites&ids=D2C48876-BD8F-4D6A-8734-712267F7F9F6&parentId=5F6D5A13-4B25-4F8D-B9FB-A3B4699EF301&isLocked=true"
        )
        XCTAssertEqual(collectionID.id.uuidString, "96C6C8F6-C9A0-4B0A-9F66-FCF2B9F39C66")
    }

    func testInstantMixFromArtistIDUsesSharedQuery() async throws {
        let responseData = try FixtureLoader.data(service: "Library", named: "items")
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: responseData,
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200)
            )
        }
        let service = makeLibraryService(transport: transport)

        _ = try await service.instantMixFromArtist(
            id: UUID(uuidString: "D2C48876-BD8F-4D6A-8734-712267F7F9F6")!,
            query: InstantMixQuery(limit: 10, enableImages: true, enableUserData: true)
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/Artists/InstantMix?id=D2C48876-BD8F-4D6A-8734-712267F7F9F6&limit=10&enableImages=true&enableUserData=true"
        )
    }

    func testCreatePlaylistPostsJSONBody() async throws {
        let responseData = try FixtureLoader.data(service: "Library", named: "creation-result")
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: responseData,
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200)
            )
        }
        let service = makeLibraryService(transport: transport)

        let result = try await service.createPlaylist(
            CreatePlaylistRequest(
                name: "Road Trip",
                ids: [UUID(uuidString: "D2C48876-BD8F-4D6A-8734-712267F7F9F6")!],
                userId: UUID(uuidString: "5F6D5A13-4B25-4F8D-B9FB-A3B4699EF301"),
                mediaType: .audio,
                users: [PlaylistUserPermission(userId: UUID(uuidString: "11111111-1111-1111-1111-111111111111"), canEdit: true)],
                isPublic: true
            )
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        let bodyString = try XCTUnwrap(String(data: try XCTUnwrap(request.httpBody), encoding: .utf8))
        XCTAssertEqual(request.url?.absoluteString, "https://jellyfin.example.com/Playlists")
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertTrue(bodyString.contains(#""Name":"Road Trip""#))
        XCTAssertTrue(bodyString.contains(#""MediaType":"Audio""#))
        XCTAssertTrue(bodyString.contains(#""IsPublic":true"#))
        XCTAssertEqual(result.id.uuidString, "96C6C8F6-C9A0-4B0A-9F66-FCF2B9F39C66")
    }

    func testUpdatePlaylistUserPostsBody() async throws {
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: Data(),
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 204)
            )
        }
        let service = makeLibraryService(transport: transport)

        try await service.updatePlaylistUser(
            UpdatePlaylistUserRequest(canEdit: false),
            playlistID: UUID(uuidString: "96C6C8F6-C9A0-4B0A-9F66-FCF2B9F39C66")!,
            userID: UUID(uuidString: "11111111-1111-1111-1111-111111111111")!
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        let bodyString = try XCTUnwrap(String(data: try XCTUnwrap(request.httpBody), encoding: .utf8))
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/Playlists/96C6C8F6-C9A0-4B0A-9F66-FCF2B9F39C66/Users/11111111-1111-1111-1111-111111111111"
        )
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertTrue(bodyString.contains(#""CanEdit":false"#))
    }

    func testAddVirtualFolderPostsQueryAndBody() async throws {
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: Data(),
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 204)
            )
        }
        let service = makeLibraryService(transport: transport)

        try await service.addVirtualFolder(
            name: "Movies",
            collectionType: .movies,
            paths: ["/Volumes/Media/Movies"],
            refreshLibrary: true,
            request: AddVirtualFolderRequest(
                libraryOptions: LibraryOptions(
                    enabled: true,
                    preferredMetadataLanguage: "en",
                    metadataCountryCode: "US"
                )
            )
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        let bodyString = try XCTUnwrap(String(data: try XCTUnwrap(request.httpBody), encoding: .utf8))
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/Library/VirtualFolders?name=Movies&collectionType=movies&paths=/Volumes/Media/Movies&refreshLibrary=true"
        )
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertTrue(bodyString.contains(#""Enabled":true"#))
        XCTAssertTrue(bodyString.contains(#""PreferredMetadataLanguage":"en""#))
    }

    func testDownloadReturnsRawPayloadMetadata() async throws {
        let payload = Data("binary-data".utf8)
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: payload,
                response: makeHTTPResponse(
                    url: try XCTUnwrap(request.url),
                    statusCode: 200,
                    headers: ["Content-Type": "audio/mpeg"]
                )
            )
        }
        let service = makeLibraryService(transport: transport)

        let response = try await service.download(itemID: UUID(uuidString: "D2C48876-BD8F-4D6A-8734-712267F7F9F6")!)

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(request.url?.absoluteString, "https://jellyfin.example.com/Items/D2C48876-BD8F-4D6A-8734-712267F7F9F6/Download")
        XCTAssertEqual(response.data, payload)
        XCTAssertEqual(response.mimeType, "audio/mpeg")
    }

    func testThemeSongsBuildsQuery() async throws {
        let responseData = try FixtureLoader.data(service: "Library", named: "theme-media")
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: responseData,
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200)
            )
        }
        let service = makeLibraryService(transport: transport)

        let result = try await service.themeSongs(
            itemID: UUID(uuidString: "D2C48876-BD8F-4D6A-8734-712267F7F9F6")!,
            query: ThemeMediaQuery(
                userID: UUID(uuidString: "5F6D5A13-4B25-4F8D-B9FB-A3B4699EF301"),
                inheritFromParent: true,
                sortBy: ["SortName"],
                sortOrder: ["Ascending"]
            )
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/Items/D2C48876-BD8F-4D6A-8734-712267F7F9F6/ThemeSongs?userId=5F6D5A13-4B25-4F8D-B9FB-A3B4699EF301&inheritFromParent=true&sortBy=SortName&sortOrder=Ascending"
        )
        XCTAssertEqual(result.items.first?.name, "Imperial March")
    }

    func testMediaUpdatedPostsBody() async throws {
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: Data(),
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 204)
            )
        }
        let service = makeLibraryService(transport: transport)

        try await service.mediaUpdated(
            MediaUpdateInfo(updates: [MediaUpdatePath(path: "/media/movies", updateType: "Modified")])
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        let body = try XCTUnwrap(request.httpBody)
        let decoded = try JellyfinJSONCoder.decoder().decode(MediaUpdateInfo.self, from: body)
        XCTAssertEqual(request.url?.absoluteString, "https://jellyfin.example.com/Library/Media/Updated")
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(decoded.updates.first?.path, "/media/movies")
        XCTAssertEqual(decoded.updates.first?.updateType, "Modified")
    }

    func testSimilarMoviesUsesSharedQuery() async throws {
        let responseData = try FixtureLoader.data(service: "Library", named: "items")
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: responseData,
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200)
            )
        }
        let service = makeLibraryService(transport: transport)

        _ = try await service.similarMovies(
            itemID: UUID(uuidString: "D2C48876-BD8F-4D6A-8734-712267F7F9F6")!,
            query: SimilarItemsQuery(limit: 4, fields: ["Overview"])
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/Movies/D2C48876-BD8F-4D6A-8734-712267F7F9F6/Similar?limit=4&fields=Overview"
        )
    }

    func testDeleteItemsUsesJoinedIDsQuery() async throws {
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: Data(),
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 204)
            )
        }
        let service = makeLibraryService(transport: transport)

        try await service.deleteItems(
            ids: [
                UUID(uuidString: "D2C48876-BD8F-4D6A-8734-712267F7F9F6")!,
                UUID(uuidString: "96C6C8F6-C9A0-4B0A-9F66-FCF2B9F39C66")!,
            ]
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/Items?ids=D2C48876-BD8F-4D6A-8734-712267F7F9F6,96C6C8F6-C9A0-4B0A-9F66-FCF2B9F39C66"
        )
        XCTAssertEqual(request.httpMethod, "DELETE")
    }
}

private func makeLibraryService(
    authorization: JellyfinAuthorization = .header("MediaBrowser Token=test-token"),
    transport: any JellyfinTransporting
) -> LibraryServiceClient {
    LibraryServiceClient(executor: makeTestExecutor(authorization: authorization, transport: transport))
}
