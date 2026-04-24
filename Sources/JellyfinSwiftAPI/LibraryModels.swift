import Foundation

/// Query options for `/Items`.
public struct LibraryItemsQuery: Sendable, Equatable {
    public var userID: UUID?
    public var startIndex: Int?
    public var limit: Int?
    public var recursive: Bool?
    public var searchTerm: String?
    public var parentID: UUID?
    public var fields: [String]
    public var excludeItemTypes: [String]
    public var includeItemTypes: [String]
    public var filters: [String]
    public var isFavorite: Bool?
    public var mediaTypes: [String]
    public var sortBy: [String]
    public var sortOrder: [String]
    public var genres: [String]
    public var genreIDs: [UUID]
    public var tags: [String]
    public var years: [Int]
    public var enableUserData: Bool?
    public var imageTypeLimit: Int?
    public var enableImageTypes: [String]
    public var enableImages: Bool?
    public var enableTotalRecordCount: Bool?
    public var person: String?
    public var personIDs: [UUID]
    public var personTypes: [String]
    public var studios: [String]
    public var studioIDs: [UUID]
    public var artists: [String]
    public var artistIDs: [UUID]
    public var albumArtistIDs: [UUID]
    public var ids: [UUID]
    public var isPlayed: Bool?
    public var nameStartsWithOrGreater: String?
    public var nameStartsWith: String?
    public var nameLessThan: String?
    public var minCommunityRating: Double?
    public var additionalQueryItems: [URLQueryItem]

    public init(
        userID: UUID? = nil,
        startIndex: Int? = nil,
        limit: Int? = nil,
        recursive: Bool? = nil,
        searchTerm: String? = nil,
        parentID: UUID? = nil,
        fields: [String] = [],
        excludeItemTypes: [String] = [],
        includeItemTypes: [String] = [],
        filters: [String] = [],
        isFavorite: Bool? = nil,
        mediaTypes: [String] = [],
        sortBy: [String] = [],
        sortOrder: [String] = [],
        genres: [String] = [],
        genreIDs: [UUID] = [],
        tags: [String] = [],
        years: [Int] = [],
        enableUserData: Bool? = nil,
        imageTypeLimit: Int? = nil,
        enableImageTypes: [String] = [],
        enableImages: Bool? = nil,
        enableTotalRecordCount: Bool? = nil,
        person: String? = nil,
        personIDs: [UUID] = [],
        personTypes: [String] = [],
        studios: [String] = [],
        studioIDs: [UUID] = [],
        artists: [String] = [],
        artistIDs: [UUID] = [],
        albumArtistIDs: [UUID] = [],
        ids: [UUID] = [],
        isPlayed: Bool? = nil,
        nameStartsWithOrGreater: String? = nil,
        nameStartsWith: String? = nil,
        nameLessThan: String? = nil,
        minCommunityRating: Double? = nil,
        additionalQueryItems: [URLQueryItem] = []
    ) {
        self.userID = userID
        self.startIndex = startIndex
        self.limit = limit
        self.recursive = recursive
        self.searchTerm = searchTerm
        self.parentID = parentID
        self.fields = fields
        self.excludeItemTypes = excludeItemTypes
        self.includeItemTypes = includeItemTypes
        self.filters = filters
        self.isFavorite = isFavorite
        self.mediaTypes = mediaTypes
        self.sortBy = sortBy
        self.sortOrder = sortOrder
        self.genres = genres
        self.genreIDs = genreIDs
        self.tags = tags
        self.years = years
        self.enableUserData = enableUserData
        self.imageTypeLimit = imageTypeLimit
        self.enableImageTypes = enableImageTypes
        self.enableImages = enableImages
        self.enableTotalRecordCount = enableTotalRecordCount
        self.person = person
        self.personIDs = personIDs
        self.personTypes = personTypes
        self.studios = studios
        self.studioIDs = studioIDs
        self.artists = artists
        self.artistIDs = artistIDs
        self.albumArtistIDs = albumArtistIDs
        self.ids = ids
        self.isPlayed = isPlayed
        self.nameStartsWithOrGreater = nameStartsWithOrGreater
        self.nameStartsWith = nameStartsWith
        self.nameLessThan = nameLessThan
        self.minCommunityRating = minCommunityRating
        self.additionalQueryItems = additionalQueryItems
    }
}

/// Query options for similar-item endpoints.
public struct SimilarItemsQuery: Sendable, Equatable {
    public var userID: UUID?
    public var limit: Int?
    public var fields: [String]
    public var excludeArtistIDs: [UUID]
    public var additionalQueryItems: [URLQueryItem]

    public init(
        userID: UUID? = nil,
        limit: Int? = nil,
        fields: [String] = [],
        excludeArtistIDs: [UUID] = [],
        additionalQueryItems: [URLQueryItem] = []
    ) {
        self.userID = userID
        self.limit = limit
        self.fields = fields
        self.excludeArtistIDs = excludeArtistIDs
        self.additionalQueryItems = additionalQueryItems
    }
}

/// Query options for latest media results.
public struct LatestMediaQuery: Sendable, Equatable {
    public var userID: UUID?
    public var parentID: UUID?
    public var fields: [String]
    public var includeItemTypes: [String]
    public var isPlayed: Bool?
    public var enableImages: Bool?
    public var imageTypeLimit: Int?
    public var enableImageTypes: [String]
    public var enableUserData: Bool?
    public var limit: Int?
    public var groupItems: Bool?
    public var additionalQueryItems: [URLQueryItem]

    public init(
        userID: UUID? = nil,
        parentID: UUID? = nil,
        fields: [String] = [],
        includeItemTypes: [String] = [],
        isPlayed: Bool? = nil,
        enableImages: Bool? = nil,
        imageTypeLimit: Int? = nil,
        enableImageTypes: [String] = [],
        enableUserData: Bool? = nil,
        limit: Int? = nil,
        groupItems: Bool? = nil,
        additionalQueryItems: [URLQueryItem] = []
    ) {
        self.userID = userID
        self.parentID = parentID
        self.fields = fields
        self.includeItemTypes = includeItemTypes
        self.isPlayed = isPlayed
        self.enableImages = enableImages
        self.imageTypeLimit = imageTypeLimit
        self.enableImageTypes = enableImageTypes
        self.enableUserData = enableUserData
        self.limit = limit
        self.groupItems = groupItems
        self.additionalQueryItems = additionalQueryItems
    }
}

/// Query options for suggestions.
public struct SuggestionsQuery: Sendable, Equatable {
    public var userID: UUID?
    public var mediaTypes: [String]
    public var itemTypes: [String]
    public var startIndex: Int?
    public var limit: Int?
    public var enableTotalRecordCount: Bool?
    public var additionalQueryItems: [URLQueryItem]

    public init(
        userID: UUID? = nil,
        mediaTypes: [String] = [],
        itemTypes: [String] = [],
        startIndex: Int? = nil,
        limit: Int? = nil,
        enableTotalRecordCount: Bool? = nil,
        additionalQueryItems: [URLQueryItem] = []
    ) {
        self.userID = userID
        self.mediaTypes = mediaTypes
        self.itemTypes = itemTypes
        self.startIndex = startIndex
        self.limit = limit
        self.enableTotalRecordCount = enableTotalRecordCount
        self.additionalQueryItems = additionalQueryItems
    }
}

/// Query options for resume items.
public struct ResumeItemsQuery: Sendable, Equatable {
    public var userID: UUID?
    public var startIndex: Int?
    public var limit: Int?
    public var searchTerm: String?
    public var parentID: UUID?
    public var fields: [String]
    public var mediaTypes: [String]
    public var enableUserData: Bool?
    public var imageTypeLimit: Int?
    public var enableImageTypes: [String]
    public var excludeItemTypes: [String]
    public var includeItemTypes: [String]
    public var enableTotalRecordCount: Bool?
    public var enableImages: Bool?
    public var excludeActiveSessions: Bool?
    public var additionalQueryItems: [URLQueryItem]

    public init(
        userID: UUID? = nil,
        startIndex: Int? = nil,
        limit: Int? = nil,
        searchTerm: String? = nil,
        parentID: UUID? = nil,
        fields: [String] = [],
        mediaTypes: [String] = [],
        enableUserData: Bool? = nil,
        imageTypeLimit: Int? = nil,
        enableImageTypes: [String] = [],
        excludeItemTypes: [String] = [],
        includeItemTypes: [String] = [],
        enableTotalRecordCount: Bool? = nil,
        enableImages: Bool? = nil,
        excludeActiveSessions: Bool? = nil,
        additionalQueryItems: [URLQueryItem] = []
    ) {
        self.userID = userID
        self.startIndex = startIndex
        self.limit = limit
        self.searchTerm = searchTerm
        self.parentID = parentID
        self.fields = fields
        self.mediaTypes = mediaTypes
        self.enableUserData = enableUserData
        self.imageTypeLimit = imageTypeLimit
        self.enableImageTypes = enableImageTypes
        self.excludeItemTypes = excludeItemTypes
        self.includeItemTypes = includeItemTypes
        self.enableTotalRecordCount = enableTotalRecordCount
        self.enableImages = enableImages
        self.excludeActiveSessions = excludeActiveSessions
        self.additionalQueryItems = additionalQueryItems
    }
}

/// Query options for search hints.
public struct SearchHintsQuery: Sendable, Equatable {
    public var startIndex: Int?
    public var limit: Int?
    public var userID: UUID?
    public var searchTerm: String
    public var includeItemTypes: [String]
    public var excludeItemTypes: [String]
    public var mediaTypes: [String]
    public var parentID: UUID?
    public var isMovie: Bool?
    public var isSeries: Bool?
    public var isNews: Bool?
    public var isKids: Bool?
    public var isSports: Bool?
    public var includePeople: Bool?
    public var includeMedia: Bool?
    public var includeGenres: Bool?
    public var includeStudios: Bool?
    public var includeArtists: Bool?
    public var additionalQueryItems: [URLQueryItem]

    public init(
        startIndex: Int? = nil,
        limit: Int? = nil,
        userID: UUID? = nil,
        searchTerm: String,
        includeItemTypes: [String] = [],
        excludeItemTypes: [String] = [],
        mediaTypes: [String] = [],
        parentID: UUID? = nil,
        isMovie: Bool? = nil,
        isSeries: Bool? = nil,
        isNews: Bool? = nil,
        isKids: Bool? = nil,
        isSports: Bool? = nil,
        includePeople: Bool? = nil,
        includeMedia: Bool? = nil,
        includeGenres: Bool? = nil,
        includeStudios: Bool? = nil,
        includeArtists: Bool? = nil,
        additionalQueryItems: [URLQueryItem] = []
    ) {
        self.startIndex = startIndex
        self.limit = limit
        self.userID = userID
        self.searchTerm = searchTerm
        self.includeItemTypes = includeItemTypes
        self.excludeItemTypes = excludeItemTypes
        self.mediaTypes = mediaTypes
        self.parentID = parentID
        self.isMovie = isMovie
        self.isSeries = isSeries
        self.isNews = isNews
        self.isKids = isKids
        self.isSports = isSports
        self.includePeople = includePeople
        self.includeMedia = includeMedia
        self.includeGenres = includeGenres
        self.includeStudios = includeStudios
        self.includeArtists = includeArtists
        self.additionalQueryItems = additionalQueryItems
    }
}

/// Query options for user views.
public struct UserViewsQuery: Sendable, Equatable {
    public var userID: UUID?
    public var includeExternalContent: Bool?
    public var presetViews: [String]
    public var includeHidden: Bool?
    public var additionalQueryItems: [URLQueryItem]

    public init(
        userID: UUID? = nil,
        includeExternalContent: Bool? = nil,
        presetViews: [String] = [],
        includeHidden: Bool? = nil,
        additionalQueryItems: [URLQueryItem] = []
    ) {
        self.userID = userID
        self.includeExternalContent = includeExternalContent
        self.presetViews = presetViews
        self.includeHidden = includeHidden
        self.additionalQueryItems = additionalQueryItems
    }
}

/// Query options for instant mix endpoints.
public struct InstantMixQuery: Sendable, Equatable {
    public var userID: UUID?
    public var limit: Int?
    public var fields: [String]
    public var enableImages: Bool?
    public var enableUserData: Bool?
    public var imageTypeLimit: Int?
    public var enableImageTypes: [String]
    public var additionalQueryItems: [URLQueryItem]

    public init(
        userID: UUID? = nil,
        limit: Int? = nil,
        fields: [String] = [],
        enableImages: Bool? = nil,
        enableUserData: Bool? = nil,
        imageTypeLimit: Int? = nil,
        enableImageTypes: [String] = [],
        additionalQueryItems: [URLQueryItem] = []
    ) {
        self.userID = userID
        self.limit = limit
        self.fields = fields
        self.enableImages = enableImages
        self.enableUserData = enableUserData
        self.imageTypeLimit = imageTypeLimit
        self.enableImageTypes = enableImageTypes
        self.additionalQueryItems = additionalQueryItems
    }
}

/// Query options for playlist item enumeration.
public struct PlaylistItemsQuery: Sendable, Equatable {
    public var userID: UUID?
    public var startIndex: Int?
    public var limit: Int?
    public var fields: [String]
    public var enableImages: Bool?
    public var enableUserData: Bool?
    public var imageTypeLimit: Int?
    public var enableImageTypes: [String]
    public var additionalQueryItems: [URLQueryItem]

    public init(
        userID: UUID? = nil,
        startIndex: Int? = nil,
        limit: Int? = nil,
        fields: [String] = [],
        enableImages: Bool? = nil,
        enableUserData: Bool? = nil,
        imageTypeLimit: Int? = nil,
        enableImageTypes: [String] = [],
        additionalQueryItems: [URLQueryItem] = []
    ) {
        self.userID = userID
        self.startIndex = startIndex
        self.limit = limit
        self.fields = fields
        self.enableImages = enableImages
        self.enableUserData = enableUserData
        self.imageTypeLimit = imageTypeLimit
        self.enableImageTypes = enableImageTypes
        self.additionalQueryItems = additionalQueryItems
    }
}

/// Query options for theme media endpoints.
public struct ThemeMediaQuery: Sendable, Equatable {
    public var userID: UUID?
    public var inheritFromParent: Bool?
    public var sortBy: [String]
    public var sortOrder: [String]
    public var additionalQueryItems: [URLQueryItem]

    public init(
        userID: UUID? = nil,
        inheritFromParent: Bool? = nil,
        sortBy: [String] = [],
        sortOrder: [String] = [],
        additionalQueryItems: [URLQueryItem] = []
    ) {
        self.userID = userID
        self.inheritFromParent = inheritFromParent
        self.sortBy = sortBy
        self.sortOrder = sortOrder
        self.additionalQueryItems = additionalQueryItems
    }
}

/// Aggregate item counts for a user's library.
public struct ItemCounts: Codable, Sendable, Equatable {
    public let movieCount: Int?
    public let seriesCount: Int?
    public let episodeCount: Int?
    public let artistCount: Int?
    public let programCount: Int?
    public let trailerCount: Int?
    public let songCount: Int?
    public let albumCount: Int?
    public let musicVideoCount: Int?
    public let boxSetCount: Int?
    public let bookCount: Int?
    public let itemCount: Int?

    enum CodingKeys: String, CodingKey {
        case movieCount = "MovieCount"
        case seriesCount = "SeriesCount"
        case episodeCount = "EpisodeCount"
        case artistCount = "ArtistCount"
        case programCount = "ProgramCount"
        case trailerCount = "TrailerCount"
        case songCount = "SongCount"
        case albumCount = "AlbumCount"
        case musicVideoCount = "MusicVideoCount"
        case boxSetCount = "BoxSetCount"
        case bookCount = "BookCount"
        case itemCount = "ItemCount"
    }
}

/// Search-hint query result container.
public struct SearchHintResult: Codable, Sendable, Equatable {
    public let searchHints: [SearchHint]
    public let totalRecordCount: Int

    enum CodingKeys: String, CodingKey {
        case searchHints = "SearchHints"
        case totalRecordCount = "TotalRecordCount"
    }
}

/// Partial Jellyfin search hint model.
public struct SearchHint: Codable, Sendable, Equatable {
    public let itemId: UUID?
    public let id: UUID?
    public let name: String?
    public let matchedTerm: String?
    public let indexNumber: Int?
    public let productionYear: Int?
    public let parentIndexNumber: Int?
    public let primaryImageTag: String?
    public let thumbImageTag: String?
    public let thumbImageItemId: UUID?
    public let backdropImageTag: String?
    public let backdropImageItemId: UUID?
    public let type: BaseItemKind?
    public let isFolder: Bool?
    public let runTimeTicks: Int64?
    public let mediaType: MediaType?
    public let startDate: Date?
    public let endDate: Date?
    public let series: String?
    public let status: String?
    public let album: String?
    public let albumId: UUID?
    public let albumArtist: String?
    public let artists: [String]?
    public let songCount: Int?
    public let episodeCount: Int?
    public let channelId: UUID?
    public let channelName: String?
    public let primaryImageAspectRatio: Double?

    enum CodingKeys: String, CodingKey {
        case itemId = "ItemId"
        case id = "Id"
        case name = "Name"
        case matchedTerm = "MatchedTerm"
        case indexNumber = "IndexNumber"
        case productionYear = "ProductionYear"
        case parentIndexNumber = "ParentIndexNumber"
        case primaryImageTag = "PrimaryImageTag"
        case thumbImageTag = "ThumbImageTag"
        case thumbImageItemId = "ThumbImageItemId"
        case backdropImageTag = "BackdropImageTag"
        case backdropImageItemId = "BackdropImageItemId"
        case type = "Type"
        case isFolder = "IsFolder"
        case runTimeTicks = "RunTimeTicks"
        case mediaType = "MediaType"
        case startDate = "StartDate"
        case endDate = "EndDate"
        case series = "Series"
        case status = "Status"
        case album = "Album"
        case albumId = "AlbumId"
        case albumArtist = "AlbumArtist"
        case artists = "Artists"
        case songCount = "SongCount"
        case episodeCount = "EpisodeCount"
        case channelId = "ChannelId"
        case channelName = "ChannelName"
        case primaryImageAspectRatio = "PrimaryImageAspectRatio"
    }
}

/// Partial Jellyfin per-user item data model.
public struct UserItemData: Codable, Sendable, Equatable {
    public let rating: Double?
    public let playedPercentage: Double?
    public let unplayedItemCount: Int?
    public let playbackPositionTicks: Int64?
    public let playCount: Int?
    public let isFavorite: Bool?
    public let likes: Bool?
    public let lastPlayedDate: Date?
    public let played: Bool?
    public let key: String?
    public let itemId: UUID?

    enum CodingKeys: String, CodingKey {
        case rating = "Rating"
        case playedPercentage = "PlayedPercentage"
        case unplayedItemCount = "UnplayedItemCount"
        case playbackPositionTicks = "PlaybackPositionTicks"
        case playCount = "PlayCount"
        case isFavorite = "IsFavorite"
        case likes = "Likes"
        case lastPlayedDate = "LastPlayedDate"
        case played = "Played"
        case key = "Key"
        case itemId = "ItemId"
    }

    public init(
        rating: Double? = nil,
        playedPercentage: Double? = nil,
        unplayedItemCount: Int? = nil,
        playbackPositionTicks: Int64? = nil,
        playCount: Int? = nil,
        isFavorite: Bool? = nil,
        likes: Bool? = nil,
        lastPlayedDate: Date? = nil,
        played: Bool? = nil,
        key: String? = nil,
        itemId: UUID? = nil
    ) {
        self.rating = rating
        self.playedPercentage = playedPercentage
        self.unplayedItemCount = unplayedItemCount
        self.playbackPositionTicks = playbackPositionTicks
        self.playCount = playCount
        self.isFavorite = isFavorite
        self.likes = likes
        self.lastPlayedDate = lastPlayedDate
        self.played = played
        self.key = key
        self.itemId = itemId
    }
}

/// Legacy library query-filter response.
public struct QueryFiltersLegacy: Codable, Sendable, Equatable {
    public let genres: [String]?
    public let tags: [String]?
    public let officialRatings: [String]?
    public let years: [Int]?

    enum CodingKeys: String, CodingKey {
        case genres = "Genres"
        case tags = "Tags"
        case officialRatings = "OfficialRatings"
        case years = "Years"
    }
}

/// Modern library query-filter response.
public struct QueryFilters: Codable, Sendable, Equatable {
    public let genres: [NameGuidPair]?
    public let tags: [String]?

    enum CodingKeys: String, CodingKey {
        case genres = "Genres"
        case tags = "Tags"
    }
}

/// Name + identifier pair used by filter responses.
public struct NameGuidPair: Codable, Sendable, Equatable {
    public let name: String?
    public let id: UUID?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case id = "Id"
    }
}

/// Collection creation result.
public struct CollectionCreationResult: Codable, Sendable, Equatable {
    public let id: UUID

    enum CodingKeys: String, CodingKey {
        case id = "Id"
    }
}

/// Playlist creation result.
public struct PlaylistCreationResult: Codable, Sendable, Equatable {
    public let id: UUID

    enum CodingKeys: String, CodingKey {
        case id = "Id"
    }
}

/// Partial Jellyfin playlist model.
public struct Playlist: Codable, Sendable, Equatable {
    public let openAccess: Bool?
    public let shares: [PlaylistUserPermission]?
    public let itemIds: [UUID]?

    enum CodingKeys: String, CodingKey {
        case openAccess = "OpenAccess"
        case shares = "Shares"
        case itemIds = "ItemIds"
    }
}

/// Playlist sharing permissions for a single user.
public struct PlaylistUserPermission: Codable, Sendable, Equatable {
    public let userId: UUID?
    public let canEdit: Bool?

    enum CodingKeys: String, CodingKey {
        case userId = "UserId"
        case canEdit = "CanEdit"
    }

    public init(userId: UUID? = nil, canEdit: Bool? = nil) {
        self.userId = userId
        self.canEdit = canEdit
    }
}

/// Request body for playlist creation.
public struct CreatePlaylistRequest: Codable, Sendable, Equatable {
    public let name: String?
    public let ids: [UUID]
    public let userId: UUID?
    public let mediaType: MediaType?
    public let users: [PlaylistUserPermission]
    public let isPublic: Bool?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case ids = "Ids"
        case userId = "UserId"
        case mediaType = "MediaType"
        case users = "Users"
        case isPublic = "IsPublic"
    }

    public init(
        name: String? = nil,
        ids: [UUID] = [],
        userId: UUID? = nil,
        mediaType: MediaType? = nil,
        users: [PlaylistUserPermission] = [],
        isPublic: Bool? = nil
    ) {
        self.name = name
        self.ids = ids
        self.userId = userId
        self.mediaType = mediaType
        self.users = users
        self.isPublic = isPublic
    }
}

/// Request body for playlist updates.
public struct UpdatePlaylistRequest: Codable, Sendable, Equatable {
    public let name: String?
    public let ids: [UUID]
    public let users: [PlaylistUserPermission]
    public let isPublic: Bool?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case ids = "Ids"
        case users = "Users"
        case isPublic = "IsPublic"
    }

    public init(
        name: String? = nil,
        ids: [UUID] = [],
        users: [PlaylistUserPermission] = [],
        isPublic: Bool? = nil
    ) {
        self.name = name
        self.ids = ids
        self.users = users
        self.isPublic = isPublic
    }
}

/// Request body for a playlist-user permission update.
public struct UpdatePlaylistUserRequest: Codable, Sendable, Equatable {
    public let canEdit: Bool?

    enum CodingKeys: String, CodingKey {
        case canEdit = "CanEdit"
    }

    public init(canEdit: Bool? = nil) {
        self.canEdit = canEdit
    }
}

/// Grouping option for user views.
public struct SpecialViewOption: Codable, Sendable, Equatable {
    public let name: String?
    public let id: String?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case id = "Id"
    }
}

/// Option metadata used by library configuration endpoints.
public struct LibraryOptionInfo: Codable, Sendable, Equatable {
    public let name: String?
    public let defaultEnabled: Bool?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case defaultEnabled = "DefaultEnabled"
    }
}

/// Per-library-type option metadata.
public struct LibraryTypeOption: Codable, Sendable, Equatable {
    public let type: String?
    public let metadataFetchers: [LibraryOptionInfo]?
    public let imageFetchers: [LibraryOptionInfo]?

    enum CodingKeys: String, CodingKey {
        case type = "Type"
        case metadataFetchers = "MetadataFetchers"
        case imageFetchers = "ImageFetchers"
    }
}

/// Library option inventory response.
public struct LibraryOptionsResult: Codable, Sendable, Equatable {
    public let metadataSavers: [LibraryOptionInfo]?
    public let metadataReaders: [LibraryOptionInfo]?
    public let subtitleFetchers: [LibraryOptionInfo]?
    public let lyricFetchers: [LibraryOptionInfo]?
    public let mediaSegmentProviders: [LibraryOptionInfo]?
    public let typeOptions: [LibraryTypeOption]?

    enum CodingKeys: String, CodingKey {
        case metadataSavers = "MetadataSavers"
        case metadataReaders = "MetadataReaders"
        case subtitleFetchers = "SubtitleFetchers"
        case lyricFetchers = "LyricFetchers"
        case mediaSegmentProviders = "MediaSegmentProviders"
        case typeOptions = "TypeOptions"
    }
}

/// Minimal library options model shared by virtual-folder endpoints.
public struct LibraryOptions: Codable, Sendable, Equatable {
    public let enabled: Bool?
    public let enablePhotos: Bool?
    public let enableRealtimeMonitor: Bool?
    public let preferredMetadataLanguage: String?
    public let metadataCountryCode: String?
    public let metadataSavers: [String]?
    public let subtitleDownloadLanguages: [String]?
    public let saveSubtitlesWithMedia: Bool?
    public let saveLyricsWithMedia: Bool?
    public let saveTrickplayWithMedia: Bool?
    public let pathInfos: [MediaPathInfo]?

    enum CodingKeys: String, CodingKey {
        case enabled = "Enabled"
        case enablePhotos = "EnablePhotos"
        case enableRealtimeMonitor = "EnableRealtimeMonitor"
        case preferredMetadataLanguage = "PreferredMetadataLanguage"
        case metadataCountryCode = "MetadataCountryCode"
        case metadataSavers = "MetadataSavers"
        case subtitleDownloadLanguages = "SubtitleDownloadLanguages"
        case saveSubtitlesWithMedia = "SaveSubtitlesWithMedia"
        case saveLyricsWithMedia = "SaveLyricsWithMedia"
        case saveTrickplayWithMedia = "SaveTrickplayWithMedia"
        case pathInfos = "PathInfos"
    }

    public init(
        enabled: Bool? = nil,
        enablePhotos: Bool? = nil,
        enableRealtimeMonitor: Bool? = nil,
        preferredMetadataLanguage: String? = nil,
        metadataCountryCode: String? = nil,
        metadataSavers: [String]? = nil,
        subtitleDownloadLanguages: [String]? = nil,
        saveSubtitlesWithMedia: Bool? = nil,
        saveLyricsWithMedia: Bool? = nil,
        saveTrickplayWithMedia: Bool? = nil,
        pathInfos: [MediaPathInfo]? = nil
    ) {
        self.enabled = enabled
        self.enablePhotos = enablePhotos
        self.enableRealtimeMonitor = enableRealtimeMonitor
        self.preferredMetadataLanguage = preferredMetadataLanguage
        self.metadataCountryCode = metadataCountryCode
        self.metadataSavers = metadataSavers
        self.subtitleDownloadLanguages = subtitleDownloadLanguages
        self.saveSubtitlesWithMedia = saveSubtitlesWithMedia
        self.saveLyricsWithMedia = saveLyricsWithMedia
        self.saveTrickplayWithMedia = saveTrickplayWithMedia
        self.pathInfos = pathInfos
    }
}

/// Virtual folder summary.
public struct VirtualFolderInfo: Codable, Sendable, Equatable {
    public let name: String?
    public let locations: [String]?
    public let collectionType: CollectionType?
    public let libraryOptions: LibraryOptions?
    public let itemId: UUID?
    public let primaryImageItemId: UUID?
    public let refreshProgress: Double?
    public let refreshStatus: String?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case locations = "Locations"
        case collectionType = "CollectionType"
        case libraryOptions = "LibraryOptions"
        case itemId = "ItemId"
        case primaryImageItemId = "PrimaryImageItemId"
        case refreshProgress = "RefreshProgress"
        case refreshStatus = "RefreshStatus"
    }
}

/// Media path info wrapper used by library structure endpoints.
public struct MediaPathInfo: Codable, Sendable, Equatable {
    public let path: String?

    enum CodingKeys: String, CodingKey {
        case path = "Path"
    }

    public init(path: String? = nil) {
        self.path = path
    }
}

/// Request body for virtual-folder creation.
public struct AddVirtualFolderRequest: Codable, Sendable, Equatable {
    public let libraryOptions: LibraryOptions?

    enum CodingKeys: String, CodingKey {
        case libraryOptions = "LibraryOptions"
    }

    public init(libraryOptions: LibraryOptions? = nil) {
        self.libraryOptions = libraryOptions
    }
}

/// Request body for library-option updates.
public struct UpdateLibraryOptionsRequest: Codable, Sendable, Equatable {
    public let id: String?
    public let libraryOptions: LibraryOptions?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case libraryOptions = "LibraryOptions"
    }

    public init(id: String? = nil, libraryOptions: LibraryOptions? = nil) {
        self.id = id
        self.libraryOptions = libraryOptions
    }
}

/// Request body for adding a media path.
public struct MediaPathRequest: Codable, Sendable, Equatable {
    public let name: String?
    public let path: String?
    public let pathInfo: MediaPathInfo?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case path = "Path"
        case pathInfo = "PathInfo"
    }

    public init(name: String? = nil, path: String? = nil, pathInfo: MediaPathInfo? = nil) {
        self.name = name
        self.path = path
        self.pathInfo = pathInfo
    }
}

/// Request body for updating a media path.
public struct UpdateMediaPathRequest: Codable, Sendable, Equatable {
    public let name: String?
    public let pathInfo: MediaPathInfo?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case pathInfo = "PathInfo"
    }

    public init(name: String? = nil, pathInfo: MediaPathInfo? = nil) {
        self.name = name
        self.pathInfo = pathInfo
    }
}

/// Theme media query result container.
public struct ThemeMediaResult: Codable, Sendable, Equatable {
    public let items: [BaseItem]
    public let totalRecordCount: Int
    public let startIndex: Int
    public let ownerId: UUID?

    enum CodingKeys: String, CodingKey {
        case items = "Items"
        case totalRecordCount = "TotalRecordCount"
        case startIndex = "StartIndex"
        case ownerId = "OwnerId"
    }
}

/// Combined theme media response.
public struct AllThemeMediaResult: Codable, Sendable, Equatable {
    public let themeVideosResult: ThemeMediaResult?
    public let themeSongsResult: ThemeMediaResult?
    public let soundtrackSongsResult: ThemeMediaResult?

    enum CodingKeys: String, CodingKey {
        case themeVideosResult = "ThemeVideosResult"
        case themeSongsResult = "ThemeSongsResult"
        case soundtrackSongsResult = "SoundtrackSongsResult"
    }
}

/// Media-update notification body.
public struct MediaUpdateInfo: Codable, Sendable, Equatable {
    public let updates: [MediaUpdatePath]

    enum CodingKeys: String, CodingKey {
        case updates = "Updates"
    }

    public init(updates: [MediaUpdatePath]) {
        self.updates = updates
    }
}

/// Single path update entry for media-update notifications.
public struct MediaUpdatePath: Codable, Sendable, Equatable {
    public let path: String?
    public let updateType: String?

    enum CodingKeys: String, CodingKey {
        case path = "Path"
        case updateType = "UpdateType"
    }

    public init(path: String? = nil, updateType: String? = nil) {
        self.path = path
        self.updateType = updateType
    }
}
