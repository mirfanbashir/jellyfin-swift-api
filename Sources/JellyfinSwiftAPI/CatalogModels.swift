import Foundation

/// Query options shared by many catalog list endpoints.
public struct CatalogQuery: Sendable, Equatable {
    public var userID: UUID?
    public var startIndex: Int?
    public var limit: Int?
    public var searchTerm: String?
    public var parentID: UUID?
    public var fields: [String]
    public var excludeItemTypes: [String]
    public var includeItemTypes: [String]
    public var filters: [String]
    public var isFavorite: Bool?
    public var mediaTypes: [String]
    public var genres: [String]
    public var genreIDs: [UUID]
    public var officialRatings: [String]
    public var tags: [String]
    public var years: [Int]
    public var enableUserData: Bool?
    public var imageTypeLimit: Int?
    public var enableImageTypes: [String]
    public var person: String?
    public var personIDs: [UUID]
    public var personTypes: [String]
    public var studios: [String]
    public var studioIDs: [UUID]
    public var nameStartsWithOrGreater: String?
    public var nameStartsWith: String?
    public var nameLessThan: String?
    public var sortBy: [String]
    public var sortOrder: [String]
    public var enableImages: Bool?
    public var enableTotalRecordCount: Bool?
    public var recursive: Bool?
    public var minCommunityRating: Double?
    public var additionalQueryItems: [URLQueryItem]

    public init(
        userID: UUID? = nil,
        startIndex: Int? = nil,
        limit: Int? = nil,
        searchTerm: String? = nil,
        parentID: UUID? = nil,
        fields: [String] = [],
        excludeItemTypes: [String] = [],
        includeItemTypes: [String] = [],
        filters: [String] = [],
        isFavorite: Bool? = nil,
        mediaTypes: [String] = [],
        genres: [String] = [],
        genreIDs: [UUID] = [],
        officialRatings: [String] = [],
        tags: [String] = [],
        years: [Int] = [],
        enableUserData: Bool? = nil,
        imageTypeLimit: Int? = nil,
        enableImageTypes: [String] = [],
        person: String? = nil,
        personIDs: [UUID] = [],
        personTypes: [String] = [],
        studios: [String] = [],
        studioIDs: [UUID] = [],
        nameStartsWithOrGreater: String? = nil,
        nameStartsWith: String? = nil,
        nameLessThan: String? = nil,
        sortBy: [String] = [],
        sortOrder: [String] = [],
        enableImages: Bool? = nil,
        enableTotalRecordCount: Bool? = nil,
        recursive: Bool? = nil,
        minCommunityRating: Double? = nil,
        additionalQueryItems: [URLQueryItem] = []
    ) {
        self.userID = userID
        self.startIndex = startIndex
        self.limit = limit
        self.searchTerm = searchTerm
        self.parentID = parentID
        self.fields = fields
        self.excludeItemTypes = excludeItemTypes
        self.includeItemTypes = includeItemTypes
        self.filters = filters
        self.isFavorite = isFavorite
        self.mediaTypes = mediaTypes
        self.genres = genres
        self.genreIDs = genreIDs
        self.officialRatings = officialRatings
        self.tags = tags
        self.years = years
        self.enableUserData = enableUserData
        self.imageTypeLimit = imageTypeLimit
        self.enableImageTypes = enableImageTypes
        self.person = person
        self.personIDs = personIDs
        self.personTypes = personTypes
        self.studios = studios
        self.studioIDs = studioIDs
        self.nameStartsWithOrGreater = nameStartsWithOrGreater
        self.nameStartsWith = nameStartsWith
        self.nameLessThan = nameLessThan
        self.sortBy = sortBy
        self.sortOrder = sortOrder
        self.enableImages = enableImages
        self.enableTotalRecordCount = enableTotalRecordCount
        self.recursive = recursive
        self.minCommunityRating = minCommunityRating
        self.additionalQueryItems = additionalQueryItems
    }
}

/// Person-specific catalog query options.
public struct PersonQuery: Sendable, Equatable {
    public var limit: Int?
    public var searchTerm: String?
    public var fields: [String]
    public var filters: [String]
    public var isFavorite: Bool?
    public var enableUserData: Bool?
    public var imageTypeLimit: Int?
    public var enableImageTypes: [String]
    public var excludePersonTypes: [String]
    public var personTypes: [String]
    public var appearsInItemID: UUID?
    public var userID: UUID?
    public var enableImages: Bool?
    public var additionalQueryItems: [URLQueryItem]

    public init(
        limit: Int? = nil,
        searchTerm: String? = nil,
        fields: [String] = [],
        filters: [String] = [],
        isFavorite: Bool? = nil,
        enableUserData: Bool? = nil,
        imageTypeLimit: Int? = nil,
        enableImageTypes: [String] = [],
        excludePersonTypes: [String] = [],
        personTypes: [String] = [],
        appearsInItemID: UUID? = nil,
        userID: UUID? = nil,
        enableImages: Bool? = nil,
        additionalQueryItems: [URLQueryItem] = []
    ) {
        self.limit = limit
        self.searchTerm = searchTerm
        self.fields = fields
        self.filters = filters
        self.isFavorite = isFavorite
        self.enableUserData = enableUserData
        self.imageTypeLimit = imageTypeLimit
        self.enableImageTypes = enableImageTypes
        self.excludePersonTypes = excludePersonTypes
        self.personTypes = personTypes
        self.appearsInItemID = appearsInItemID
        self.userID = userID
        self.enableImages = enableImages
        self.additionalQueryItems = additionalQueryItems
    }
}

/// Query options for movie recommendations.
public struct MovieRecommendationsQuery: Sendable, Equatable {
    public var userID: UUID?
    public var parentID: UUID?
    public var fields: [String]
    public var categoryLimit: Int?
    public var itemLimit: Int?
    public var additionalQueryItems: [URLQueryItem]

    public init(
        userID: UUID? = nil,
        parentID: UUID? = nil,
        fields: [String] = [],
        categoryLimit: Int? = nil,
        itemLimit: Int? = nil,
        additionalQueryItems: [URLQueryItem] = []
    ) {
        self.userID = userID
        self.parentID = parentID
        self.fields = fields
        self.categoryLimit = categoryLimit
        self.itemLimit = itemLimit
        self.additionalQueryItems = additionalQueryItems
    }
}

/// Query options for episode lists.
public struct EpisodesQuery: Sendable, Equatable {
    public var userID: UUID?
    public var fields: [String]
    public var season: Int?
    public var seasonID: UUID?
    public var isMissing: Bool?
    public var adjacentTo: UUID?
    public var startItemID: UUID?
    public var startIndex: Int?
    public var limit: Int?
    public var enableImages: Bool?
    public var imageTypeLimit: Int?
    public var enableImageTypes: [String]
    public var enableUserData: Bool?
    public var sortBy: String?
    public var additionalQueryItems: [URLQueryItem]

    public init(
        userID: UUID? = nil,
        fields: [String] = [],
        season: Int? = nil,
        seasonID: UUID? = nil,
        isMissing: Bool? = nil,
        adjacentTo: UUID? = nil,
        startItemID: UUID? = nil,
        startIndex: Int? = nil,
        limit: Int? = nil,
        enableImages: Bool? = nil,
        imageTypeLimit: Int? = nil,
        enableImageTypes: [String] = [],
        enableUserData: Bool? = nil,
        sortBy: String? = nil,
        additionalQueryItems: [URLQueryItem] = []
    ) {
        self.userID = userID
        self.fields = fields
        self.season = season
        self.seasonID = seasonID
        self.isMissing = isMissing
        self.adjacentTo = adjacentTo
        self.startItemID = startItemID
        self.startIndex = startIndex
        self.limit = limit
        self.enableImages = enableImages
        self.imageTypeLimit = imageTypeLimit
        self.enableImageTypes = enableImageTypes
        self.enableUserData = enableUserData
        self.sortBy = sortBy
        self.additionalQueryItems = additionalQueryItems
    }
}

/// Query options for season lists.
public struct SeasonsQuery: Sendable, Equatable {
    public var userID: UUID?
    public var fields: [String]
    public var isSpecialSeason: Bool?
    public var isMissing: Bool?
    public var adjacentTo: UUID?
    public var enableImages: Bool?
    public var imageTypeLimit: Int?
    public var enableImageTypes: [String]
    public var enableUserData: Bool?
    public var additionalQueryItems: [URLQueryItem]

    public init(
        userID: UUID? = nil,
        fields: [String] = [],
        isSpecialSeason: Bool? = nil,
        isMissing: Bool? = nil,
        adjacentTo: UUID? = nil,
        enableImages: Bool? = nil,
        imageTypeLimit: Int? = nil,
        enableImageTypes: [String] = [],
        enableUserData: Bool? = nil,
        additionalQueryItems: [URLQueryItem] = []
    ) {
        self.userID = userID
        self.fields = fields
        self.isSpecialSeason = isSpecialSeason
        self.isMissing = isMissing
        self.adjacentTo = adjacentTo
        self.enableImages = enableImages
        self.imageTypeLimit = imageTypeLimit
        self.enableImageTypes = enableImageTypes
        self.enableUserData = enableUserData
        self.additionalQueryItems = additionalQueryItems
    }
}

/// Query options for the Next Up endpoint.
public struct NextUpQuery: Sendable, Equatable {
    public var userID: UUID?
    public var startIndex: Int?
    public var limit: Int?
    public var fields: [String]
    public var seriesID: UUID?
    public var parentID: UUID?
    public var enableImages: Bool?
    public var imageTypeLimit: Int?
    public var enableImageTypes: [String]
    public var enableUserData: Bool?
    public var nextUpDateCutoff: Date?
    public var enableTotalRecordCount: Bool?
    public var disableFirstEpisode: Bool?
    public var enableResumable: Bool?
    public var enableRewatching: Bool?
    public var additionalQueryItems: [URLQueryItem]

    public init(
        userID: UUID? = nil,
        startIndex: Int? = nil,
        limit: Int? = nil,
        fields: [String] = [],
        seriesID: UUID? = nil,
        parentID: UUID? = nil,
        enableImages: Bool? = nil,
        imageTypeLimit: Int? = nil,
        enableImageTypes: [String] = [],
        enableUserData: Bool? = nil,
        nextUpDateCutoff: Date? = nil,
        enableTotalRecordCount: Bool? = nil,
        disableFirstEpisode: Bool? = nil,
        enableResumable: Bool? = nil,
        enableRewatching: Bool? = nil,
        additionalQueryItems: [URLQueryItem] = []
    ) {
        self.userID = userID
        self.startIndex = startIndex
        self.limit = limit
        self.fields = fields
        self.seriesID = seriesID
        self.parentID = parentID
        self.enableImages = enableImages
        self.imageTypeLimit = imageTypeLimit
        self.enableImageTypes = enableImageTypes
        self.enableUserData = enableUserData
        self.nextUpDateCutoff = nextUpDateCutoff
        self.enableTotalRecordCount = enableTotalRecordCount
        self.disableFirstEpisode = disableFirstEpisode
        self.enableResumable = enableResumable
        self.enableRewatching = enableRewatching
        self.additionalQueryItems = additionalQueryItems
    }
}

/// Query options for upcoming episodes.
public struct UpcomingEpisodesQuery: Sendable, Equatable {
    public var userID: UUID?
    public var startIndex: Int?
    public var limit: Int?
    public var fields: [String]
    public var parentID: UUID?
    public var enableImages: Bool?
    public var imageTypeLimit: Int?
    public var enableImageTypes: [String]
    public var enableUserData: Bool?
    public var additionalQueryItems: [URLQueryItem]

    public init(
        userID: UUID? = nil,
        startIndex: Int? = nil,
        limit: Int? = nil,
        fields: [String] = [],
        parentID: UUID? = nil,
        enableImages: Bool? = nil,
        imageTypeLimit: Int? = nil,
        enableImageTypes: [String] = [],
        enableUserData: Bool? = nil,
        additionalQueryItems: [URLQueryItem] = []
    ) {
        self.userID = userID
        self.startIndex = startIndex
        self.limit = limit
        self.fields = fields
        self.parentID = parentID
        self.enableImages = enableImages
        self.imageTypeLimit = imageTypeLimit
        self.enableImageTypes = enableImageTypes
        self.enableUserData = enableUserData
        self.additionalQueryItems = additionalQueryItems
    }
}

/// Generic query result container for catalog items.
public struct BaseItemQueryResult: Codable, Sendable, Equatable {
    public let items: [BaseItem]
    public let totalRecordCount: Int
    public let startIndex: Int

    enum CodingKeys: String, CodingKey {
        case items = "Items"
        case totalRecordCount = "TotalRecordCount"
        case startIndex = "StartIndex"
    }
}

/// Partial Jellyfin item model used by catalog browse endpoints.
public struct BaseItem: Codable, Sendable, Equatable {
    public let name: String?
    public let originalTitle: String?
    public let serverId: String?
    public let id: UUID
    public let etag: String?
    public let sourceType: String?
    public let playlistItemId: String?
    public let dateCreated: Date?
    public let dateLastMediaAdded: Date?
    public let sortName: String?
    public let premiereDate: Date?
    public let officialRating: String?
    public let overview: String?
    public let genres: [String]?
    public let communityRating: Float?
    public let runTimeTicks: Int64?
    public let productionYear: Int?
    public let indexNumber: Int?
    public let parentIndexNumber: Int?
    public let type: BaseItemKind?
    public let mediaType: MediaType?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case originalTitle = "OriginalTitle"
        case serverId = "ServerId"
        case id = "Id"
        case etag = "Etag"
        case sourceType = "SourceType"
        case playlistItemId = "PlaylistItemId"
        case dateCreated = "DateCreated"
        case dateLastMediaAdded = "DateLastMediaAdded"
        case sortName = "SortName"
        case premiereDate = "PremiereDate"
        case officialRating = "OfficialRating"
        case overview = "Overview"
        case genres = "Genres"
        case communityRating = "CommunityRating"
        case runTimeTicks = "RunTimeTicks"
        case productionYear = "ProductionYear"
        case indexNumber = "IndexNumber"
        case parentIndexNumber = "ParentIndexNumber"
        case type = "Type"
        case mediaType = "MediaType"
    }
}

/// Jellyfin item kinds surfaced by browse endpoints.
public enum BaseItemKind: String, Codable, Sendable, Equatable {
    case aggregateFolder = "AggregateFolder"
    case audio = "Audio"
    case audioBook = "AudioBook"
    case basePluginFolder = "BasePluginFolder"
    case book = "Book"
    case boxSet = "BoxSet"
    case channel = "Channel"
    case channelFolderItem = "ChannelFolderItem"
    case collectionFolder = "CollectionFolder"
    case episode = "Episode"
    case folder = "Folder"
    case genre = "Genre"
    case manualPlaylistsFolder = "ManualPlaylistsFolder"
    case movie = "Movie"
    case liveTVChannel = "LiveTvChannel"
    case liveTVProgram = "LiveTvProgram"
    case musicAlbum = "MusicAlbum"
    case musicArtist = "MusicArtist"
    case musicGenre = "MusicGenre"
    case musicVideo = "MusicVideo"
    case person = "Person"
    case photo = "Photo"
    case photoAlbum = "PhotoAlbum"
    case playlist = "Playlist"
    case playlistsFolder = "PlaylistsFolder"
    case program = "Program"
    case recording = "Recording"
    case season = "Season"
    case series = "Series"
    case studio = "Studio"
    case trailer = "Trailer"
    case tvChannel = "TvChannel"
    case tvProgram = "TvProgram"
    case userRootFolder = "UserRootFolder"
    case userView = "UserView"
    case video = "Video"
    case year = "Year"
}

/// Movie recommendation group.
public struct Recommendation: Codable, Sendable, Equatable {
    public let items: [BaseItem]?
    public let recommendationType: RecommendationType
    public let baselineItemName: String?
    public let categoryId: UUID

    enum CodingKeys: String, CodingKey {
        case items = "Items"
        case recommendationType = "RecommendationType"
        case baselineItemName = "BaselineItemName"
        case categoryId = "CategoryId"
    }
}

/// Recommendation category.
public enum RecommendationType: String, Codable, Sendable, Equatable {
    case similarToRecentlyPlayed = "SimilarToRecentlyPlayed"
    case similarToLikedItem = "SimilarToLikedItem"
    case hasDirectorFromRecentlyPlayed = "HasDirectorFromRecentlyPlayed"
    case hasActorFromRecentlyPlayed = "HasActorFromRecentlyPlayed"
    case hasLikedDirector = "HasLikedDirector"
    case hasLikedActor = "HasLikedActor"
}
