import Foundation
import XCTest

enum FixtureLoader {
    static func data(
        service: String,
        named name: String,
        file: StaticString = #filePath,
        line: UInt = #line
    ) throws -> Data {
        guard let url = Bundle.module.url(
            forResource: name,
            withExtension: "json",
            subdirectory: "Fixtures/\(service)"
        ) else {
            XCTFail("Missing fixture \(service)/\(name).json", file: file, line: line)
            throw FixtureLoaderError.missingFixture(service: service, name: name)
        }

        return try Data(contentsOf: url)
    }
}

enum FixtureLoaderError: Error, Equatable {
    case missingFixture(service: String, name: String)
}
