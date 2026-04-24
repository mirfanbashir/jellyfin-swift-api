import Foundation
import XCTest
@testable import JellyfinSwiftAPI

final class LiveTVServiceTests: XCTestCase {
    func testLiveTVChannelsUsesTypedQuery() async throws {
        let responseData = try FixtureLoader.data(service: "Library", named: "items")
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: responseData,
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200)
            )
        }
        let service = makeLiveTVService(transport: transport)

        let result = try await service.liveTVChannels(
            LiveTVChannelsQuery(
                userID: UUID(uuidString: "5F6D5A13-4B25-4F8D-B9FB-A3B4699EF301"),
                limit: 10,
                isFavorite: true,
                addCurrentProgram: true
            )
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/LiveTv/Channels?userId=5F6D5A13-4B25-4F8D-B9FB-A3B4699EF301&limit=10&isFavorite=true&addCurrentProgram=true"
        )
        XCTAssertEqual(result.items.first?.name, "The Empire Strikes Back")
    }

    func testSetChannelMappingPostsJSONBody() async throws {
        let responseData = try FixtureLoader.data(service: "LiveTV", named: "tuner-channel-mapping")
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: responseData,
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200)
            )
        }
        let service = makeLiveTVService(transport: transport)

        let mapping = try await service.setChannelMapping(
            SetChannelMappingRequest(providerId: "provider-1", tunerChannelId: "tuner-7", providerChannelId: "provider-7")
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        let body = try JellyfinJSONCoder.decoder().decode(
            SetChannelMappingRequest.self,
            from: try XCTUnwrap(request.httpBody)
        )
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.url?.absoluteString, "https://jellyfin.example.com/LiveTv/ChannelMappings")
        XCTAssertEqual(body.tunerChannelId, "tuner-7")
        XCTAssertEqual(mapping.providerChannelId, "provider-7")
    }

    func testAddListingProviderPostsBodyAndQuery() async throws {
        let responseData = try FixtureLoader.data(service: "LiveTV", named: "listing-provider")
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: responseData,
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200)
            )
        }
        let service = makeLiveTVService(transport: transport)

        let provider = try await service.addListingProvider(
            ListingsProvider(type: "SchedulesDirect", username: "demo", listingsId: "lineup-1"),
            password: "secret",
            validateListings: true,
            validateLogin: false
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/LiveTv/ListingProviders?pw=secret&validateListings=true&validateLogin=false"
        )
        XCTAssertEqual(provider.type, "SchedulesDirect")
    }

    func testProgramsRequestBodyPostsJSON() async throws {
        let responseData = try FixtureLoader.data(service: "Library", named: "items")
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: responseData,
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200)
            )
        }
        let service = makeLiveTVService(transport: transport)

        let requestBody = ProgramsQuery(channelIDs: ["channel-1"], hasAired: false, limit: 5)
        _ = try await service.programs(requestBody: requestBody)

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        let body = try JellyfinJSONCoder.decoder().decode(ProgramsQuery.self, from: try XCTUnwrap(request.httpBody))
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.url?.absoluteString, "https://jellyfin.example.com/LiveTv/Programs")
        XCTAssertEqual(body.channelIDs, ["channel-1"])
    }

    func testLiveStreamFileReturnsRawPayload() async throws {
        let payload = Data(repeating: 0xAA, count: 4)
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: payload,
                response: makeHTTPResponse(
                    url: try XCTUnwrap(request.url),
                    statusCode: 200,
                    headers: ["Content-Type": "video/mp2t"]
                )
            )
        }
        let service = makeLiveTVService(transport: transport)

        let file = try await service.liveStreamFile(streamID: "stream-1", container: "ts")

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(request.url?.absoluteString, "https://jellyfin.example.com/LiveTv/LiveStreamFiles/stream-1/stream.ts")
        XCTAssertEqual(file.mimeType, "video/mp2t")
    }

    func testSeriesTimersUsesQuery() async throws {
        let responseData = try FixtureLoader.data(service: "LiveTV", named: "series-timers")
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: responseData,
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200)
            )
        }
        let service = makeLiveTVService(transport: transport)

        let timers = try await service.seriesTimers(sortBy: "Name", sortOrder: .ascending)

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(request.url?.absoluteString, "https://jellyfin.example.com/LiveTv/SeriesTimers?sortBy=Name&sortOrder=Ascending")
        XCTAssertEqual(timers.items.first?.name, "Science Weekly")
    }

    func testCreateTimerPostsBody() async throws {
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: Data(),
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 204)
            )
        }
        let service = makeLiveTVService(transport: transport)

        try await service.createTimer(
            TimerInfo(channelId: "channel-1", programId: "program-1", name: "Evening News", priority: 1)
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        let body = try JellyfinJSONCoder.decoder().decode(TimerInfo.self, from: try XCTUnwrap(request.httpBody))
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.url?.absoluteString, "https://jellyfin.example.com/LiveTv/Timers")
        XCTAssertEqual(body.name, "Evening News")
    }

    func testDiscoverTunersUsesExpectedPath() async throws {
        let responseData = try FixtureLoader.data(service: "LiveTV", named: "tuners")
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: responseData,
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200)
            )
        }
        let service = makeLiveTVService(transport: transport)

        let tuners = try await service.discoverTuners(newDevicesOnly: true, useLegacyTypoPath: false)

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(request.url?.absoluteString, "https://jellyfin.example.com/LiveTv/Tuners/Discover?newDevicesOnly=true")
        XCTAssertEqual(tuners.first?.friendlyName, "HDHomeRun Flex")
    }
}

private func makeLiveTVService(
    authorization: JellyfinAuthorization = .header("MediaBrowser Token=test-token"),
    transport: any JellyfinTransporting
) -> LiveTVServiceClient {
    LiveTVServiceClient(executor: makeTestExecutor(authorization: authorization, transport: transport))
}
