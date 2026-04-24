import Foundation

internal enum JellyfinJSONCoder {
    internal static func decoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .custom { codingPath in
            let lastKey = codingPath.last?.stringValue ?? ""
            guard let firstCharacter = lastKey.first else {
                return AnyCodingKey(stringValue: lastKey) ?? AnyCodingKey(intValue: 0)!
            }

            let normalizedKey = firstCharacter.lowercased() + lastKey.dropFirst()
            return AnyCodingKey(stringValue: normalizedKey) ?? AnyCodingKey(intValue: 0)!
        }
        return decoder
    }

    internal static func encoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.keyEncodingStrategy = .custom { codingPath in
            let lastKey = codingPath.last?.stringValue ?? ""
            guard let firstCharacter = lastKey.first else {
                return AnyCodingKey(stringValue: lastKey) ?? AnyCodingKey(intValue: 0)!
            }

            let normalizedKey = firstCharacter.uppercased() + lastKey.dropFirst()
            return AnyCodingKey(stringValue: normalizedKey) ?? AnyCodingKey(intValue: 0)!
        }
        return encoder
    }
}

internal struct AnyCodingKey: CodingKey {
    let stringValue: String
    let intValue: Int?

    init?(stringValue: String) {
        self.stringValue = stringValue
        self.intValue = nil
    }

    init?(intValue: Int) {
        self.stringValue = String(intValue)
        self.intValue = intValue
    }
}
