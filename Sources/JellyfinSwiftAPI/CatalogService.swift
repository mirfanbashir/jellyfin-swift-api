import Foundation

/// Service interface for Jellyfin catalog browse and discovery endpoints.
public protocol CatalogService: JellyfinService {
    /// Gets artists matching the supplied browse query.
    func artists(_ query: CatalogQuery) async throws -> BaseItemQueryResult

    /// Gets a single artist by name.
    func artist(named name: String, userID: UUID?) async throws -> BaseItem

    /// Gets album artists matching the supplied browse query.
    func albumArtists(_ query: CatalogQuery) async throws -> BaseItemQueryResult

    /// Gets genres matching the supplied browse query.
    func genres(_ query: CatalogQuery) async throws -> BaseItemQueryResult

    /// Gets a single genre by name.
    func genre(named name: String, userID: UUID?) async throws -> BaseItem

    /// Gets music genres matching the supplied browse query.
    func musicGenres(_ query: CatalogQuery) async throws -> BaseItemQueryResult

    /// Gets a single music genre by name.
    func musicGenre(named name: String, userID: UUID?) async throws -> BaseItem

    /// Gets persons matching the supplied browse query.
    func persons(_ query: PersonQuery) async throws -> BaseItemQueryResult

    /// Gets a single person by name.
    func person(named name: String, userID: UUID?) async throws -> BaseItem

    /// Gets studios matching the supplied browse query.
    func studios(_ query: CatalogQuery) async throws -> BaseItemQueryResult

    /// Gets a single studio by name.
    func studio(named name: String, userID: UUID?) async throws -> BaseItem

    /// Gets years matching the supplied browse query.
    func years(_ query: CatalogQuery) async throws -> BaseItemQueryResult

    /// Gets a single year entry.
    func year(_ year: Int, userID: UUID?) async throws -> BaseItem

    /// Gets movie recommendations for the supplied user and browse context.
    func movieRecommendations(_ query: MovieRecommendationsQuery) async throws -> [Recommendation]

    /// Gets episodes for a series.
    func episodes(seriesID: UUID, query: EpisodesQuery) async throws -> BaseItemQueryResult

    /// Gets seasons for a series.
    func seasons(seriesID: UUID, query: SeasonsQuery) async throws -> BaseItemQueryResult

    /// Gets the next-up episodes for the supplied user context.
    func nextUp(_ query: NextUpQuery) async throws -> BaseItemQueryResult

    /// Gets upcoming episodes for the supplied user context.
    func upcomingEpisodes(_ query: UpcomingEpisodesQuery) async throws -> BaseItemQueryResult

    /// Gets trailers matching the supplied browse query.
    func trailers(_ query: CatalogQuery) async throws -> BaseItemQueryResult
}
