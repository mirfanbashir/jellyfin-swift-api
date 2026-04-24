import XCTest
@testable import JellyfinSwiftAPI

final class ImagesServiceFixtureTests: XCTestCase {
    func testImageInfosFixtureDecodes() throws {
        let data = try FixtureLoader.data(service: "Images", named: "image-infos")
        let decoded = try JellyfinJSONCoder.decoder().decode([ImageInfo].self, from: data)

        XCTAssertEqual(decoded.first?.imageType, .primary)
        XCTAssertEqual(decoded.first?.imageIndex, 0)
    }
}
