import Foundation

/// Service interface for Jellyfin metadata lookup, update, and remote-image endpoints.
public protocol MetadataService: JellyfinService {
    func externalIDInfos(itemID: UUID) async throws -> [ExternalIDInfo]
    func applyRemoteSearchResult(
        _ result: RemoteSearchResult,
        to itemID: UUID,
        replaceAllImages: Bool?
    ) async throws
    func bookRemoteSearchResults(_ query: BookRemoteSearchQuery) async throws -> [RemoteSearchResult]
    func boxSetRemoteSearchResults(_ query: BoxSetRemoteSearchQuery) async throws -> [RemoteSearchResult]
    func movieRemoteSearchResults(_ query: MovieRemoteSearchQuery) async throws -> [RemoteSearchResult]
    func musicAlbumRemoteSearchResults(_ query: MusicAlbumRemoteSearchQuery) async throws -> [RemoteSearchResult]
    func musicArtistRemoteSearchResults(_ query: MusicArtistRemoteSearchQuery) async throws -> [RemoteSearchResult]
    func musicVideoRemoteSearchResults(_ query: MusicVideoRemoteSearchQuery) async throws -> [RemoteSearchResult]
    func personRemoteSearchResults(_ query: PersonRemoteSearchQuery) async throws -> [RemoteSearchResult]
    func seriesRemoteSearchResults(_ query: SeriesRemoteSearchQuery) async throws -> [RemoteSearchResult]
    func trailerRemoteSearchResults(_ query: TrailerRemoteSearchQuery) async throws -> [RemoteSearchResult]
    func refreshItem(id: UUID, options: MetadataRefreshOptions) async throws
    func updateItem(_ item: BaseItem, id: UUID) async throws
    func updateItemContentType(id: UUID, contentType: CollectionType?) async throws
    func metadataEditorInfo(itemID: UUID) async throws -> MetadataEditorInfo
    func remoteImages(itemID: UUID, query: RemoteImagesQuery) async throws -> RemoteImageResult
    func downloadRemoteImage(itemID: UUID, type: ImageType, imageURL: String?) async throws
    func remoteImageProviders(itemID: UUID) async throws -> [ImageProviderInfo]
}
