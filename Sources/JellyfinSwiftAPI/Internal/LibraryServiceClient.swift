import Foundation

internal struct LibraryServiceClient: LibraryService {
    private let executor: JellyfinRequestExecutor

    internal init(executor: JellyfinRequestExecutor) {
        self.executor = executor
    }

    internal func items(_ query: LibraryItemsQuery = LibraryItemsQuery()) async throws -> BaseItemQueryResult {
        try await list(path: "/Items", queryItems: query.queryItems)
    }

    internal func item(id: UUID, userID: UUID?) async throws -> BaseItem {
        try await executor.executeJSON(
            BaseItem.self,
            for: JellyfinRequest(
                path: "/Items/\(id.uuidString)",
                queryItems: optionalUserQueryItems(userID)
            )
        )
    }

    internal func rootFolder(userID: UUID?) async throws -> BaseItem {
        try await executor.executeJSON(
            BaseItem.self,
            for: JellyfinRequest(path: "/Items/Root", queryItems: optionalUserQueryItems(userID))
        )
    }

    internal func deleteItem(id: UUID) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(path: "/Items/\(id.uuidString)", method: .delete)
        )
    }

    internal func deleteItems(ids: [UUID]) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Items",
                method: .delete,
                queryItems: [URLQueryItem(name: "ids", value: ids.map(\.uuidString).joined(separator: ","))]
            )
        )
    }

    internal func itemCounts(userID: UUID?, isFavorite: Bool?) async throws -> ItemCounts {
        var queryItems = optionalUserQueryItems(userID)
        queryItems.appendOptional("isFavorite", isFavorite)

        return try await executor.executeJSON(
            ItemCounts.self,
            for: JellyfinRequest(path: "/Items/Counts", queryItems: queryItems)
        )
    }

    internal func queryFiltersLegacy(
        userID: UUID?,
        parentID: UUID?,
        includeItemTypes: [String],
        mediaTypes: [MediaType]
    ) async throws -> QueryFiltersLegacy {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("userId", userID?.uuidString)
        queryItems.appendOptional("parentId", parentID?.uuidString)
        queryItems.appendArray("includeItemTypes", includeItemTypes)
        queryItems.appendArray("mediaTypes", mediaTypes.map(\.rawValue))

        return try await executor.executeJSON(
            QueryFiltersLegacy.self,
            for: JellyfinRequest(path: "/Items/Filters", queryItems: queryItems)
        )
    }

    internal func queryFilters(
        userID: UUID?,
        parentID: UUID?,
        includeItemTypes: [String],
        isAiring: Bool?,
        isMovie: Bool?,
        isSports: Bool?,
        isKids: Bool?,
        isNews: Bool?,
        isSeries: Bool?,
        recursive: Bool?
    ) async throws -> QueryFilters {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("userId", userID?.uuidString)
        queryItems.appendOptional("parentId", parentID?.uuidString)
        queryItems.appendArray("includeItemTypes", includeItemTypes)
        queryItems.appendOptional("isAiring", isAiring)
        queryItems.appendOptional("isMovie", isMovie)
        queryItems.appendOptional("isSports", isSports)
        queryItems.appendOptional("isKids", isKids)
        queryItems.appendOptional("isNews", isNews)
        queryItems.appendOptional("isSeries", isSeries)
        queryItems.appendOptional("recursive", recursive)

        return try await executor.executeJSON(
            QueryFilters.self,
            for: JellyfinRequest(path: "/Items/Filters2", queryItems: queryItems)
        )
    }

    internal func ancestors(itemID: UUID, userID: UUID?) async throws -> [BaseItem] {
        try await executor.executeJSON(
            [BaseItem].self,
            for: JellyfinRequest(
                path: "/Items/\(itemID.uuidString)/Ancestors",
                queryItems: optionalUserQueryItems(userID)
            )
        )
    }

    internal func similarItems(
        itemID: UUID,
        query: SimilarItemsQuery = SimilarItemsQuery()
    ) async throws -> BaseItemQueryResult {
        try await list(path: "/Items/\(itemID.uuidString)/Similar", queryItems: query.queryItems)
    }

    internal func similarAlbums(itemID: UUID, query: SimilarItemsQuery = SimilarItemsQuery()) async throws -> BaseItemQueryResult {
        try await list(path: "/Albums/\(itemID.uuidString)/Similar", queryItems: query.queryItems)
    }

    internal func similarArtists(itemID: UUID, query: SimilarItemsQuery = SimilarItemsQuery()) async throws -> BaseItemQueryResult {
        try await list(path: "/Artists/\(itemID.uuidString)/Similar", queryItems: query.queryItems)
    }

    internal func similarMovies(itemID: UUID, query: SimilarItemsQuery = SimilarItemsQuery()) async throws -> BaseItemQueryResult {
        try await list(path: "/Movies/\(itemID.uuidString)/Similar", queryItems: query.queryItems)
    }

    internal func similarShows(itemID: UUID, query: SimilarItemsQuery = SimilarItemsQuery()) async throws -> BaseItemQueryResult {
        try await list(path: "/Shows/\(itemID.uuidString)/Similar", queryItems: query.queryItems)
    }

    internal func similarTrailers(itemID: UUID, query: SimilarItemsQuery = SimilarItemsQuery()) async throws -> BaseItemQueryResult {
        try await list(path: "/Trailers/\(itemID.uuidString)/Similar", queryItems: query.queryItems)
    }

    internal func criticReviews(itemID: UUID) async throws -> BaseItemQueryResult {
        try await list(path: "/Items/\(itemID.uuidString)/CriticReviews", queryItems: [])
    }

    internal func latestMedia(_ query: LatestMediaQuery = LatestMediaQuery()) async throws -> [BaseItem] {
        try await executor.executeJSON(
            [BaseItem].self,
            for: JellyfinRequest(path: "/Items/Latest", queryItems: query.queryItems)
        )
    }

    internal func suggestions(_ query: SuggestionsQuery = SuggestionsQuery()) async throws -> BaseItemQueryResult {
        try await list(path: "/Items/Suggestions", queryItems: query.queryItems)
    }

    internal func resumeItems(_ query: ResumeItemsQuery = ResumeItemsQuery()) async throws -> BaseItemQueryResult {
        try await list(path: "/UserItems/Resume", queryItems: query.queryItems)
    }

    internal func searchHints(_ query: SearchHintsQuery) async throws -> SearchHintResult {
        try await executor.executeJSON(
            SearchHintResult.self,
            for: JellyfinRequest(path: "/Search/Hints", queryItems: query.queryItems)
        )
    }

    internal func userViews(_ query: UserViewsQuery = UserViewsQuery()) async throws -> BaseItemQueryResult {
        try await list(path: "/UserViews", queryItems: query.queryItems)
    }

    internal func groupingOptions(userID: UUID?) async throws -> [SpecialViewOption] {
        try await executor.executeJSON(
            [SpecialViewOption].self,
            for: JellyfinRequest(path: "/UserViews/GroupingOptions", queryItems: optionalUserQueryItems(userID))
        )
    }

    internal func itemUserData(itemID: UUID, userID: UUID?) async throws -> UserItemData {
        try await executor.executeJSON(
            UserItemData.self,
            for: JellyfinRequest(
                path: "/UserItems/\(itemID.uuidString)/UserData",
                queryItems: optionalUserQueryItems(userID)
            )
        )
    }

    internal func updateItemUserData(
        _ userData: UserItemData,
        itemID: UUID,
        userID: UUID?
    ) async throws -> UserItemData {
        try await executor.executeJSON(
            UserItemData.self,
            for: JellyfinRequest(
                path: "/UserItems/\(itemID.uuidString)/UserData",
                method: .post,
                queryItems: optionalUserQueryItems(userID),
                body: .json(try JellyfinJSONCoder.encoder().encode(userData))
            )
        )
    }

    internal func markFavorite(itemID: UUID, userID: UUID?) async throws -> UserItemData {
        try await userLibraryData(path: "/UserFavoriteItems/\(itemID.uuidString)", method: .post, userID: userID)
    }

    internal func unmarkFavorite(itemID: UUID, userID: UUID?) async throws -> UserItemData {
        try await userLibraryData(path: "/UserFavoriteItems/\(itemID.uuidString)", method: .delete, userID: userID)
    }

    internal func updateUserItemRating(itemID: UUID, userID: UUID?, likes: Bool?) async throws -> UserItemData {
        var queryItems = optionalUserQueryItems(userID)
        queryItems.appendOptional("likes", likes)

        return try await executor.executeJSON(
            UserItemData.self,
            for: JellyfinRequest(
                path: "/UserItems/\(itemID.uuidString)/Rating",
                method: .post,
                queryItems: queryItems
            )
        )
    }

    internal func deleteUserItemRating(itemID: UUID, userID: UUID?) async throws -> UserItemData {
        try await userLibraryData(path: "/UserItems/\(itemID.uuidString)/Rating", method: .delete, userID: userID)
    }

    internal func createCollection(
        name: String?,
        ids: [UUID],
        parentID: UUID?,
        isLocked: Bool?
    ) async throws -> CollectionCreationResult {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("name", name)
        queryItems.appendArray("ids", ids.map(\.uuidString))
        queryItems.appendOptional("parentId", parentID?.uuidString)
        queryItems.appendOptional("isLocked", isLocked)

        return try await executor.executeJSON(
            CollectionCreationResult.self,
            for: JellyfinRequest(path: "/Collections", method: .post, queryItems: queryItems)
        )
    }

    internal func addToCollection(collectionID: UUID, ids: [UUID]) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Collections/\(collectionID.uuidString)/Items",
                method: .post,
                queryItems: [URLQueryItem(name: "ids", value: ids.map(\.uuidString).joined(separator: ","))]
            )
        )
    }

    internal func removeFromCollection(collectionID: UUID, ids: [UUID]) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Collections/\(collectionID.uuidString)/Items",
                method: .delete,
                queryItems: [URLQueryItem(name: "ids", value: ids.map(\.uuidString).joined(separator: ","))]
            )
        )
    }

    internal func instantMixFromAlbum(itemID: UUID, query: InstantMixQuery = InstantMixQuery()) async throws -> BaseItemQueryResult {
        try await list(path: "/Albums/\(itemID.uuidString)/InstantMix", queryItems: query.queryItems)
    }

    internal func instantMixFromArtist(itemID: UUID, query: InstantMixQuery = InstantMixQuery()) async throws -> BaseItemQueryResult {
        try await list(path: "/Artists/\(itemID.uuidString)/InstantMix", queryItems: query.queryItems)
    }

    internal func instantMixFromArtist(id: UUID, query: InstantMixQuery = InstantMixQuery()) async throws -> BaseItemQueryResult {
        var queryItems = query.queryItems
        queryItems.insert(URLQueryItem(name: "id", value: id.uuidString), at: 0)
        return try await list(path: "/Artists/InstantMix", queryItems: queryItems)
    }

    internal func instantMixFromItem(itemID: UUID, query: InstantMixQuery = InstantMixQuery()) async throws -> BaseItemQueryResult {
        try await list(path: "/Items/\(itemID.uuidString)/InstantMix", queryItems: query.queryItems)
    }

    internal func instantMixFromMusicGenre(name: String, query: InstantMixQuery = InstantMixQuery()) async throws -> BaseItemQueryResult {
        try await list(path: "/MusicGenres/\(name)/InstantMix", queryItems: query.queryItems)
    }

    internal func instantMixFromMusicGenre(id: UUID, query: InstantMixQuery = InstantMixQuery()) async throws -> BaseItemQueryResult {
        var queryItems = query.queryItems
        queryItems.insert(URLQueryItem(name: "id", value: id.uuidString), at: 0)
        return try await list(path: "/MusicGenres/InstantMix", queryItems: queryItems)
    }

    internal func instantMixFromPlaylist(itemID: UUID, query: InstantMixQuery = InstantMixQuery()) async throws -> BaseItemQueryResult {
        try await list(path: "/Playlists/\(itemID.uuidString)/InstantMix", queryItems: query.queryItems)
    }

    internal func instantMixFromSong(itemID: UUID, query: InstantMixQuery = InstantMixQuery()) async throws -> BaseItemQueryResult {
        try await list(path: "/Songs/\(itemID.uuidString)/InstantMix", queryItems: query.queryItems)
    }

    internal func intros(itemID: UUID, userID: UUID?) async throws -> BaseItemQueryResult {
        try await list(path: "/Items/\(itemID.uuidString)/Intros", queryItems: optionalUserQueryItems(userID))
    }

    internal func localTrailers(itemID: UUID, userID: UUID?) async throws -> [BaseItem] {
        try await executor.executeJSON(
            [BaseItem].self,
            for: JellyfinRequest(
                path: "/Items/\(itemID.uuidString)/LocalTrailers",
                queryItems: optionalUserQueryItems(userID)
            )
        )
    }

    internal func specialFeatures(itemID: UUID, userID: UUID?) async throws -> [BaseItem] {
        try await executor.executeJSON(
            [BaseItem].self,
            for: JellyfinRequest(
                path: "/Items/\(itemID.uuidString)/SpecialFeatures",
                queryItems: optionalUserQueryItems(userID)
            )
        )
    }

    internal func themeMedia(itemID: UUID, query: ThemeMediaQuery = ThemeMediaQuery()) async throws -> AllThemeMediaResult {
        try await executor.executeJSON(
            AllThemeMediaResult.self,
            for: JellyfinRequest(path: "/Items/\(itemID.uuidString)/ThemeMedia", queryItems: query.queryItems)
        )
    }

    internal func themeSongs(itemID: UUID, query: ThemeMediaQuery = ThemeMediaQuery()) async throws -> ThemeMediaResult {
        try await executor.executeJSON(
            ThemeMediaResult.self,
            for: JellyfinRequest(path: "/Items/\(itemID.uuidString)/ThemeSongs", queryItems: query.queryItems)
        )
    }

    internal func themeVideos(itemID: UUID, query: ThemeMediaQuery = ThemeMediaQuery()) async throws -> ThemeMediaResult {
        try await executor.executeJSON(
            ThemeMediaResult.self,
            for: JellyfinRequest(path: "/Items/\(itemID.uuidString)/ThemeVideos", queryItems: query.queryItems)
        )
    }

    internal func download(itemID: UUID) async throws -> JellyfinRawData {
        let response = try await executor.executeData(for: JellyfinRequest(path: "/Items/\(itemID.uuidString)/Download"))
        return JellyfinRawData(data: response.data, mimeType: response.mimeType, statusCode: response.statusCode)
    }

    internal func file(itemID: UUID) async throws -> JellyfinRawData {
        let response = try await executor.executeData(for: JellyfinRequest(path: "/Items/\(itemID.uuidString)/File"))
        return JellyfinRawData(data: response.data, mimeType: response.mimeType, statusCode: response.statusCode)
    }

    internal func createPlaylist(_ request: CreatePlaylistRequest) async throws -> PlaylistCreationResult {
        try await executor.executeJSON(
            PlaylistCreationResult.self,
            for: JellyfinRequest(
                path: "/Playlists",
                method: .post,
                body: .json(try JellyfinJSONCoder.encoder().encode(request))
            )
        )
    }

    internal func playlist(id: UUID) async throws -> Playlist {
        try await executor.executeJSON(
            Playlist.self,
            for: JellyfinRequest(path: "/Playlists/\(id.uuidString)")
        )
    }

    internal func updatePlaylist(_ request: UpdatePlaylistRequest, playlistID: UUID) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Playlists/\(playlistID.uuidString)",
                method: .post,
                body: .json(try JellyfinJSONCoder.encoder().encode(request))
            )
        )
    }

    internal func playlistItems(
        playlistID: UUID,
        query: PlaylistItemsQuery = PlaylistItemsQuery()
    ) async throws -> BaseItemQueryResult {
        try await list(path: "/Playlists/\(playlistID.uuidString)/Items", queryItems: query.queryItems)
    }

    internal func addItemsToPlaylist(playlistID: UUID, ids: [UUID], userID: UUID?) async throws {
        var queryItems: [URLQueryItem] = []
        queryItems.appendArray("ids", ids.map(\.uuidString))
        queryItems.appendOptional("userId", userID?.uuidString)

        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Playlists/\(playlistID.uuidString)/Items",
                method: .post,
                queryItems: queryItems
            )
        )
    }

    internal func removeItemsFromPlaylist(playlistID: UUID, entryIDs: [String]) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Playlists/\(playlistID.uuidString)/Items",
                method: .delete,
                queryItems: [URLQueryItem(name: "entryIds", value: entryIDs.joined(separator: ","))]
            )
        )
    }

    internal func movePlaylistItem(playlistID: UUID, itemID: UUID, newIndex: Int) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Playlists/\(playlistID.uuidString)/Items/\(itemID.uuidString)/Move/\(newIndex)",
                method: .post
            )
        )
    }

    internal func playlistUsers(playlistID: UUID) async throws -> [PlaylistUserPermission] {
        try await executor.executeJSON(
            [PlaylistUserPermission].self,
            for: JellyfinRequest(path: "/Playlists/\(playlistID.uuidString)/Users")
        )
    }

    internal func playlistUser(playlistID: UUID, userID: UUID) async throws -> PlaylistUserPermission {
        try await executor.executeJSON(
            PlaylistUserPermission.self,
            for: JellyfinRequest(path: "/Playlists/\(playlistID.uuidString)/Users/\(userID.uuidString)")
        )
    }

    internal func updatePlaylistUser(
        _ request: UpdatePlaylistUserRequest,
        playlistID: UUID,
        userID: UUID
    ) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Playlists/\(playlistID.uuidString)/Users/\(userID.uuidString)",
                method: .post,
                body: .json(try JellyfinJSONCoder.encoder().encode(request))
            )
        )
    }

    internal func removePlaylistUser(playlistID: UUID, userID: UUID) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Playlists/\(playlistID.uuidString)/Users/\(userID.uuidString)",
                method: .delete
            )
        )
    }

    internal func libraryOptionsInfo(
        libraryContentType: CollectionType?,
        isNewLibrary: Bool?
    ) async throws -> LibraryOptionsResult {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("libraryContentType", libraryContentType?.rawValue)
        queryItems.appendOptional("isNewLibrary", isNewLibrary)

        return try await executor.executeJSON(
            LibraryOptionsResult.self,
            for: JellyfinRequest(path: "/Libraries/AvailableOptions", queryItems: queryItems)
        )
    }

    internal func mediaFolders(isHidden: Bool?) async throws -> BaseItemQueryResult {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("isHidden", isHidden)
        return try await list(path: "/Library/MediaFolders", queryItems: queryItems)
    }

    internal func physicalPaths() async throws -> [String] {
        try await executor.executeJSON(
            [String].self,
            for: JellyfinRequest(path: "/Library/PhysicalPaths")
        )
    }

    internal func refreshLibrary() async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(path: "/Library/Refresh", method: .post)
        )
    }

    internal func mediaUpdated(_ info: MediaUpdateInfo) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Library/Media/Updated",
                method: .post,
                body: .json(try JellyfinJSONCoder.encoder().encode(info))
            )
        )
    }

    internal func addedMovies(tmdbID: String?, imdbID: String?) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Library/Movies/Added",
                method: .post,
                queryItems: movieQueryItems(tmdbID: tmdbID, imdbID: imdbID)
            )
        )
    }

    internal func updatedMovies(tmdbID: String?, imdbID: String?) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Library/Movies/Updated",
                method: .post,
                queryItems: movieQueryItems(tmdbID: tmdbID, imdbID: imdbID)
            )
        )
    }

    internal func addedSeries(tvdbID: String?) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Library/Series/Added",
                method: .post,
                queryItems: [URLQueryItem(name: "tvdbId", value: tvdbID)]
            )
        )
    }

    internal func updatedSeries(tvdbID: String?) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Library/Series/Updated",
                method: .post,
                queryItems: [URLQueryItem(name: "tvdbId", value: tvdbID)]
            )
        )
    }

    internal func virtualFolders() async throws -> [VirtualFolderInfo] {
        try await executor.executeJSON(
            [VirtualFolderInfo].self,
            for: JellyfinRequest(path: "/Library/VirtualFolders")
        )
    }

    internal func addVirtualFolder(
        name: String?,
        collectionType: CollectionType?,
        paths: [String],
        refreshLibrary: Bool?,
        request: AddVirtualFolderRequest
    ) async throws {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("name", name)
        queryItems.appendOptional("collectionType", collectionType?.rawValue)
        queryItems.appendArray("paths", paths)
        queryItems.appendOptional("refreshLibrary", refreshLibrary)

        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Library/VirtualFolders",
                method: .post,
                queryItems: queryItems,
                body: .json(try JellyfinJSONCoder.encoder().encode(request))
            )
        )
    }

    internal func removeVirtualFolder(name: String?, refreshLibrary: Bool?) async throws {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("name", name)
        queryItems.appendOptional("refreshLibrary", refreshLibrary)

        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Library/VirtualFolders",
                method: .delete,
                queryItems: queryItems
            )
        )
    }

    internal func updateLibraryOptions(_ request: UpdateLibraryOptionsRequest) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Library/VirtualFolders/LibraryOptions",
                method: .post,
                body: .json(try JellyfinJSONCoder.encoder().encode(request))
            )
        )
    }

    internal func renameVirtualFolder(name: String?, newName: String?, refreshLibrary: Bool?) async throws {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("name", name)
        queryItems.appendOptional("newName", newName)
        queryItems.appendOptional("refreshLibrary", refreshLibrary)

        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Library/VirtualFolders/Name",
                method: .post,
                queryItems: queryItems
            )
        )
    }

    internal func addMediaPath(_ request: MediaPathRequest, refreshLibrary: Bool?) async throws {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("refreshLibrary", refreshLibrary)

        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Library/VirtualFolders/Paths",
                method: .post,
                queryItems: queryItems,
                body: .json(try JellyfinJSONCoder.encoder().encode(request))
            )
        )
    }

    internal func removeMediaPath(name: String?, path: String?, refreshLibrary: Bool?) async throws {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("name", name)
        queryItems.appendOptional("path", path)
        queryItems.appendOptional("refreshLibrary", refreshLibrary)

        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Library/VirtualFolders/Paths",
                method: .delete,
                queryItems: queryItems
            )
        )
    }

    internal func updateMediaPath(_ request: UpdateMediaPathRequest) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Library/VirtualFolders/Paths/Update",
                method: .post,
                body: .json(try JellyfinJSONCoder.encoder().encode(request))
            )
        )
    }

    private func list(path: String, queryItems: [URLQueryItem]) async throws -> BaseItemQueryResult {
        try await executor.executeJSON(
            BaseItemQueryResult.self,
            for: JellyfinRequest(path: path, queryItems: queryItems)
        )
    }

    private func userLibraryData(path: String, method: JellyfinHTTPMethod, userID: UUID?) async throws -> UserItemData {
        try await executor.executeJSON(
            UserItemData.self,
            for: JellyfinRequest(path: path, method: method, queryItems: optionalUserQueryItems(userID))
        )
    }

    private func optionalUserQueryItems(_ userID: UUID?) -> [URLQueryItem] {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("userId", userID?.uuidString)
        return queryItems
    }

    private func movieQueryItems(tmdbID: String?, imdbID: String?) -> [URLQueryItem] {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("tmdbId", tmdbID)
        queryItems.appendOptional("imdbId", imdbID)
        return queryItems
    }
}

private extension LibraryItemsQuery {
    var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = []
        items.appendOptional("userId", userID?.uuidString)
        items.appendOptional("startIndex", startIndex)
        items.appendOptional("limit", limit)
        items.appendOptional("recursive", recursive)
        items.appendOptional("searchTerm", searchTerm)
        items.appendOptional("parentId", parentID?.uuidString)
        items.appendArray("fields", fields)
        items.appendArray("excludeItemTypes", excludeItemTypes)
        items.appendArray("includeItemTypes", includeItemTypes)
        items.appendArray("filters", filters)
        items.appendOptional("isFavorite", isFavorite)
        items.appendArray("mediaTypes", mediaTypes)
        items.appendArray("sortBy", sortBy)
        items.appendArray("sortOrder", sortOrder)
        items.appendArray("genres", genres)
        items.appendArray("genreIds", genreIDs.map(\.uuidString))
        items.appendArray("tags", tags)
        items.appendArray("years", years.map(String.init))
        items.appendOptional("enableUserData", enableUserData)
        items.appendOptional("imageTypeLimit", imageTypeLimit)
        items.appendArray("enableImageTypes", enableImageTypes)
        items.appendOptional("enableImages", enableImages)
        items.appendOptional("enableTotalRecordCount", enableTotalRecordCount)
        items.appendOptional("person", person)
        items.appendArray("personIds", personIDs.map(\.uuidString))
        items.appendArray("personTypes", personTypes)
        items.appendArray("studios", studios)
        items.appendArray("studioIds", studioIDs.map(\.uuidString))
        items.appendArray("artists", artists)
        items.appendArray("artistIds", artistIDs.map(\.uuidString))
        items.appendArray("albumArtistIds", albumArtistIDs.map(\.uuidString))
        items.appendArray("ids", ids.map(\.uuidString))
        items.appendOptional("isPlayed", isPlayed)
        items.appendOptional("nameStartsWithOrGreater", nameStartsWithOrGreater)
        items.appendOptional("nameStartsWith", nameStartsWith)
        items.appendOptional("nameLessThan", nameLessThan)
        items.appendOptional("minCommunityRating", minCommunityRating)
        items.append(contentsOf: additionalQueryItems)
        return items
    }
}

private extension SimilarItemsQuery {
    var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = []
        items.appendOptional("userId", userID?.uuidString)
        items.appendOptional("limit", limit)
        items.appendArray("fields", fields)
        items.appendArray("excludeArtistIds", excludeArtistIDs.map(\.uuidString))
        items.append(contentsOf: additionalQueryItems)
        return items
    }
}

private extension LatestMediaQuery {
    var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = []
        items.appendOptional("userId", userID?.uuidString)
        items.appendOptional("parentId", parentID?.uuidString)
        items.appendArray("fields", fields)
        items.appendArray("includeItemTypes", includeItemTypes)
        items.appendOptional("isPlayed", isPlayed)
        items.appendOptional("enableImages", enableImages)
        items.appendOptional("imageTypeLimit", imageTypeLimit)
        items.appendArray("enableImageTypes", enableImageTypes)
        items.appendOptional("enableUserData", enableUserData)
        items.appendOptional("limit", limit)
        items.appendOptional("groupItems", groupItems)
        items.append(contentsOf: additionalQueryItems)
        return items
    }
}

private extension SuggestionsQuery {
    var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = []
        items.appendOptional("userId", userID?.uuidString)
        items.appendArray("mediaType", mediaTypes)
        items.appendArray("type", itemTypes)
        items.appendOptional("startIndex", startIndex)
        items.appendOptional("limit", limit)
        items.appendOptional("enableTotalRecordCount", enableTotalRecordCount)
        items.append(contentsOf: additionalQueryItems)
        return items
    }
}

private extension ResumeItemsQuery {
    var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = []
        items.appendOptional("userId", userID?.uuidString)
        items.appendOptional("startIndex", startIndex)
        items.appendOptional("limit", limit)
        items.appendOptional("searchTerm", searchTerm)
        items.appendOptional("parentId", parentID?.uuidString)
        items.appendArray("fields", fields)
        items.appendArray("mediaTypes", mediaTypes)
        items.appendOptional("enableUserData", enableUserData)
        items.appendOptional("imageTypeLimit", imageTypeLimit)
        items.appendArray("enableImageTypes", enableImageTypes)
        items.appendArray("excludeItemTypes", excludeItemTypes)
        items.appendArray("includeItemTypes", includeItemTypes)
        items.appendOptional("enableTotalRecordCount", enableTotalRecordCount)
        items.appendOptional("enableImages", enableImages)
        items.appendOptional("excludeActiveSessions", excludeActiveSessions)
        items.append(contentsOf: additionalQueryItems)
        return items
    }
}

private extension SearchHintsQuery {
    var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = []
        items.appendOptional("startIndex", startIndex)
        items.appendOptional("limit", limit)
        items.appendOptional("userId", userID?.uuidString)
        items.appendOptional("searchTerm", searchTerm)
        items.appendArray("includeItemTypes", includeItemTypes)
        items.appendArray("excludeItemTypes", excludeItemTypes)
        items.appendArray("mediaTypes", mediaTypes)
        items.appendOptional("parentId", parentID?.uuidString)
        items.appendOptional("isMovie", isMovie)
        items.appendOptional("isSeries", isSeries)
        items.appendOptional("isNews", isNews)
        items.appendOptional("isKids", isKids)
        items.appendOptional("isSports", isSports)
        items.appendOptional("includePeople", includePeople)
        items.appendOptional("includeMedia", includeMedia)
        items.appendOptional("includeGenres", includeGenres)
        items.appendOptional("includeStudios", includeStudios)
        items.appendOptional("includeArtists", includeArtists)
        items.append(contentsOf: additionalQueryItems)
        return items
    }
}

private extension UserViewsQuery {
    var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = []
        items.appendOptional("userId", userID?.uuidString)
        items.appendOptional("includeExternalContent", includeExternalContent)
        items.appendArray("presetViews", presetViews)
        items.appendOptional("includeHidden", includeHidden)
        items.append(contentsOf: additionalQueryItems)
        return items
    }
}

private extension InstantMixQuery {
    var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = []
        items.appendOptional("userId", userID?.uuidString)
        items.appendOptional("limit", limit)
        items.appendArray("fields", fields)
        items.appendOptional("enableImages", enableImages)
        items.appendOptional("enableUserData", enableUserData)
        items.appendOptional("imageTypeLimit", imageTypeLimit)
        items.appendArray("enableImageTypes", enableImageTypes)
        items.append(contentsOf: additionalQueryItems)
        return items
    }
}

private extension PlaylistItemsQuery {
    var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = []
        items.appendOptional("userId", userID?.uuidString)
        items.appendOptional("startIndex", startIndex)
        items.appendOptional("limit", limit)
        items.appendArray("fields", fields)
        items.appendOptional("enableImages", enableImages)
        items.appendOptional("enableUserData", enableUserData)
        items.appendOptional("imageTypeLimit", imageTypeLimit)
        items.appendArray("enableImageTypes", enableImageTypes)
        items.append(contentsOf: additionalQueryItems)
        return items
    }
}

private extension ThemeMediaQuery {
    var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = []
        items.appendOptional("userId", userID?.uuidString)
        items.appendOptional("inheritFromParent", inheritFromParent)
        items.appendArray("sortBy", sortBy)
        items.appendArray("sortOrder", sortOrder)
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
