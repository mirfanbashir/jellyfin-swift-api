import Foundation

/// External identifier information for an item.
public struct ExternalIDInfo: Codable, Sendable, Equatable {
    public let name: String
    public let key: String
    public let type: ExternalIDMediaType?
}

/// Media types supported by external identifier providers.
public enum ExternalIDMediaType: String, Codable, Sendable, Equatable {
    case album = "Album"
    case albumArtist = "AlbumArtist"
    case artist = "Artist"
    case boxSet = "BoxSet"
    case episode = "Episode"
    case movie = "Movie"
    case otherArtist = "OtherArtist"
    case person = "Person"
    case releaseGroup = "ReleaseGroup"
    case season = "Season"
    case series = "Series"
    case track = "Track"
    case book = "Book"
    case recording = "Recording"
}

/// Result returned by remote metadata searches.
public struct RemoteSearchResult: Codable, Sendable, Equatable {
    public let name: String?
    public let providerIds: [String: String?]?
    public let productionYear: Int?
    public let indexNumber: Int?
    public let indexNumberEnd: Int?
    public let parentIndexNumber: Int?
    public let premiereDate: Date?
    public let imageUrl: String?
    public let searchProviderName: String?
    public let overview: String?
}

/// Shared metadata search-info shape.
public struct MetadataSearchInfo: Codable, Sendable, Equatable {
    public let name: String?
    public let originalTitle: String?
    public let path: String?
    public let metadataLanguage: String?
    public let metadataCountryCode: String?
    public let providerIds: [String: String?]?
    public let year: Int?
    public let indexNumber: Int?
    public let parentIndexNumber: Int?
    public let premiereDate: Date?
    public let isAutomated: Bool
}

/// Album-specific metadata search info.
public struct AlbumSearchInfo: Codable, Sendable, Equatable {
    public let name: String?
    public let originalTitle: String?
    public let path: String?
    public let metadataLanguage: String?
    public let metadataCountryCode: String?
    public let providerIds: [String: String?]?
    public let year: Int?
    public let indexNumber: Int?
    public let parentIndexNumber: Int?
    public let premiereDate: Date?
    public let isAutomated: Bool
    public let albumArtists: [String]
    public let artistProviderIds: [String: String?]
}

/// Music-video-specific metadata search info.
public struct MusicVideoSearchInfo: Codable, Sendable, Equatable {
    public let name: String?
    public let originalTitle: String?
    public let path: String?
    public let metadataLanguage: String?
    public let metadataCountryCode: String?
    public let providerIds: [String: String?]?
    public let year: Int?
    public let indexNumber: Int?
    public let parentIndexNumber: Int?
    public let premiereDate: Date?
    public let isAutomated: Bool
    public let artists: [String]?
}

/// Generic remote-search request wrapper.
public struct RemoteSearchQuery<SearchInfo: Codable & Sendable & Equatable>: Codable, Sendable, Equatable {
    public let searchInfo: SearchInfo?
    public let itemId: UUID
    public let searchProviderName: String?
    public let includeDisabledProviders: Bool
}

public typealias BookRemoteSearchQuery = RemoteSearchQuery<MetadataSearchInfo>
public typealias BoxSetRemoteSearchQuery = RemoteSearchQuery<MetadataSearchInfo>
public typealias MovieRemoteSearchQuery = RemoteSearchQuery<MetadataSearchInfo>
public typealias MusicAlbumRemoteSearchQuery = RemoteSearchQuery<AlbumSearchInfo>
public typealias MusicArtistRemoteSearchQuery = RemoteSearchQuery<MetadataSearchInfo>
public typealias MusicVideoRemoteSearchQuery = RemoteSearchQuery<MusicVideoSearchInfo>
public typealias PersonRemoteSearchQuery = RemoteSearchQuery<MetadataSearchInfo>
public typealias SeriesRemoteSearchQuery = RemoteSearchQuery<MetadataSearchInfo>
public typealias TrailerRemoteSearchQuery = RemoteSearchQuery<MetadataSearchInfo>

/// Refresh options used by the metadata refresh endpoint.
public struct MetadataRefreshOptions: Sendable, Equatable {
    public let metadataRefreshMode: MetadataRefreshMode?
    public let imageRefreshMode: MetadataRefreshMode?
    public let replaceAllMetadata: Bool?
    public let replaceAllImages: Bool?
    public let regenerateTrickplay: Bool?

    public init(
        metadataRefreshMode: MetadataRefreshMode? = nil,
        imageRefreshMode: MetadataRefreshMode? = nil,
        replaceAllMetadata: Bool? = nil,
        replaceAllImages: Bool? = nil,
        regenerateTrickplay: Bool? = nil
    ) {
        self.metadataRefreshMode = metadataRefreshMode
        self.imageRefreshMode = imageRefreshMode
        self.replaceAllMetadata = replaceAllMetadata
        self.replaceAllImages = replaceAllImages
        self.regenerateTrickplay = regenerateTrickplay
    }
}

/// Metadata refresh mode values.
public enum MetadataRefreshMode: String, Codable, Sendable, Equatable {
    case none = "None"
    case validationOnly = "ValidationOnly"
    case `default` = "Default"
    case fullRefresh = "FullRefresh"
}

/// Metadata editor metadata for an item.
public struct MetadataEditorInfo: Codable, Sendable, Equatable {
    public let parentalRatingOptions: [ParentalRating]
    public let countries: [CountryInfo]
    public let cultures: [Culture]
    public let externalIdInfos: [ExternalIDInfo]
    public let contentType: CollectionType?
    public let contentTypeOptions: [NameValuePair]
}

/// Name/value pair option returned by metadata editor endpoints.
public struct NameValuePair: Codable, Sendable, Equatable {
    public let name: String?
    public let value: String?
}

/// Collection content types supported by Jellyfin.
public enum CollectionType: String, Codable, Sendable, Equatable {
    case unknown
    case movies
    case tvshows
    case music
    case musicvideos
    case trailers
    case homevideos
    case boxsets
    case books
    case photos
    case livetv
    case playlists
    case folders
}

/// Query options for remote image searches.
public struct RemoteImagesQuery: Sendable, Equatable {
    public let type: ImageType?
    public let startIndex: Int?
    public let limit: Int?
    public let providerName: String?
    public let includeAllLanguages: Bool?

    public init(
        type: ImageType? = nil,
        startIndex: Int? = nil,
        limit: Int? = nil,
        providerName: String? = nil,
        includeAllLanguages: Bool? = nil
    ) {
        self.type = type
        self.startIndex = startIndex
        self.limit = limit
        self.providerName = providerName
        self.includeAllLanguages = includeAllLanguages
    }
}

/// Remote image search results.
public struct RemoteImageResult: Codable, Sendable, Equatable {
    public let images: [RemoteImageInfo]?
    public let totalRecordCount: Int
    public let providers: [String]?
}

/// Remote image candidate entry.
public struct RemoteImageInfo: Codable, Sendable, Equatable {
    public let providerName: String?
    public let url: String?
    public let thumbnailUrl: String?
    public let height: Int?
    public let width: Int?
    public let communityRating: Double?
    public let voteCount: Int?
    public let language: String?
    public let type: ImageType
    public let ratingType: ImageRatingType
}

/// Supported Jellyfin image types.
public enum ImageType: String, Codable, Sendable, Equatable {
    case primary = "Primary"
    case art = "Art"
    case backdrop = "Backdrop"
    case banner = "Banner"
    case logo = "Logo"
    case thumb = "Thumb"
    case disc = "Disc"
    case box = "Box"
    case screenshot = "Screenshot"
    case menu = "Menu"
    case chapter = "Chapter"
    case boxRear = "BoxRear"
    case profile = "Profile"
}

/// Rating types used by remote images.
public enum ImageRatingType: String, Codable, Sendable, Equatable {
    case score = "Score"
    case likes = "Likes"
}

/// Image provider information.
public struct ImageProviderInfo: Codable, Sendable, Equatable {
    public let name: String
    public let supportedImages: [ImageType]
}
