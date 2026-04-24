import XCTest
@testable import JellyfinSwiftAPI

final class JellyfinSwiftAPITests: XCTestCase {
    func testInitialization() throws {
        let url = try XCTUnwrap(URL(string: "https://jellyfin.example.com"))
        let client = JellyfinSwiftAPI(serverURL: url)
        XCTAssertEqual(client.serverURL, url)
    }
}
