import Foundation

/// Service interface for Jellyfin library browse, search, and user library endpoints.
public protocol LibraryService: JellyfinService {
    /// Gets library items matching the supplied browse and filter query.
    func items(_ query: LibraryItemsQuery) async throws -> BaseItemQueryResult

    /// Gets a single item from the user library.
    func item(id: UUID, userID: UUID?) async throws -> BaseItem

    /// Gets the root folder for the selected user context.
    func rootFolder(userID: UUID?) async throws -> BaseItem

    /// Deletes a single item from the library and filesystem.
    func deleteItem(id: UUID) async throws

    /// Deletes multiple items from the library and filesystem.
    func deleteItems(ids: [UUID]) async throws

    /// Gets aggregate library item counts.
    func itemCounts(userID: UUID?, isFavorite: Bool?) async throws -> ItemCounts

    /// Gets legacy filter values for the supplied item scope.
    func queryFiltersLegacy(
        userID: UUID?,
        parentID: UUID?,
        includeItemTypes: [String],
        mediaTypes: [MediaType]
    ) async throws -> QueryFiltersLegacy

    /// Gets filter values for the supplied item scope using the newer filters endpoint.
    func queryFilters(
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
    ) async throws -> QueryFilters

    /// Gets ancestor items for a library item.
    func ancestors(itemID: UUID, userID: UUID?) async throws -> [BaseItem]

    /// Gets items similar to the supplied item.
    func similarItems(itemID: UUID, query: SimilarItemsQuery) async throws -> BaseItemQueryResult

    /// Gets albums similar to the supplied album.
    func similarAlbums(itemID: UUID, query: SimilarItemsQuery) async throws -> BaseItemQueryResult

    /// Gets artists similar to the supplied artist.
    func similarArtists(itemID: UUID, query: SimilarItemsQuery) async throws -> BaseItemQueryResult

    /// Gets movies similar to the supplied movie.
    func similarMovies(itemID: UUID, query: SimilarItemsQuery) async throws -> BaseItemQueryResult

    /// Gets shows similar to the supplied show.
    func similarShows(itemID: UUID, query: SimilarItemsQuery) async throws -> BaseItemQueryResult

    /// Gets trailers similar to the supplied trailer.
    func similarTrailers(itemID: UUID, query: SimilarItemsQuery) async throws -> BaseItemQueryResult

    /// Gets critic reviews for an item.
    func criticReviews(itemID: UUID) async throws -> BaseItemQueryResult

    /// Gets the latest media items for the supplied filters.
    func latestMedia(_ query: LatestMediaQuery) async throws -> [BaseItem]

    /// Gets item suggestions for the supplied filters.
    func suggestions(_ query: SuggestionsQuery) async throws -> BaseItemQueryResult

    /// Gets resume items for the supplied user context.
    func resumeItems(_ query: ResumeItemsQuery) async throws -> BaseItemQueryResult

    /// Gets search hints for an in-progress search term.
    func searchHints(_ query: SearchHintsQuery) async throws -> SearchHintResult

    /// Gets top-level user views such as libraries and special folders.
    func userViews(_ query: UserViewsQuery) async throws -> BaseItemQueryResult

    /// Gets special grouping options for the selected user context.
    func groupingOptions(userID: UUID?) async throws -> [SpecialViewOption]

    /// Gets per-user item data for an item.
    func itemUserData(itemID: UUID, userID: UUID?) async throws -> UserItemData

    /// Replaces per-user item data for an item.
    func updateItemUserData(_ userData: UserItemData, itemID: UUID, userID: UUID?) async throws -> UserItemData

    /// Marks an item as a favorite for a user.
    func markFavorite(itemID: UUID, userID: UUID?) async throws -> UserItemData

    /// Removes an item from a user's favorites.
    func unmarkFavorite(itemID: UUID, userID: UUID?) async throws -> UserItemData

    /// Sets or clears a like/dislike rating for a user item.
    func updateUserItemRating(itemID: UUID, userID: UUID?, likes: Bool?) async throws -> UserItemData

    /// Deletes a user rating for an item.
    func deleteUserItemRating(itemID: UUID, userID: UUID?) async throws -> UserItemData

    /// Creates a collection from a set of existing library items.
    func createCollection(
        name: String?,
        ids: [UUID],
        parentID: UUID?,
        isLocked: Bool?
    ) async throws -> CollectionCreationResult

    /// Adds items to an existing collection.
    func addToCollection(collectionID: UUID, ids: [UUID]) async throws

    /// Removes items from an existing collection.
    func removeFromCollection(collectionID: UUID, ids: [UUID]) async throws

    /// Builds an instant mix from an album.
    func instantMixFromAlbum(itemID: UUID, query: InstantMixQuery) async throws -> BaseItemQueryResult

    /// Builds an instant mix from an artist item identifier.
    func instantMixFromArtist(itemID: UUID, query: InstantMixQuery) async throws -> BaseItemQueryResult

    /// Builds an instant mix from an artist using the alternate artist-mix route.
    func instantMixFromArtist(id: UUID, query: InstantMixQuery) async throws -> BaseItemQueryResult

    /// Builds an instant mix from a library item.
    func instantMixFromItem(itemID: UUID, query: InstantMixQuery) async throws -> BaseItemQueryResult

    /// Builds an instant mix from a music genre name.
    func instantMixFromMusicGenre(name: String, query: InstantMixQuery) async throws -> BaseItemQueryResult

    /// Builds an instant mix from a music genre identifier.
    func instantMixFromMusicGenre(id: UUID, query: InstantMixQuery) async throws -> BaseItemQueryResult

    /// Builds an instant mix from a playlist.
    func instantMixFromPlaylist(itemID: UUID, query: InstantMixQuery) async throws -> BaseItemQueryResult

    /// Builds an instant mix from a song.
    func instantMixFromSong(itemID: UUID, query: InstantMixQuery) async throws -> BaseItemQueryResult

    /// Gets intro videos for an item.
    func intros(itemID: UUID, userID: UUID?) async throws -> BaseItemQueryResult

    /// Gets local trailer items for an item.
    func localTrailers(itemID: UUID, userID: UUID?) async throws -> [BaseItem]

    /// Gets special feature items for an item.
    func specialFeatures(itemID: UUID, userID: UUID?) async throws -> [BaseItem]

    /// Gets all available theme media for an item.
    func themeMedia(itemID: UUID, query: ThemeMediaQuery) async throws -> AllThemeMediaResult

    /// Gets theme songs for an item.
    func themeSongs(itemID: UUID, query: ThemeMediaQuery) async throws -> ThemeMediaResult

    /// Gets theme videos for an item.
    func themeVideos(itemID: UUID, query: ThemeMediaQuery) async throws -> ThemeMediaResult

    /// Downloads an item through Jellyfin's download endpoint.
    func download(itemID: UUID) async throws -> JellyfinRawData

    /// Downloads an item's underlying file through Jellyfin's file endpoint.
    func file(itemID: UUID) async throws -> JellyfinRawData

    /// Creates a playlist.
    func createPlaylist(_ request: CreatePlaylistRequest) async throws -> PlaylistCreationResult

    /// Gets a playlist by identifier.
    func playlist(id: UUID) async throws -> Playlist

    /// Updates playlist metadata and ordering settings.
    func updatePlaylist(_ request: UpdatePlaylistRequest, playlistID: UUID) async throws

    /// Gets items contained in a playlist.
    func playlistItems(playlistID: UUID, query: PlaylistItemsQuery) async throws -> BaseItemQueryResult

    /// Adds items to a playlist.
    func addItemsToPlaylist(playlistID: UUID, ids: [UUID], userID: UUID?) async throws

    /// Removes playlist entries by playlist entry identifier.
    func removeItemsFromPlaylist(playlistID: UUID, entryIDs: [String]) async throws

    /// Moves a playlist item to a new index.
    func movePlaylistItem(playlistID: UUID, itemID: UUID, newIndex: Int) async throws

    /// Gets all playlist user permissions.
    func playlistUsers(playlistID: UUID) async throws -> [PlaylistUserPermission]

    /// Gets playlist permissions for a single user.
    func playlistUser(playlistID: UUID, userID: UUID) async throws -> PlaylistUserPermission

    /// Updates playlist permissions for a single user.
    func updatePlaylistUser(
        _ request: UpdatePlaylistUserRequest,
        playlistID: UUID,
        userID: UUID
    ) async throws

    /// Removes a user's explicit playlist permissions.
    func removePlaylistUser(playlistID: UUID, userID: UUID) async throws

    /// Gets available library option metadata for a content type.
    func libraryOptionsInfo(
        libraryContentType: CollectionType?,
        isNewLibrary: Bool?
    ) async throws -> LibraryOptionsResult

    /// Gets media folders, optionally including hidden folders.
    func mediaFolders(isHidden: Bool?) async throws -> BaseItemQueryResult

    /// Gets physical filesystem paths available to the server.
    func physicalPaths() async throws -> [String]

    /// Starts a library refresh.
    func refreshLibrary() async throws

    /// Notifies Jellyfin that media has been updated.
    func mediaUpdated(_ info: MediaUpdateInfo) async throws

    /// Notifies Jellyfin that a movie was added, optionally with external ids.
    func addedMovies(tmdbID: String?, imdbID: String?) async throws

    /// Notifies Jellyfin that a movie was updated, optionally with external ids.
    func updatedMovies(tmdbID: String?, imdbID: String?) async throws

    /// Notifies Jellyfin that a series was added.
    func addedSeries(tvdbID: String?) async throws

    /// Notifies Jellyfin that a series was updated.
    func updatedSeries(tvdbID: String?) async throws

    /// Gets configured virtual folders.
    func virtualFolders() async throws -> [VirtualFolderInfo]

    /// Creates a virtual folder and optionally refreshes the library.
    func addVirtualFolder(
        name: String?,
        collectionType: CollectionType?,
        paths: [String],
        refreshLibrary: Bool?,
        request: AddVirtualFolderRequest
    ) async throws

    /// Removes a virtual folder and optionally refreshes the library.
    func removeVirtualFolder(name: String?, refreshLibrary: Bool?) async throws

    /// Updates library options for a virtual folder.
    func updateLibraryOptions(_ request: UpdateLibraryOptionsRequest) async throws

    /// Renames a virtual folder and optionally refreshes the library.
    func renameVirtualFolder(name: String?, newName: String?, refreshLibrary: Bool?) async throws

    /// Adds a media path to a virtual folder and optionally refreshes the library.
    func addMediaPath(_ request: MediaPathRequest, refreshLibrary: Bool?) async throws

    /// Removes a media path from a virtual folder and optionally refreshes the library.
    func removeMediaPath(name: String?, path: String?, refreshLibrary: Bool?) async throws

    /// Updates an existing media path entry.
    func updateMediaPath(_ request: UpdateMediaPathRequest) async throws
}
