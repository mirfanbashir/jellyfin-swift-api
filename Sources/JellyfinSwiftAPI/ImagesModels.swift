import Foundation

/// Generic image-transformation options shared by many image endpoints.
public struct ImageRequestOptions: Sendable, Equatable {
    public var tag: String?
    public var format: ImageFormat?
    public var maxWidth: Int?
    public var maxHeight: Int?
    public var percentPlayed: Double?
    public var unplayedCount: Int?
    public var width: Int?
    public var height: Int?
    public var quality: Int?
    public var fillWidth: Int?
    public var fillHeight: Int?
    public var blur: Int?
    public var backgroundColor: String?
    public var foregroundLayer: String?
    public var imageIndex: Int?
    public var additionalQueryItems: [URLQueryItem]

    public init(
        tag: String? = nil,
        format: ImageFormat? = nil,
        maxWidth: Int? = nil,
        maxHeight: Int? = nil,
        percentPlayed: Double? = nil,
        unplayedCount: Int? = nil,
        width: Int? = nil,
        height: Int? = nil,
        quality: Int? = nil,
        fillWidth: Int? = nil,
        fillHeight: Int? = nil,
        blur: Int? = nil,
        backgroundColor: String? = nil,
        foregroundLayer: String? = nil,
        imageIndex: Int? = nil,
        additionalQueryItems: [URLQueryItem] = []
    ) {
        self.tag = tag
        self.format = format
        self.maxWidth = maxWidth
        self.maxHeight = maxHeight
        self.percentPlayed = percentPlayed
        self.unplayedCount = unplayedCount
        self.width = width
        self.height = height
        self.quality = quality
        self.fillWidth = fillWidth
        self.fillHeight = fillHeight
        self.blur = blur
        self.backgroundColor = backgroundColor
        self.foregroundLayer = foregroundLayer
        self.imageIndex = imageIndex
        self.additionalQueryItems = additionalQueryItems
    }
}

/// Path-based request for the versioned item image endpoint.
public struct VersionedItemImageRequest: Sendable, Equatable {
    public let itemID: UUID
    public let type: ImageType
    public let imageIndex: Int
    public let tag: String
    public let format: ImageFormat
    public let maxWidth: Int
    public let maxHeight: Int
    public let percentPlayed: Double
    public let unplayedCount: Int
    public let query: ImageRequestOptions

    public init(
        itemID: UUID,
        type: ImageType,
        imageIndex: Int,
        tag: String,
        format: ImageFormat,
        maxWidth: Int,
        maxHeight: Int,
        percentPlayed: Double,
        unplayedCount: Int,
        query: ImageRequestOptions = ImageRequestOptions()
    ) {
        self.itemID = itemID
        self.type = type
        self.imageIndex = imageIndex
        self.tag = tag
        self.format = format
        self.maxWidth = maxWidth
        self.maxHeight = maxHeight
        self.percentPlayed = percentPlayed
        self.unplayedCount = unplayedCount
        self.query = query
    }
}

/// Named-resource groups that expose images by entity name.
public enum NamedImageResource: String, Sendable, Equatable {
    case artist = "Artists"
    case genre = "Genres"
    case musicGenre = "MusicGenres"
    case person = "Persons"
    case studio = "Studios"
}

/// Supported image output formats.
public enum ImageFormat: String, Codable, Sendable, Equatable {
    case bmp = "Bmp"
    case gif = "Gif"
    case jpg = "Jpg"
    case png = "Png"
    case webp = "Webp"
    case svg = "Svg"
}

/// Metadata about an image associated with an item.
public struct ImageInfo: Codable, Sendable, Equatable {
    public let imageType: ImageType?
    public let imageIndex: Int?
    public let imageTag: String?
    public let path: String?
    public let blurHash: String?
    public let height: Int?
    public let width: Int?
    public let size: Int64?

    enum CodingKeys: String, CodingKey {
        case imageType = "ImageType"
        case imageIndex = "ImageIndex"
        case imageTag = "ImageTag"
        case path = "Path"
        case blurHash = "BlurHash"
        case height = "Height"
        case width = "Width"
        case size = "Size"
    }
}
