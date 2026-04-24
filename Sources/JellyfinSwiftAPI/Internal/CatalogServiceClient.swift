import Foundation

internal struct CatalogServiceClient: CatalogService {
    private let executor: JellyfinRequestExecutor

    internal init(executor: JellyfinRequestExecutor) {
        self.executor = executor
    }

    internal func artists(_ query: CatalogQuery = CatalogQuery()) async throws -> BaseItemQueryResult {
        try await list(path: "/Artists", queryItems: query.queryItems)
    }

    internal func artist(named name: String, userID: UUID?) async throws -> BaseItem {
        try await item(path: "/Artists/\(name)", userID: userID)
    }

    internal func albumArtists(_ query: CatalogQuery = CatalogQuery()) async throws -> BaseItemQueryResult {
        try await list(path: "/Artists/AlbumArtists", queryItems: query.queryItems)
    }

    internal func genres(_ query: CatalogQuery = CatalogQuery()) async throws -> BaseItemQueryResult {
        try await list(path: "/Genres", queryItems: query.queryItems)
    }

    internal func genre(named name: String, userID: UUID?) async throws -> BaseItem {
        try await item(path: "/Genres/\(name)", userID: userID)
    }

    internal func musicGenres(_ query: CatalogQuery = CatalogQuery()) async throws -> BaseItemQueryResult {
        try await list(path: "/MusicGenres", queryItems: query.queryItems)
    }

    internal func musicGenre(named name: String, userID: UUID?) async throws -> BaseItem {
        try await item(path: "/MusicGenres/\(name)", userID: userID)
    }

    internal func persons(_ query: PersonQuery = PersonQuery()) async throws -> BaseItemQueryResult {
        try await list(path: "/Persons", queryItems: query.queryItems)
    }

    internal func person(named name: String, userID: UUID?) async throws -> BaseItem {
        try await item(path: "/Persons/\(name)", userID: userID)
    }

    internal func studios(_ query: CatalogQuery = CatalogQuery()) async throws -> BaseItemQueryResult {
        try await list(path: "/Studios", queryItems: query.queryItems)
    }

    internal func studio(named name: String, userID: UUID?) async throws -> BaseItem {
        try await item(path: "/Studios/\(name)", userID: userID)
    }

    internal func years(_ query: CatalogQuery = CatalogQuery()) async throws -> BaseItemQueryResult {
        try await list(path: "/Years", queryItems: query.queryItems)
    }

    internal func year(_ year: Int, userID: UUID?) async throws -> BaseItem {
        try await item(path: "/Years/\(year)", userID: userID)
    }

    internal func movieRecommendations(
        _ query: MovieRecommendationsQuery = MovieRecommendationsQuery()
    ) async throws -> [Recommendation] {
        try await executor.executeJSON(
            [Recommendation].self,
            for: JellyfinRequest(
                path: "/Movies/Recommendations",
                queryItems: query.queryItems
            )
        )
    }

    internal func episodes(
        seriesID: UUID,
        query: EpisodesQuery = EpisodesQuery()
    ) async throws -> BaseItemQueryResult {
        try await list(path: "/Shows/\(seriesID.uuidString)/Episodes", queryItems: query.queryItems)
    }

    internal func seasons(
        seriesID: UUID,
        query: SeasonsQuery = SeasonsQuery()
    ) async throws -> BaseItemQueryResult {
        try await list(path: "/Shows/\(seriesID.uuidString)/Seasons", queryItems: query.queryItems)
    }

    internal func nextUp(_ query: NextUpQuery = NextUpQuery()) async throws -> BaseItemQueryResult {
        try await list(path: "/Shows/NextUp", queryItems: query.queryItems)
    }

    internal func upcomingEpisodes(
        _ query: UpcomingEpisodesQuery = UpcomingEpisodesQuery()
    ) async throws -> BaseItemQueryResult {
        try await list(path: "/Shows/Upcoming", queryItems: query.queryItems)
    }

    internal func trailers(_ query: CatalogQuery = CatalogQuery()) async throws -> BaseItemQueryResult {
        try await list(path: "/Trailers", queryItems: query.queryItems)
    }

    private func list(path: String, queryItems: [URLQueryItem]) async throws -> BaseItemQueryResult {
        try await executor.executeJSON(
            BaseItemQueryResult.self,
            for: JellyfinRequest(path: path, queryItems: queryItems)
        )
    }

    private func item(path: String, userID: UUID?) async throws -> BaseItem {
        var queryItems: [URLQueryItem] = []
        if let userID {
            queryItems.append(URLQueryItem(name: "userId", value: userID.uuidString))
        }

        return try await executor.executeJSON(
            BaseItem.self,
            for: JellyfinRequest(path: path, queryItems: queryItems)
        )
    }
}

private extension CatalogQuery {
    var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = []
        items.appendOptional("userId", userID?.uuidString)
        items.appendOptional("startIndex", startIndex)
        items.appendOptional("limit", limit)
        items.appendOptional("searchTerm", searchTerm)
        items.appendOptional("parentId", parentID?.uuidString)
        items.appendArray("fields", fields)
        items.appendArray("excludeItemTypes", excludeItemTypes)
        items.appendArray("includeItemTypes", includeItemTypes)
        items.appendArray("filters", filters)
        items.appendOptional("isFavorite", isFavorite)
        items.appendArray("mediaTypes", mediaTypes)
        items.appendArray("genres", genres)
        items.appendArray("genreIds", genreIDs.map(\.uuidString))
        items.appendArray("officialRatings", officialRatings)
        items.appendArray("tags", tags)
        items.appendArray("years", years.map(String.init))
        items.appendOptional("enableUserData", enableUserData)
        items.appendOptional("imageTypeLimit", imageTypeLimit)
        items.appendArray("enableImageTypes", enableImageTypes)
        items.appendOptional("person", person)
        items.appendArray("personIds", personIDs.map(\.uuidString))
        items.appendArray("personTypes", personTypes)
        items.appendArray("studios", studios)
        items.appendArray("studioIds", studioIDs.map(\.uuidString))
        items.appendOptional("nameStartsWithOrGreater", nameStartsWithOrGreater)
        items.appendOptional("nameStartsWith", nameStartsWith)
        items.appendOptional("nameLessThan", nameLessThan)
        items.appendArray("sortBy", sortBy)
        items.appendArray("sortOrder", sortOrder)
        items.appendOptional("enableImages", enableImages)
        items.appendOptional("enableTotalRecordCount", enableTotalRecordCount)
        items.appendOptional("recursive", recursive)
        items.appendOptional("minCommunityRating", minCommunityRating)
        items.append(contentsOf: additionalQueryItems)
        return items
    }
}

private extension PersonQuery {
    var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = []
        items.appendOptional("limit", limit)
        items.appendOptional("searchTerm", searchTerm)
        items.appendArray("fields", fields)
        items.appendArray("filters", filters)
        items.appendOptional("isFavorite", isFavorite)
        items.appendOptional("enableUserData", enableUserData)
        items.appendOptional("imageTypeLimit", imageTypeLimit)
        items.appendArray("enableImageTypes", enableImageTypes)
        items.appendArray("excludePersonTypes", excludePersonTypes)
        items.appendArray("personTypes", personTypes)
        items.appendOptional("appearsInItemId", appearsInItemID?.uuidString)
        items.appendOptional("userId", userID?.uuidString)
        items.appendOptional("enableImages", enableImages)
        items.append(contentsOf: additionalQueryItems)
        return items
    }
}

private extension MovieRecommendationsQuery {
    var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = []
        items.appendOptional("userId", userID?.uuidString)
        items.appendOptional("parentId", parentID?.uuidString)
        items.appendArray("fields", fields)
        items.appendOptional("categoryLimit", categoryLimit)
        items.appendOptional("itemLimit", itemLimit)
        items.append(contentsOf: additionalQueryItems)
        return items
    }
}

private extension EpisodesQuery {
    var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = []
        items.appendOptional("userId", userID?.uuidString)
        items.appendArray("fields", fields)
        items.appendOptional("season", season)
        items.appendOptional("seasonId", seasonID?.uuidString)
        items.appendOptional("isMissing", isMissing)
        items.appendOptional("adjacentTo", adjacentTo?.uuidString)
        items.appendOptional("startItemId", startItemID?.uuidString)
        items.appendOptional("startIndex", startIndex)
        items.appendOptional("limit", limit)
        items.appendOptional("enableImages", enableImages)
        items.appendOptional("imageTypeLimit", imageTypeLimit)
        items.appendArray("enableImageTypes", enableImageTypes)
        items.appendOptional("enableUserData", enableUserData)
        items.appendOptional("sortBy", sortBy)
        items.append(contentsOf: additionalQueryItems)
        return items
    }
}

private extension SeasonsQuery {
    var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = []
        items.appendOptional("userId", userID?.uuidString)
        items.appendArray("fields", fields)
        items.appendOptional("isSpecialSeason", isSpecialSeason)
        items.appendOptional("isMissing", isMissing)
        items.appendOptional("adjacentTo", adjacentTo?.uuidString)
        items.appendOptional("enableImages", enableImages)
        items.appendOptional("imageTypeLimit", imageTypeLimit)
        items.appendArray("enableImageTypes", enableImageTypes)
        items.appendOptional("enableUserData", enableUserData)
        items.append(contentsOf: additionalQueryItems)
        return items
    }
}

private extension NextUpQuery {
    var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = []
        items.appendOptional("userId", userID?.uuidString)
        items.appendOptional("startIndex", startIndex)
        items.appendOptional("limit", limit)
        items.appendArray("fields", fields)
        items.appendOptional("seriesId", seriesID?.uuidString)
        items.appendOptional("parentId", parentID?.uuidString)
        items.appendOptional("enableImages", enableImages)
        items.appendOptional("imageTypeLimit", imageTypeLimit)
        items.appendArray("enableImageTypes", enableImageTypes)
        items.appendOptional("enableUserData", enableUserData)
        if let nextUpDateCutoff {
            items.append(URLQueryItem(name: "nextUpDateCutoff", value: ISO8601DateFormatter().string(from: nextUpDateCutoff)))
        }
        items.appendOptional("enableTotalRecordCount", enableTotalRecordCount)
        items.appendOptional("disableFirstEpisode", disableFirstEpisode)
        items.appendOptional("enableResumable", enableResumable)
        items.appendOptional("enableRewatching", enableRewatching)
        items.append(contentsOf: additionalQueryItems)
        return items
    }
}

private extension UpcomingEpisodesQuery {
    var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = []
        items.appendOptional("userId", userID?.uuidString)
        items.appendOptional("startIndex", startIndex)
        items.appendOptional("limit", limit)
        items.appendArray("fields", fields)
        items.appendOptional("parentId", parentID?.uuidString)
        items.appendOptional("enableImages", enableImages)
        items.appendOptional("imageTypeLimit", imageTypeLimit)
        items.appendArray("enableImageTypes", enableImageTypes)
        items.appendOptional("enableUserData", enableUserData)
        items.append(contentsOf: additionalQueryItems)
        return items
    }
}

private extension Array where Element == URLQueryItem {
    mutating func appendOptional<T: CustomStringConvertible>(_ name: String, _ value: T?) {
        guard let value else { return }
        append(URLQueryItem(name: name, value: value.description))
    }

    mutating func appendArray(_ name: String, _ values: [String]) {
        guard !values.isEmpty else { return }
        append(URLQueryItem(name: name, value: values.joined(separator: ",")))
    }
}
