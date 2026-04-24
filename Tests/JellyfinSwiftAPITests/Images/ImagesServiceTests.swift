import Foundation
import XCTest
@testable import JellyfinSwiftAPI

final class ImagesServiceTests: XCTestCase {
    func testItemImageInfosUsesItemPath() async throws {
        let responseData = try FixtureLoader.data(service: "Images", named: "image-infos")
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: responseData,
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200)
            )
        }
        let service = makeImagesService(transport: transport)

        let infos = try await service.itemImageInfos(itemID: UUID(uuidString: "D2C48876-BD8F-4D6A-8734-712267F7F9F6")!)

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(request.url?.absoluteString, "https://jellyfin.example.com/Items/D2C48876-BD8F-4D6A-8734-712267F7F9F6/Images")
        XCTAssertEqual(infos.first?.imageTag, "primary-tag")
    }

    func testItemImageReturnsRawPayload() async throws {
        let payload = Data("image-bytes".utf8)
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: payload,
                response: makeHTTPResponse(
                    url: try XCTUnwrap(request.url),
                    statusCode: 200,
                    headers: ["Content-Type": "image/jpeg"]
                )
            )
        }
        let service = makeImagesService(transport: transport)

        let image = try await service.itemImage(
            itemID: UUID(uuidString: "D2C48876-BD8F-4D6A-8734-712267F7F9F6")!,
            type: .primary,
            query: ImageRequestOptions(maxWidth: 600, quality: 90)
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/Items/D2C48876-BD8F-4D6A-8734-712267F7F9F6/Images/Primary?maxWidth=600&quality=90"
        )
        XCTAssertEqual(image.mimeType, "image/jpeg")
        XCTAssertEqual(image.data, payload)
    }

    func testHeadItemImageUsesHEADMethod() async throws {
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: Data(),
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200)
            )
        }
        let service = makeImagesService(transport: transport)

        try await service.headItemImage(
            itemID: UUID(uuidString: "D2C48876-BD8F-4D6A-8734-712267F7F9F6")!,
            type: .primary,
            query: ImageRequestOptions(tag: "primary-tag")
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(request.httpMethod, "HEAD")
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/Items/D2C48876-BD8F-4D6A-8734-712267F7F9F6/Images/Primary?tag=primary-tag"
        )
    }

    func testNamedImageUsesResourcePathAndIndex() async throws {
        let payload = Data("genre-image".utf8)
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: payload,
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200)
            )
        }
        let service = makeImagesService(transport: transport)

        _ = try await service.image(
            resource: .genre,
            named: "Sci-Fi",
            type: .primary,
            imageIndex: 1,
            query: ImageRequestOptions(format: .png)
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/Genres/Sci-Fi/Images/Primary/1?format=Png"
        )
    }

    func testSetItemImageUploadsRawBody() async throws {
        let payload = Data("upload-bytes".utf8)
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: Data(),
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 204)
            )
        }
        let service = makeImagesService(transport: transport)

        try await service.setItemImage(
            itemID: UUID(uuidString: "D2C48876-BD8F-4D6A-8734-712267F7F9F6")!,
            type: .primary,
            data: payload,
            contentType: "image/png"
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.value(forHTTPHeaderField: "Content-Type"), "image/png")
        XCTAssertEqual(request.httpBody, payload)
    }

    func testVersionedItemImageBuildsPathAndQuery() async throws {
        let payload = Data("versioned-image".utf8)
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: payload,
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200)
            )
        }
        let service = makeImagesService(transport: transport)

        _ = try await service.versionedItemImage(
            VersionedItemImageRequest(
                itemID: UUID(uuidString: "D2C48876-BD8F-4D6A-8734-712267F7F9F6")!,
                type: .primary,
                imageIndex: 0,
                tag: "primary-tag",
                format: .jpg,
                maxWidth: 800,
                maxHeight: 600,
                percentPlayed: 0,
                unplayedCount: 0,
                query: ImageRequestOptions(quality: 80)
            )
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/Items/D2C48876-BD8F-4D6A-8734-712267F7F9F6/Images/Primary/0/primary-tag/Jpg/800/600/0.0/0?quality=80"
        )
    }
}

private func makeImagesService(
    authorization: JellyfinAuthorization = .header("MediaBrowser Token=test-token"),
    transport: any JellyfinTransporting
) -> ImagesServiceClient {
    ImagesServiceClient(executor: makeTestExecutor(authorization: authorization, transport: transport))
}
