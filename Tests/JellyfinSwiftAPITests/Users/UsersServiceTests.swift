import Foundation
import XCTest
@testable import JellyfinSwiftAPI

final class UsersServiceTests: XCTestCase {
    func testCurrentUserUsesAuthorization() async throws {
        let responseData = try FixtureLoader.data(service: "Users", named: "current-user")
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: responseData,
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200)
            )
        }
        let service = makeUsersService(
            authorization: .header("MediaBrowser Token=test-token"),
            transport: transport
        )

        _ = try await service.currentUser()

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(request.value(forHTTPHeaderField: "Authorization"), "MediaBrowser Token=test-token")
        XCTAssertEqual(request.url?.absoluteString, "https://jellyfin.example.com/Users/Me")
    }

    func testUsersQueryIncludesOptionalFlags() async throws {
        let responseData = try FixtureLoader.data(service: "Users", named: "users")
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: responseData,
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200)
            )
        }
        let service = makeUsersService(
            authorization: .header("MediaBrowser Token=test-token"),
            transport: transport
        )

        let users = try await service.users(isHidden: false, isDisabled: true)

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/Users?isHidden=false&isDisabled=true"
        )
        XCTAssertEqual(users.count, 1)
    }

    func testUpdateUserConfigurationPostsBodyAndQuery() async throws {
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: Data(),
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 204)
            )
        }
        let service = makeUsersService(
            authorization: .header("MediaBrowser Token=test-token"),
            transport: transport
        )
        let userID = UUID(uuidString: "5F6D5A13-4B25-4F8D-B9FB-A3B4699EF001")!

        try await service.updateUserConfiguration(
            UserConfiguration(
                audioLanguagePreference: "en",
                playDefaultAudioTrack: true,
                subtitleLanguagePreference: "en",
                displayMissingEpisodes: false,
                groupedFolders: [],
                subtitleMode: .always,
                displayCollectionsView: true,
                enableLocalPassword: true,
                orderedViews: [],
                latestItemsExcludes: [],
                myMediaExcludes: [],
                hidePlayedInLatest: true,
                rememberAudioSelections: true,
                rememberSubtitleSelections: true,
                enableNextEpisodeAutoPlay: true,
                castReceiverId: nil
            ),
            userID: userID
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/Users/Configuration?userId=5F6D5A13-4B25-4F8D-B9FB-A3B4699EF001"
        )
        XCTAssertTrue((String(data: try XCTUnwrap(request.httpBody), encoding: .utf8) ?? "").contains("\"SubtitleMode\":\"Always\""))
    }

    func testDisplayPreferencesUsesClientAndUserQuery() async throws {
        let responseData = try FixtureLoader.data(service: "Users", named: "display-preferences")
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: responseData,
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200)
            )
        }
        let service = makeUsersService(
            authorization: .header("MediaBrowser Token=test-token"),
            transport: transport
        )
        let userID = UUID(uuidString: "5F6D5A13-4B25-4F8D-B9FB-A3B4699EF001")!

        let preferences = try await service.displayPreferences(
            id: "home",
            userID: userID,
            client: "jellyfin-ios"
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/DisplayPreferences/home?client=jellyfin-ios&userId=5F6D5A13-4B25-4F8D-B9FB-A3B4699EF001"
        )
        XCTAssertEqual(preferences.client, "jellyfin-ios")
    }
}

private func makeUsersService(
    authorization: JellyfinAuthorization = .none,
    transport: any JellyfinTransporting
) -> UsersServiceClient {
    UsersServiceClient(executor: makeTestExecutor(authorization: authorization, transport: transport))
}
