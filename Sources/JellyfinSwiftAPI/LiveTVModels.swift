import Foundation

/// Query options for `/Channels`.
public struct ChannelBrowseQuery: Sendable, Equatable {
    public let userID: UUID?
    public let startIndex: Int?
    public let limit: Int?
    public let supportsLatestItems: Bool?
    public let supportsMediaDeletion: Bool?
    public let isFavorite: Bool?

    public init(
        userID: UUID? = nil,
        startIndex: Int? = nil,
        limit: Int? = nil,
        supportsLatestItems: Bool? = nil,
        supportsMediaDeletion: Bool? = nil,
        isFavorite: Bool? = nil
    ) {
        self.userID = userID
        self.startIndex = startIndex
        self.limit = limit
        self.supportsLatestItems = supportsLatestItems
        self.supportsMediaDeletion = supportsMediaDeletion
        self.isFavorite = isFavorite
    }
}

/// Query options for `/Channels/{channelId}/Items`.
public struct ChannelItemsQuery: Sendable, Equatable {
    public let folderID: String?
    public let userID: UUID?
    public let startIndex: Int?
    public let limit: Int?
    public let sortOrder: [SortOrder]
    public let filters: [String]
    public let sortBy: [String]
    public let fields: [String]

    public init(
        folderID: String? = nil,
        userID: UUID? = nil,
        startIndex: Int? = nil,
        limit: Int? = nil,
        sortOrder: [SortOrder] = [],
        filters: [String] = [],
        sortBy: [String] = [],
        fields: [String] = []
    ) {
        self.folderID = folderID
        self.userID = userID
        self.startIndex = startIndex
        self.limit = limit
        self.sortOrder = sortOrder
        self.filters = filters
        self.sortBy = sortBy
        self.fields = fields
    }
}

/// Query options for `/Channels/Items/Latest`.
public struct LatestChannelItemsQuery: Sendable, Equatable {
    public let userID: UUID?
    public let startIndex: Int?
    public let limit: Int?
    public let filters: [String]
    public let fields: [String]
    public let channelIDs: [String]

    public init(
        userID: UUID? = nil,
        startIndex: Int? = nil,
        limit: Int? = nil,
        filters: [String] = [],
        fields: [String] = [],
        channelIDs: [String] = []
    ) {
        self.userID = userID
        self.startIndex = startIndex
        self.limit = limit
        self.filters = filters
        self.fields = fields
        self.channelIDs = channelIDs
    }
}

/// Query options for `/LiveTv/Channels`.
public struct LiveTVChannelsQuery: Sendable, Equatable {
    public let type: String?
    public let userID: UUID?
    public let startIndex: Int?
    public let limit: Int?
    public let isMovie: Bool?
    public let isSeries: Bool?
    public let isNews: Bool?
    public let isKids: Bool?
    public let isSports: Bool?
    public let isFavorite: Bool?
    public let isLiked: Bool?
    public let isDisliked: Bool?
    public let enableImages: Bool?
    public let imageTypeLimit: Int?
    public let enableImageTypes: [ImageType]
    public let fields: [String]
    public let enableUserData: Bool?
    public let sortBy: [String]
    public let sortOrder: [SortOrder]
    public let enableFavoriteSorting: Bool?
    public let addCurrentProgram: Bool?

    public init(
        type: String? = nil,
        userID: UUID? = nil,
        startIndex: Int? = nil,
        limit: Int? = nil,
        isMovie: Bool? = nil,
        isSeries: Bool? = nil,
        isNews: Bool? = nil,
        isKids: Bool? = nil,
        isSports: Bool? = nil,
        isFavorite: Bool? = nil,
        isLiked: Bool? = nil,
        isDisliked: Bool? = nil,
        enableImages: Bool? = nil,
        imageTypeLimit: Int? = nil,
        enableImageTypes: [ImageType] = [],
        fields: [String] = [],
        enableUserData: Bool? = nil,
        sortBy: [String] = [],
        sortOrder: [SortOrder] = [],
        enableFavoriteSorting: Bool? = nil,
        addCurrentProgram: Bool? = nil
    ) {
        self.type = type
        self.userID = userID
        self.startIndex = startIndex
        self.limit = limit
        self.isMovie = isMovie
        self.isSeries = isSeries
        self.isNews = isNews
        self.isKids = isKids
        self.isSports = isSports
        self.isFavorite = isFavorite
        self.isLiked = isLiked
        self.isDisliked = isDisliked
        self.enableImages = enableImages
        self.imageTypeLimit = imageTypeLimit
        self.enableImageTypes = enableImageTypes
        self.fields = fields
        self.enableUserData = enableUserData
        self.sortBy = sortBy
        self.sortOrder = sortOrder
        self.enableFavoriteSorting = enableFavoriteSorting
        self.addCurrentProgram = addCurrentProgram
    }
}

/// Query/body model for live TV program lookup.
public struct ProgramsQuery: Codable, Sendable, Equatable {
    public let channelIDs: [String]
    public let userID: UUID?
    public let minStartDate: Date?
    public let hasAired: Bool?
    public let isAiring: Bool?
    public let maxStartDate: Date?
    public let minEndDate: Date?
    public let maxEndDate: Date?
    public let isMovie: Bool?
    public let isSeries: Bool?
    public let isNews: Bool?
    public let isKids: Bool?
    public let isSports: Bool?
    public let startIndex: Int?
    public let limit: Int?
    public let sortBy: [String]
    public let sortOrder: [SortOrder]
    public let genres: [String]
    public let genreIDs: [String]
    public let enableImages: Bool?
    public let imageTypeLimit: Int?
    public let enableImageTypes: [ImageType]
    public let enableUserData: Bool?
    public let seriesTimerID: String?
    public let librarySeriesID: String?
    public let fields: [String]
    public let enableTotalRecordCount: Bool?

    enum CodingKeys: String, CodingKey {
        case channelIDs = "ChannelIDs"
        case userID = "UserID"
        case minStartDate = "MinStartDate"
        case hasAired = "HasAired"
        case isAiring = "IsAiring"
        case maxStartDate = "MaxStartDate"
        case minEndDate = "MinEndDate"
        case maxEndDate = "MaxEndDate"
        case isMovie = "IsMovie"
        case isSeries = "IsSeries"
        case isNews = "IsNews"
        case isKids = "IsKids"
        case isSports = "IsSports"
        case startIndex = "StartIndex"
        case limit = "Limit"
        case sortBy = "SortBy"
        case sortOrder = "SortOrder"
        case genres = "Genres"
        case genreIDs = "GenreIDs"
        case enableImages = "EnableImages"
        case imageTypeLimit = "ImageTypeLimit"
        case enableImageTypes = "EnableImageTypes"
        case enableUserData = "EnableUserData"
        case seriesTimerID = "SeriesTimerID"
        case librarySeriesID = "LibrarySeriesID"
        case fields = "Fields"
        case enableTotalRecordCount = "EnableTotalRecordCount"
    }

    public init(
        channelIDs: [String] = [],
        userID: UUID? = nil,
        minStartDate: Date? = nil,
        hasAired: Bool? = nil,
        isAiring: Bool? = nil,
        maxStartDate: Date? = nil,
        minEndDate: Date? = nil,
        maxEndDate: Date? = nil,
        isMovie: Bool? = nil,
        isSeries: Bool? = nil,
        isNews: Bool? = nil,
        isKids: Bool? = nil,
        isSports: Bool? = nil,
        startIndex: Int? = nil,
        limit: Int? = nil,
        sortBy: [String] = [],
        sortOrder: [SortOrder] = [],
        genres: [String] = [],
        genreIDs: [String] = [],
        enableImages: Bool? = nil,
        imageTypeLimit: Int? = nil,
        enableImageTypes: [ImageType] = [],
        enableUserData: Bool? = nil,
        seriesTimerID: String? = nil,
        librarySeriesID: String? = nil,
        fields: [String] = [],
        enableTotalRecordCount: Bool? = nil
    ) {
        self.channelIDs = channelIDs
        self.userID = userID
        self.minStartDate = minStartDate
        self.hasAired = hasAired
        self.isAiring = isAiring
        self.maxStartDate = maxStartDate
        self.minEndDate = minEndDate
        self.maxEndDate = maxEndDate
        self.isMovie = isMovie
        self.isSeries = isSeries
        self.isNews = isNews
        self.isKids = isKids
        self.isSports = isSports
        self.startIndex = startIndex
        self.limit = limit
        self.sortBy = sortBy
        self.sortOrder = sortOrder
        self.genres = genres
        self.genreIDs = genreIDs
        self.enableImages = enableImages
        self.imageTypeLimit = imageTypeLimit
        self.enableImageTypes = enableImageTypes
        self.enableUserData = enableUserData
        self.seriesTimerID = seriesTimerID
        self.librarySeriesID = librarySeriesID
        self.fields = fields
        self.enableTotalRecordCount = enableTotalRecordCount
    }
}

/// Query options for recommended programs.
public struct RecommendedProgramsQuery: Sendable, Equatable {
    public let userID: UUID?
    public let startIndex: Int?
    public let limit: Int?
    public let isAiring: Bool?
    public let hasAired: Bool?
    public let isSeries: Bool?
    public let isMovie: Bool?
    public let isNews: Bool?
    public let isKids: Bool?
    public let isSports: Bool?
    public let enableImages: Bool?
    public let imageTypeLimit: Int?
    public let enableImageTypes: [ImageType]
    public let genreIDs: [String]
    public let fields: [String]
    public let enableUserData: Bool?
    public let enableTotalRecordCount: Bool?

    public init(
        userID: UUID? = nil,
        startIndex: Int? = nil,
        limit: Int? = nil,
        isAiring: Bool? = nil,
        hasAired: Bool? = nil,
        isSeries: Bool? = nil,
        isMovie: Bool? = nil,
        isNews: Bool? = nil,
        isKids: Bool? = nil,
        isSports: Bool? = nil,
        enableImages: Bool? = nil,
        imageTypeLimit: Int? = nil,
        enableImageTypes: [ImageType] = [],
        genreIDs: [String] = [],
        fields: [String] = [],
        enableUserData: Bool? = nil,
        enableTotalRecordCount: Bool? = nil
    ) {
        self.userID = userID
        self.startIndex = startIndex
        self.limit = limit
        self.isAiring = isAiring
        self.hasAired = hasAired
        self.isSeries = isSeries
        self.isMovie = isMovie
        self.isNews = isNews
        self.isKids = isKids
        self.isSports = isSports
        self.enableImages = enableImages
        self.imageTypeLimit = imageTypeLimit
        self.enableImageTypes = enableImageTypes
        self.genreIDs = genreIDs
        self.fields = fields
        self.enableUserData = enableUserData
        self.enableTotalRecordCount = enableTotalRecordCount
    }
}

/// Query options for recordings endpoints.
public struct RecordingsQuery: Sendable, Equatable {
    public let channelID: String?
    public let userID: UUID?
    public let groupID: String?
    public let startIndex: Int?
    public let limit: Int?
    public let status: String?
    public let isInProgress: Bool?
    public let seriesTimerID: String?
    public let enableImages: Bool?
    public let imageTypeLimit: Int?
    public let enableImageTypes: [ImageType]
    public let fields: [String]
    public let enableUserData: Bool?
    public let isMovie: Bool?
    public let isSeries: Bool?
    public let isKids: Bool?
    public let isSports: Bool?
    public let isNews: Bool?
    public let isLibraryItem: Bool?
    public let enableTotalRecordCount: Bool?

    public init(
        channelID: String? = nil,
        userID: UUID? = nil,
        groupID: String? = nil,
        startIndex: Int? = nil,
        limit: Int? = nil,
        status: String? = nil,
        isInProgress: Bool? = nil,
        seriesTimerID: String? = nil,
        enableImages: Bool? = nil,
        imageTypeLimit: Int? = nil,
        enableImageTypes: [ImageType] = [],
        fields: [String] = [],
        enableUserData: Bool? = nil,
        isMovie: Bool? = nil,
        isSeries: Bool? = nil,
        isKids: Bool? = nil,
        isSports: Bool? = nil,
        isNews: Bool? = nil,
        isLibraryItem: Bool? = nil,
        enableTotalRecordCount: Bool? = nil
    ) {
        self.channelID = channelID
        self.userID = userID
        self.groupID = groupID
        self.startIndex = startIndex
        self.limit = limit
        self.status = status
        self.isInProgress = isInProgress
        self.seriesTimerID = seriesTimerID
        self.enableImages = enableImages
        self.imageTypeLimit = imageTypeLimit
        self.enableImageTypes = enableImageTypes
        self.fields = fields
        self.enableUserData = enableUserData
        self.isMovie = isMovie
        self.isSeries = isSeries
        self.isKids = isKids
        self.isSports = isSports
        self.isNews = isNews
        self.isLibraryItem = isLibraryItem
        self.enableTotalRecordCount = enableTotalRecordCount
    }
}

/// Channel feature metadata.
public struct ChannelFeatures: Codable, Sendable, Equatable {
    public let name: String?
    public let id: String?
    public let canSearch: Bool?
    public let mediaTypes: [String]?
    public let contentTypes: [String]?
    public let maxPageSize: Int?
    public let autoRefreshLevels: Int?
    public let defaultSortFields: [String]?
    public let supportsSortOrderToggle: Bool?
    public let supportsLatestMedia: Bool?
    public let canFilter: Bool?
    public let supportsContentDownloading: Bool?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case id = "Id"
        case canSearch = "CanSearch"
        case mediaTypes = "MediaTypes"
        case contentTypes = "ContentTypes"
        case maxPageSize = "MaxPageSize"
        case autoRefreshLevels = "AutoRefreshLevels"
        case defaultSortFields = "DefaultSortFields"
        case supportsSortOrderToggle = "SupportsSortOrderToggle"
        case supportsLatestMedia = "SupportsLatestMedia"
        case canFilter = "CanFilter"
        case supportsContentDownloading = "SupportsContentDownloading"
    }
}

/// Channel mapping options.
public struct ChannelMappingOptions: Codable, Sendable, Equatable {
    public let tunerChannels: [TunerChannelMapping]
    public let providerChannels: [NameIDPair]
    public let mappings: [NameValuePair]
    public let providerName: String?

    enum CodingKeys: String, CodingKey {
        case tunerChannels = "TunerChannels"
        case providerChannels = "ProviderChannels"
        case mappings = "Mappings"
        case providerName = "ProviderName"
    }
}

/// Request body for setting a channel mapping.
public struct SetChannelMappingRequest: Codable, Sendable, Equatable {
    public let providerId: String?
    public let tunerChannelId: String?
    public let providerChannelId: String?

    enum CodingKeys: String, CodingKey {
        case providerId = "ProviderId"
        case tunerChannelId = "TunerChannelId"
        case providerChannelId = "ProviderChannelId"
    }

    public init(providerId: String? = nil, tunerChannelId: String? = nil, providerChannelId: String? = nil) {
        self.providerId = providerId
        self.tunerChannelId = tunerChannelId
        self.providerChannelId = providerChannelId
    }
}

/// A tuner-to-provider channel mapping.
public struct TunerChannelMapping: Codable, Sendable, Equatable {
    public let name: String?
    public let providerChannelName: String?
    public let providerChannelId: String?
    public let id: String?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case providerChannelName = "ProviderChannelName"
        case providerChannelId = "ProviderChannelId"
        case id = "Id"
    }
}

/// Aggregate Live TV state.
public struct LiveTVInfo: Codable, Sendable, Equatable {
    public let services: [LiveTVServiceInfo]
    public let isEnabled: Bool?
    public let enabledUsers: [String]?

    enum CodingKeys: String, CodingKey {
        case services = "Services"
        case isEnabled = "IsEnabled"
        case enabledUsers = "EnabledUsers"
    }
}

/// One Live TV backend status entry.
public struct LiveTVServiceInfo: Codable, Sendable, Equatable {
    public let name: String?
    public let homePageUrl: String?
    public let status: String?
    public let statusMessage: String?
    public let version: String?
    public let hasUpdateAvailable: Bool?
    public let isVisible: Bool?
    public let tuners: [String]?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case homePageUrl = "HomePageUrl"
        case status = "Status"
        case statusMessage = "StatusMessage"
        case version = "Version"
        case hasUpdateAvailable = "HasUpdateAvailable"
        case isVisible = "IsVisible"
        case tuners = "Tuners"
    }
}

/// Guide range summary.
public struct GuideInfo: Codable, Sendable, Equatable {
    public let startDate: Date?
    public let endDate: Date?

    enum CodingKeys: String, CodingKey {
        case startDate = "StartDate"
        case endDate = "EndDate"
    }
}

/// Listings provider configuration.
public struct ListingsProvider: Codable, Sendable, Equatable {
    public let id: String?
    public let type: String?
    public let username: String?
    public let password: String?
    public let listingsId: String?
    public let zipCode: String?
    public let country: String?
    public let path: String?
    public let enabledTuners: [String]?
    public let enableAllTuners: Bool?
    public let preferredLanguage: String?
    public let userAgent: String?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case type = "Type"
        case username = "Username"
        case password = "Password"
        case listingsId = "ListingsId"
        case zipCode = "ZipCode"
        case country = "Country"
        case path = "Path"
        case enabledTuners = "EnabledTuners"
        case enableAllTuners = "EnableAllTuners"
        case preferredLanguage = "PreferredLanguage"
        case userAgent = "UserAgent"
    }

    public init(
        id: String? = nil,
        type: String? = nil,
        username: String? = nil,
        password: String? = nil,
        listingsId: String? = nil,
        zipCode: String? = nil,
        country: String? = nil,
        path: String? = nil,
        enabledTuners: [String]? = nil,
        enableAllTuners: Bool? = nil,
        preferredLanguage: String? = nil,
        userAgent: String? = nil
    ) {
        self.id = id
        self.type = type
        self.username = username
        self.password = password
        self.listingsId = listingsId
        self.zipCode = zipCode
        self.country = country
        self.path = path
        self.enabledTuners = enabledTuners
        self.enableAllTuners = enableAllTuners
        self.preferredLanguage = preferredLanguage
        self.userAgent = userAgent
    }
}

/// Timer information.
public struct TimerInfo: Codable, Sendable, Equatable {
    public let id: String?
    public let type: String?
    public let channelId: String?
    public let channelName: String?
    public let programId: String?
    public let name: String?
    public let overview: String?
    public let startDate: Date?
    public let endDate: Date?
    public let serviceName: String?
    public let priority: Int?
    public let prePaddingSeconds: Int?
    public let postPaddingSeconds: Int?
    public let keepUntil: KeepUntil?
    public let status: RecordingStatus?
    public let seriesTimerId: String?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case type = "Type"
        case channelId = "ChannelId"
        case channelName = "ChannelName"
        case programId = "ProgramId"
        case name = "Name"
        case overview = "Overview"
        case startDate = "StartDate"
        case endDate = "EndDate"
        case serviceName = "ServiceName"
        case priority = "Priority"
        case prePaddingSeconds = "PrePaddingSeconds"
        case postPaddingSeconds = "PostPaddingSeconds"
        case keepUntil = "KeepUntil"
        case status = "Status"
        case seriesTimerId = "SeriesTimerId"
    }

    public init(
        id: String? = nil,
        type: String? = nil,
        channelId: String? = nil,
        channelName: String? = nil,
        programId: String? = nil,
        name: String? = nil,
        overview: String? = nil,
        startDate: Date? = nil,
        endDate: Date? = nil,
        serviceName: String? = nil,
        priority: Int? = nil,
        prePaddingSeconds: Int? = nil,
        postPaddingSeconds: Int? = nil,
        keepUntil: KeepUntil? = nil,
        status: RecordingStatus? = nil,
        seriesTimerId: String? = nil
    ) {
        self.id = id
        self.type = type
        self.channelId = channelId
        self.channelName = channelName
        self.programId = programId
        self.name = name
        self.overview = overview
        self.startDate = startDate
        self.endDate = endDate
        self.serviceName = serviceName
        self.priority = priority
        self.prePaddingSeconds = prePaddingSeconds
        self.postPaddingSeconds = postPaddingSeconds
        self.keepUntil = keepUntil
        self.status = status
        self.seriesTimerId = seriesTimerId
    }
}

/// Series timer information.
public struct SeriesTimerInfo: Codable, Sendable, Equatable {
    public let id: String?
    public let type: String?
    public let channelId: String?
    public let channelName: String?
    public let programId: String?
    public let name: String?
    public let overview: String?
    public let startDate: Date?
    public let endDate: Date?
    public let serviceName: String?
    public let priority: Int?
    public let prePaddingSeconds: Int?
    public let postPaddingSeconds: Int?
    public let keepUntil: KeepUntil?
    public let recordAnyTime: Bool?
    public let skipEpisodesInLibrary: Bool?
    public let recordAnyChannel: Bool?
    public let keepUpTo: Int?
    public let recordNewOnly: Bool?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case type = "Type"
        case channelId = "ChannelId"
        case channelName = "ChannelName"
        case programId = "ProgramId"
        case name = "Name"
        case overview = "Overview"
        case startDate = "StartDate"
        case endDate = "EndDate"
        case serviceName = "ServiceName"
        case priority = "Priority"
        case prePaddingSeconds = "PrePaddingSeconds"
        case postPaddingSeconds = "PostPaddingSeconds"
        case keepUntil = "KeepUntil"
        case recordAnyTime = "RecordAnyTime"
        case skipEpisodesInLibrary = "SkipEpisodesInLibrary"
        case recordAnyChannel = "RecordAnyChannel"
        case keepUpTo = "KeepUpTo"
        case recordNewOnly = "RecordNewOnly"
    }

    public init(
        id: String? = nil,
        type: String? = nil,
        channelId: String? = nil,
        channelName: String? = nil,
        programId: String? = nil,
        name: String? = nil,
        overview: String? = nil,
        startDate: Date? = nil,
        endDate: Date? = nil,
        serviceName: String? = nil,
        priority: Int? = nil,
        prePaddingSeconds: Int? = nil,
        postPaddingSeconds: Int? = nil,
        keepUntil: KeepUntil? = nil,
        recordAnyTime: Bool? = nil,
        skipEpisodesInLibrary: Bool? = nil,
        recordAnyChannel: Bool? = nil,
        keepUpTo: Int? = nil,
        recordNewOnly: Bool? = nil
    ) {
        self.id = id
        self.type = type
        self.channelId = channelId
        self.channelName = channelName
        self.programId = programId
        self.name = name
        self.overview = overview
        self.startDate = startDate
        self.endDate = endDate
        self.serviceName = serviceName
        self.priority = priority
        self.prePaddingSeconds = prePaddingSeconds
        self.postPaddingSeconds = postPaddingSeconds
        self.keepUntil = keepUntil
        self.recordAnyTime = recordAnyTime
        self.skipEpisodesInLibrary = skipEpisodesInLibrary
        self.recordAnyChannel = recordAnyChannel
        self.keepUpTo = keepUpTo
        self.recordNewOnly = recordNewOnly
    }
}

/// Timer query result wrapper.
public struct TimerQueryResult: Codable, Sendable, Equatable {
    public let items: [TimerInfo]
    public let totalRecordCount: Int?
    public let startIndex: Int?

    enum CodingKeys: String, CodingKey {
        case items = "Items"
        case totalRecordCount = "TotalRecordCount"
        case startIndex = "StartIndex"
    }
}

/// Series timer query result wrapper.
public struct SeriesTimerQueryResult: Codable, Sendable, Equatable {
    public let items: [SeriesTimerInfo]
    public let totalRecordCount: Int?
    public let startIndex: Int?

    enum CodingKeys: String, CodingKey {
        case items = "Items"
        case totalRecordCount = "TotalRecordCount"
        case startIndex = "StartIndex"
    }
}

/// Tuner host configuration.
public struct TunerHost: Codable, Sendable, Equatable {
    public let id: String?
    public let url: String?
    public let type: String?
    public let deviceId: String?
    public let friendlyName: String?
    public let importFavoritesOnly: Bool?
    public let allowHWTranscoding: Bool?
    public let allowFmp4TranscodingContainer: Bool?
    public let allowStreamSharing: Bool?
    public let fallbackMaxStreamingBitrate: Int?
    public let enableStreamLooping: Bool?
    public let source: String?
    public let tunerCount: Int?
    public let userAgent: String?
    public let ignoreDts: Bool?
    public let readAtNativeFramerate: Bool?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case url = "Url"
        case type = "Type"
        case deviceId = "DeviceId"
        case friendlyName = "FriendlyName"
        case importFavoritesOnly = "ImportFavoritesOnly"
        case allowHWTranscoding = "AllowHWTranscoding"
        case allowFmp4TranscodingContainer = "AllowFmp4TranscodingContainer"
        case allowStreamSharing = "AllowStreamSharing"
        case fallbackMaxStreamingBitrate = "FallbackMaxStreamingBitrate"
        case enableStreamLooping = "EnableStreamLooping"
        case source = "Source"
        case tunerCount = "TunerCount"
        case userAgent = "UserAgent"
        case ignoreDts = "IgnoreDts"
        case readAtNativeFramerate = "ReadAtNativeFramerate"
    }

    public init(
        id: String? = nil,
        url: String? = nil,
        type: String? = nil,
        deviceId: String? = nil,
        friendlyName: String? = nil,
        importFavoritesOnly: Bool? = nil,
        allowHWTranscoding: Bool? = nil,
        allowFmp4TranscodingContainer: Bool? = nil,
        allowStreamSharing: Bool? = nil,
        fallbackMaxStreamingBitrate: Int? = nil,
        enableStreamLooping: Bool? = nil,
        source: String? = nil,
        tunerCount: Int? = nil,
        userAgent: String? = nil,
        ignoreDts: Bool? = nil,
        readAtNativeFramerate: Bool? = nil
    ) {
        self.id = id
        self.url = url
        self.type = type
        self.deviceId = deviceId
        self.friendlyName = friendlyName
        self.importFavoritesOnly = importFavoritesOnly
        self.allowHWTranscoding = allowHWTranscoding
        self.allowFmp4TranscodingContainer = allowFmp4TranscodingContainer
        self.allowStreamSharing = allowStreamSharing
        self.fallbackMaxStreamingBitrate = fallbackMaxStreamingBitrate
        self.enableStreamLooping = enableStreamLooping
        self.source = source
        self.tunerCount = tunerCount
        self.userAgent = userAgent
        self.ignoreDts = ignoreDts
        self.readAtNativeFramerate = readAtNativeFramerate
    }
}

/// Recording retention behavior.
public enum KeepUntil: String, Codable, Sendable, Equatable {
    case untilDeleted = "UntilDeleted"
    case untilSpaceNeeded = "UntilSpaceNeeded"
    case untilWatched = "UntilWatched"
    case untilDate = "UntilDate"
}

/// Recording lifecycle state.
public enum RecordingStatus: String, Codable, Sendable, Equatable {
    case new = "New"
    case inProgress = "InProgress"
    case completed = "Completed"
    case cancelled = "Cancelled"
    case conflictedOK = "ConflictedOk"
    case conflictedNotOK = "ConflictedNotOk"
    case error = "Error"
}
