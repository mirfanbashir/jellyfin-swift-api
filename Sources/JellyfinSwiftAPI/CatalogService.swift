import Foundation

/// Service interface for Jellyfin catalog browse and discovery endpoints.
public protocol CatalogService: JellyfinService {
    func artists(_ query: CatalogQuery) async throws -> BaseItemQueryResult
    func artist(named name: String, userID: UUID?) async throws -> BaseItem
    func albumArtists(_ query: CatalogQuery) async throws -> BaseItemQueryResult
    func genres(_ query: CatalogQuery) async throws -> BaseItemQueryResult
    func genre(named name: String, userID: UUID?) async throws -> BaseItem
    func musicGenres(_ query: CatalogQuery) async throws -> BaseItemQueryResult
    func musicGenre(named name: String, userID: UUID?) async throws -> BaseItem
    func persons(_ query: PersonQuery) async throws -> BaseItemQueryResult
    func person(named name: String, userID: UUID?) async throws -> BaseItem
    func studios(_ query: CatalogQuery) async throws -> BaseItemQueryResult
    func studio(named name: String, userID: UUID?) async throws -> BaseItem
    func years(_ query: CatalogQuery) async throws -> BaseItemQueryResult
    func year(_ year: Int, userID: UUID?) async throws -> BaseItem
    func movieRecommendations(_ query: MovieRecommendationsQuery) async throws -> [Recommendation]
    func episodes(seriesID: UUID, query: EpisodesQuery) async throws -> BaseItemQueryResult
    func seasons(seriesID: UUID, query: SeasonsQuery) async throws -> BaseItemQueryResult
    func nextUp(_ query: NextUpQuery) async throws -> BaseItemQueryResult
    func upcomingEpisodes(_ query: UpcomingEpisodesQuery) async throws -> BaseItemQueryResult
    func trailers(_ query: CatalogQuery) async throws -> BaseItemQueryResult
}
