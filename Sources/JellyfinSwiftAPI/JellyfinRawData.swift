import Foundation

/// Raw response payload returned by binary or opaque-text Jellyfin endpoints.
public struct JellyfinRawData: Sendable, Equatable {
    public let data: Data
    public let mimeType: String?
    public let statusCode: Int

    public init(data: Data, mimeType: String?, statusCode: Int) {
        self.data = data
        self.mimeType = mimeType
        self.statusCode = statusCode
    }
}
