import Foundation

internal enum JellyfinUUID {
    internal static func parse(_ value: String) -> UUID? {
        if let uuid = UUID(uuidString: value) {
            return uuid
        }

        let compactValue = value.replacingOccurrences(of: "-", with: "")
        guard compactValue.count == 32 else {
            return nil
        }

        let normalized = [
            compactValue.prefix(8),
            compactValue.dropFirst(8).prefix(4),
            compactValue.dropFirst(12).prefix(4),
            compactValue.dropFirst(16).prefix(4),
            compactValue.dropFirst(20).prefix(12),
        ].map(String.init).joined(separator: "-")

        return UUID(uuidString: normalized)
    }
}

internal extension KeyedDecodingContainer {
    func decodeJellyfinUUID(forKey key: Key) throws -> UUID {
        let value = try decode(String.self, forKey: key)
        guard let uuid = JellyfinUUID.parse(value) else {
            throw DecodingError.dataCorruptedError(
                forKey: key,
                in: self,
                debugDescription: "Expected a Jellyfin UUID string for \(key.stringValue)."
            )
        }
        return uuid
    }

    func decodeJellyfinUUIDIfPresent(forKey key: Key) throws -> UUID? {
        guard let value = try decodeIfPresent(String.self, forKey: key) else {
            return nil
        }
        guard let uuid = JellyfinUUID.parse(value) else {
            throw DecodingError.dataCorruptedError(
                forKey: key,
                in: self,
                debugDescription: "Expected a Jellyfin UUID string for \(key.stringValue)."
            )
        }
        return uuid
    }

    func decodeJellyfinUUIDArray(forKey key: Key) throws -> [UUID] {
        try decode([String].self, forKey: key).map { value in
            guard let uuid = JellyfinUUID.parse(value) else {
                throw DecodingError.dataCorruptedError(
                    forKey: key,
                    in: self,
                    debugDescription: "Expected Jellyfin UUID strings for \(key.stringValue)."
                )
            }
            return uuid
        }
    }

    func decodeJellyfinUUIDArrayIfPresent(forKey key: Key) throws -> [UUID]? {
        guard let values = try decodeIfPresent([String].self, forKey: key) else {
            return nil
        }
        return try values.map { value in
            guard let uuid = JellyfinUUID.parse(value) else {
                throw DecodingError.dataCorruptedError(
                    forKey: key,
                    in: self,
                    debugDescription: "Expected Jellyfin UUID strings for \(key.stringValue)."
                )
            }
            return uuid
        }
    }
}
