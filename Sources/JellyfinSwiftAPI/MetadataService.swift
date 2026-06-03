import Foundation

/// Service interface for Jellyfin metadata lookup, update, and remote-image endpoints.
public protocol MetadataService: JellyfinService {
    /// Gets the external identifier fields that Jellyfin exposes for an item.
    ///
    /// - Parameter itemID: The item identifier.
    /// - Returns: External id descriptors that can be used for metadata lookup and editing.
    func externalIDInfos(itemID: UUID) async throws -> [ExternalIDInfo]

    /// Applies a remote metadata search result to an item and refreshes its metadata.
    ///
    /// - Parameters:
    ///   - result: The remote search match to apply.
    ///   - itemID: The item identifier to update.
    ///   - replaceAllImages: When `true`, Jellyfin replaces existing item images with the remote result's images.
    func applyRemoteSearchResult(
        _ result: RemoteSearchResult,
        to itemID: UUID,
        replaceAllImages: Bool?
    ) async throws

    /// Searches remote metadata providers for a book.
    ///
    /// - Parameter query: The remote book lookup query.
    /// - Returns: Matching remote search results.
    func bookRemoteSearchResults(_ query: BookRemoteSearchQuery) async throws -> [RemoteSearchResult]

    /// Searches remote metadata providers for a box set.
    ///
    /// - Parameter query: The remote box-set lookup query.
    /// - Returns: Matching remote search results.
    func boxSetRemoteSearchResults(_ query: BoxSetRemoteSearchQuery) async throws -> [RemoteSearchResult]

    /// Searches remote metadata providers for a movie.
    ///
    /// - Parameter query: The remote movie lookup query.
    /// - Returns: Matching remote search results.
    func movieRemoteSearchResults(_ query: MovieRemoteSearchQuery) async throws -> [RemoteSearchResult]

    /// Searches remote metadata providers for a music album.
    ///
    /// - Parameter query: The remote music-album lookup query.
    /// - Returns: Matching remote search results.
    func musicAlbumRemoteSearchResults(_ query: MusicAlbumRemoteSearchQuery) async throws -> [RemoteSearchResult]

    /// Searches remote metadata providers for a music artist.
    ///
    /// - Parameter query: The remote music-artist lookup query.
    /// - Returns: Matching remote search results.
    func musicArtistRemoteSearchResults(_ query: MusicArtistRemoteSearchQuery) async throws -> [RemoteSearchResult]

    /// Searches remote metadata providers for a music video.
    ///
    /// - Parameter query: The remote music-video lookup query.
    /// - Returns: Matching remote search results.
    func musicVideoRemoteSearchResults(_ query: MusicVideoRemoteSearchQuery) async throws -> [RemoteSearchResult]

    /// Searches remote metadata providers for a person.
    ///
    /// - Parameter query: The remote person lookup query.
    /// - Returns: Matching remote search results.
    func personRemoteSearchResults(_ query: PersonRemoteSearchQuery) async throws -> [RemoteSearchResult]

    /// Searches remote metadata providers for a series.
    ///
    /// - Parameter query: The remote series lookup query.
    /// - Returns: Matching remote search results.
    func seriesRemoteSearchResults(_ query: SeriesRemoteSearchQuery) async throws -> [RemoteSearchResult]

    /// Searches remote metadata providers for a trailer.
    ///
    /// - Parameter query: The remote trailer lookup query.
    /// - Returns: Matching remote search results.
    func trailerRemoteSearchResults(_ query: TrailerRemoteSearchQuery) async throws -> [RemoteSearchResult]

    /// Refreshes metadata and images for an item.
    ///
    /// - Parameters:
    ///   - id: The item identifier to refresh.
    ///   - options: Refresh options controlling metadata mode, image mode, replacement behavior, and trickplay regeneration.
    func refreshItem(id: UUID, options: MetadataRefreshOptions) async throws

    /// Updates an item's editable metadata fields.
    ///
    /// - Parameters:
    ///   - item: The updated item payload to send to Jellyfin.
    ///   - id: The item identifier to update.
    func updateItem(_ item: BaseItem, id: UUID) async throws

    /// Updates an item's collection content type.
    ///
    /// - Parameters:
    ///   - id: The item identifier to update.
    ///   - contentType: The new collection content type. Pass `nil` to clear it when supported by the server.
    func updateItemContentType(id: UUID, contentType: CollectionType?) async throws

    /// Gets metadata editor information for an item.
    ///
    /// - Parameter itemID: The item identifier.
    /// - Returns: Metadata editor details, including available people, studios, and editing context.
    func metadataEditorInfo(itemID: UUID) async throws -> MetadataEditorInfo

    /// Gets available remote images for an item.
    ///
    /// - Parameters:
    ///   - itemID: The item identifier.
    ///   - query: Remote image filters such as image type, paging, provider, and language behavior.
    /// - Returns: Remote images and provider metadata for the item.
    func remoteImages(itemID: UUID, query: RemoteImagesQuery) async throws -> RemoteImageResult

    /// Downloads a remote image for an item.
    ///
    /// - Parameters:
    ///   - itemID: The item identifier.
    ///   - type: The image type to download.
    ///   - imageURL: An optional explicit remote image URL when required by the selected provider.
    func downloadRemoteImage(itemID: UUID, type: ImageType, imageURL: String?) async throws

    /// Gets the remote image providers available for an item.
    ///
    /// - Parameter itemID: The item identifier.
    /// - Returns: Image providers that can supply remote artwork for the item.
    func remoteImageProviders(itemID: UUID) async throws -> [ImageProviderInfo]
}
