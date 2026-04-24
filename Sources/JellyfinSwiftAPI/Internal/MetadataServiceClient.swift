import Foundation

internal struct MetadataServiceClient: MetadataService {
    private let executor: JellyfinRequestExecutor

    internal init(executor: JellyfinRequestExecutor) {
        self.executor = executor
    }

    internal func externalIDInfos(itemID: UUID) async throws -> [ExternalIDInfo] {
        try await executor.executeJSON(
            [ExternalIDInfo].self,
            for: JellyfinRequest(path: "/Items/\(itemID.uuidString)/ExternalIdInfos")
        )
    }

    internal func applyRemoteSearchResult(
        _ result: RemoteSearchResult,
        to itemID: UUID,
        replaceAllImages: Bool?
    ) async throws {
        var queryItems: [URLQueryItem] = []
        if let replaceAllImages {
            queryItems.append(URLQueryItem(name: "replaceAllImages", value: String(replaceAllImages)))
        }

        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Items/RemoteSearch/Apply/\(itemID.uuidString)",
                method: .post,
                queryItems: queryItems,
                body: .json(try JellyfinJSONCoder.encoder().encode(result))
            )
        )
    }

    internal func bookRemoteSearchResults(_ query: BookRemoteSearchQuery) async throws -> [RemoteSearchResult] {
        try await remoteSearch(path: "/Items/RemoteSearch/Book", query: query)
    }

    internal func boxSetRemoteSearchResults(_ query: BoxSetRemoteSearchQuery) async throws -> [RemoteSearchResult] {
        try await remoteSearch(path: "/Items/RemoteSearch/BoxSet", query: query)
    }

    internal func movieRemoteSearchResults(_ query: MovieRemoteSearchQuery) async throws -> [RemoteSearchResult] {
        try await remoteSearch(path: "/Items/RemoteSearch/Movie", query: query)
    }

    internal func musicAlbumRemoteSearchResults(_ query: MusicAlbumRemoteSearchQuery) async throws -> [RemoteSearchResult] {
        try await remoteSearch(path: "/Items/RemoteSearch/MusicAlbum", query: query)
    }

    internal func musicArtistRemoteSearchResults(_ query: MusicArtistRemoteSearchQuery) async throws -> [RemoteSearchResult] {
        try await remoteSearch(path: "/Items/RemoteSearch/MusicArtist", query: query)
    }

    internal func musicVideoRemoteSearchResults(_ query: MusicVideoRemoteSearchQuery) async throws -> [RemoteSearchResult] {
        try await remoteSearch(path: "/Items/RemoteSearch/MusicVideo", query: query)
    }

    internal func personRemoteSearchResults(_ query: PersonRemoteSearchQuery) async throws -> [RemoteSearchResult] {
        try await remoteSearch(path: "/Items/RemoteSearch/Person", query: query)
    }

    internal func seriesRemoteSearchResults(_ query: SeriesRemoteSearchQuery) async throws -> [RemoteSearchResult] {
        try await remoteSearch(path: "/Items/RemoteSearch/Series", query: query)
    }

    internal func trailerRemoteSearchResults(_ query: TrailerRemoteSearchQuery) async throws -> [RemoteSearchResult] {
        try await remoteSearch(path: "/Items/RemoteSearch/Trailer", query: query)
    }

    internal func refreshItem(id: UUID, options: MetadataRefreshOptions) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Items/\(id.uuidString)/Refresh",
                method: .post,
                queryItems: options.queryItems
            )
        )
    }

    internal func updateItem(_ item: BaseItem, id: UUID) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Items/\(id.uuidString)",
                method: .post,
                body: .json(try JellyfinJSONCoder.encoder().encode(item))
            )
        )
    }

    internal func updateItemContentType(id: UUID, contentType: CollectionType?) async throws {
        var queryItems: [URLQueryItem] = []
        if let contentType {
            queryItems.append(URLQueryItem(name: "contentType", value: contentType.rawValue))
        }

        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Items/\(id.uuidString)/ContentType",
                method: .post,
                queryItems: queryItems
            )
        )
    }

    internal func metadataEditorInfo(itemID: UUID) async throws -> MetadataEditorInfo {
        try await executor.executeJSON(
            MetadataEditorInfo.self,
            for: JellyfinRequest(path: "/Items/\(itemID.uuidString)/MetadataEditor")
        )
    }

    internal func remoteImages(itemID: UUID, query: RemoteImagesQuery) async throws -> RemoteImageResult {
        try await executor.executeJSON(
            RemoteImageResult.self,
            for: JellyfinRequest(
                path: "/Items/\(itemID.uuidString)/RemoteImages",
                queryItems: query.queryItems
            )
        )
    }

    internal func downloadRemoteImage(itemID: UUID, type: ImageType, imageURL: String?) async throws {
        var queryItems = [URLQueryItem(name: "type", value: type.rawValue)]
        if let imageURL {
            queryItems.append(URLQueryItem(name: "imageUrl", value: imageURL))
        }

        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Items/\(itemID.uuidString)/RemoteImages/Download",
                method: .post,
                queryItems: queryItems
            )
        )
    }

    internal func remoteImageProviders(itemID: UUID) async throws -> [ImageProviderInfo] {
        try await executor.executeJSON(
            [ImageProviderInfo].self,
            for: JellyfinRequest(path: "/Items/\(itemID.uuidString)/RemoteImages/Providers")
        )
    }

    private func remoteSearch<SearchInfo: Codable & Sendable & Equatable>(
        path: String,
        query: RemoteSearchQuery<SearchInfo>
    ) async throws -> [RemoteSearchResult] {
        try await executor.executeJSON(
            [RemoteSearchResult].self,
            for: JellyfinRequest(
                path: path,
                method: .post,
                body: .json(try JellyfinJSONCoder.encoder().encode(query))
            )
        )
    }
}

private extension MetadataRefreshOptions {
    var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = []
        items.appendOptional("metadataRefreshMode", metadataRefreshMode?.rawValue)
        items.appendOptional("imageRefreshMode", imageRefreshMode?.rawValue)
        items.appendOptional("replaceAllMetadata", replaceAllMetadata)
        items.appendOptional("replaceAllImages", replaceAllImages)
        items.appendOptional("regenerateTrickplay", regenerateTrickplay)
        return items
    }
}

private extension RemoteImagesQuery {
    var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = []
        items.appendOptional("type", type?.rawValue)
        items.appendOptional("startIndex", startIndex)
        items.appendOptional("limit", limit)
        items.appendOptional("providerName", providerName)
        items.appendOptional("includeAllLanguages", includeAllLanguages)
        return items
    }
}

private extension Array where Element == URLQueryItem {
    mutating func appendOptional<T: CustomStringConvertible>(_ name: String, _ value: T?) {
        guard let value else { return }
        append(URLQueryItem(name: name, value: value.description))
    }
}
