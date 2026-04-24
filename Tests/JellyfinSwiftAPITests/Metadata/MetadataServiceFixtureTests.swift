import XCTest
@testable import JellyfinSwiftAPI

final class MetadataServiceFixtureTests: XCTestCase {
    func testExternalIDInfosFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "Metadata", named: "external-id-infos")
        let decoded = try JellyfinJSONCoder.decoder().decode([ExternalIDInfo].self, from: data)

        XCTAssertEqual(decoded.first?.key, "IMDb")
    }

    func testMetadataEditorFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "Metadata", named: "metadata-editor")
        let decoded = try JellyfinJSONCoder.decoder().decode(MetadataEditorInfo.self, from: data)

        XCTAssertEqual(decoded.contentType, .movies)
        XCTAssertEqual(decoded.contentTypeOptions.first?.value, "movies")
    }

    func testRemoteImagesFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "Metadata", named: "remote-images")
        let decoded = try JellyfinJSONCoder.decoder().decode(RemoteImageResult.self, from: data)

        XCTAssertEqual(decoded.totalRecordCount, 1)
        XCTAssertEqual(decoded.images?.first?.type, .primary)
    }
}
