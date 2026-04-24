import Foundation

/// Service interface for Jellyfin library browse, search, and user library endpoints.
public protocol LibraryService: JellyfinService {
    func items(_ query: LibraryItemsQuery) async throws -> BaseItemQueryResult
    func item(id: UUID, userID: UUID?) async throws -> BaseItem
    func rootFolder(userID: UUID?) async throws -> BaseItem
    func deleteItem(id: UUID) async throws
    func deleteItems(ids: [UUID]) async throws
    func itemCounts(userID: UUID?, isFavorite: Bool?) async throws -> ItemCounts
    func queryFiltersLegacy(
        userID: UUID?,
        parentID: UUID?,
        includeItemTypes: [String],
        mediaTypes: [MediaType]
    ) async throws -> QueryFiltersLegacy
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
    func ancestors(itemID: UUID, userID: UUID?) async throws -> [BaseItem]
    func similarItems(itemID: UUID, query: SimilarItemsQuery) async throws -> BaseItemQueryResult
    func similarAlbums(itemID: UUID, query: SimilarItemsQuery) async throws -> BaseItemQueryResult
    func similarArtists(itemID: UUID, query: SimilarItemsQuery) async throws -> BaseItemQueryResult
    func similarMovies(itemID: UUID, query: SimilarItemsQuery) async throws -> BaseItemQueryResult
    func similarShows(itemID: UUID, query: SimilarItemsQuery) async throws -> BaseItemQueryResult
    func similarTrailers(itemID: UUID, query: SimilarItemsQuery) async throws -> BaseItemQueryResult
    func criticReviews(itemID: UUID) async throws -> BaseItemQueryResult
    func latestMedia(_ query: LatestMediaQuery) async throws -> [BaseItem]
    func suggestions(_ query: SuggestionsQuery) async throws -> BaseItemQueryResult
    func resumeItems(_ query: ResumeItemsQuery) async throws -> BaseItemQueryResult
    func searchHints(_ query: SearchHintsQuery) async throws -> SearchHintResult
    func userViews(_ query: UserViewsQuery) async throws -> BaseItemQueryResult
    func groupingOptions(userID: UUID?) async throws -> [SpecialViewOption]
    func itemUserData(itemID: UUID, userID: UUID?) async throws -> UserItemData
    func updateItemUserData(_ userData: UserItemData, itemID: UUID, userID: UUID?) async throws -> UserItemData
    func markFavorite(itemID: UUID, userID: UUID?) async throws -> UserItemData
    func unmarkFavorite(itemID: UUID, userID: UUID?) async throws -> UserItemData
    func updateUserItemRating(itemID: UUID, userID: UUID?, likes: Bool?) async throws -> UserItemData
    func deleteUserItemRating(itemID: UUID, userID: UUID?) async throws -> UserItemData
    func createCollection(
        name: String?,
        ids: [UUID],
        parentID: UUID?,
        isLocked: Bool?
    ) async throws -> CollectionCreationResult
    func addToCollection(collectionID: UUID, ids: [UUID]) async throws
    func removeFromCollection(collectionID: UUID, ids: [UUID]) async throws
    func instantMixFromAlbum(itemID: UUID, query: InstantMixQuery) async throws -> BaseItemQueryResult
    func instantMixFromArtist(itemID: UUID, query: InstantMixQuery) async throws -> BaseItemQueryResult
    func instantMixFromArtist(id: UUID, query: InstantMixQuery) async throws -> BaseItemQueryResult
    func instantMixFromItem(itemID: UUID, query: InstantMixQuery) async throws -> BaseItemQueryResult
    func instantMixFromMusicGenre(name: String, query: InstantMixQuery) async throws -> BaseItemQueryResult
    func instantMixFromMusicGenre(id: UUID, query: InstantMixQuery) async throws -> BaseItemQueryResult
    func instantMixFromPlaylist(itemID: UUID, query: InstantMixQuery) async throws -> BaseItemQueryResult
    func instantMixFromSong(itemID: UUID, query: InstantMixQuery) async throws -> BaseItemQueryResult
    func intros(itemID: UUID, userID: UUID?) async throws -> BaseItemQueryResult
    func localTrailers(itemID: UUID, userID: UUID?) async throws -> [BaseItem]
    func specialFeatures(itemID: UUID, userID: UUID?) async throws -> [BaseItem]
    func themeMedia(itemID: UUID, query: ThemeMediaQuery) async throws -> AllThemeMediaResult
    func themeSongs(itemID: UUID, query: ThemeMediaQuery) async throws -> ThemeMediaResult
    func themeVideos(itemID: UUID, query: ThemeMediaQuery) async throws -> ThemeMediaResult
    func download(itemID: UUID) async throws -> JellyfinRawData
    func file(itemID: UUID) async throws -> JellyfinRawData
    func createPlaylist(_ request: CreatePlaylistRequest) async throws -> PlaylistCreationResult
    func playlist(id: UUID) async throws -> Playlist
    func updatePlaylist(_ request: UpdatePlaylistRequest, playlistID: UUID) async throws
    func playlistItems(playlistID: UUID, query: PlaylistItemsQuery) async throws -> BaseItemQueryResult
    func addItemsToPlaylist(playlistID: UUID, ids: [UUID], userID: UUID?) async throws
    func removeItemsFromPlaylist(playlistID: UUID, entryIDs: [String]) async throws
    func movePlaylistItem(playlistID: UUID, itemID: UUID, newIndex: Int) async throws
    func playlistUsers(playlistID: UUID) async throws -> [PlaylistUserPermission]
    func playlistUser(playlistID: UUID, userID: UUID) async throws -> PlaylistUserPermission
    func updatePlaylistUser(
        _ request: UpdatePlaylistUserRequest,
        playlistID: UUID,
        userID: UUID
    ) async throws
    func removePlaylistUser(playlistID: UUID, userID: UUID) async throws
    func libraryOptionsInfo(
        libraryContentType: CollectionType?,
        isNewLibrary: Bool?
    ) async throws -> LibraryOptionsResult
    func mediaFolders(isHidden: Bool?) async throws -> BaseItemQueryResult
    func physicalPaths() async throws -> [String]
    func refreshLibrary() async throws
    func mediaUpdated(_ info: MediaUpdateInfo) async throws
    func addedMovies(tmdbID: String?, imdbID: String?) async throws
    func updatedMovies(tmdbID: String?, imdbID: String?) async throws
    func addedSeries(tvdbID: String?) async throws
    func updatedSeries(tvdbID: String?) async throws
    func virtualFolders() async throws -> [VirtualFolderInfo]
    func addVirtualFolder(
        name: String?,
        collectionType: CollectionType?,
        paths: [String],
        refreshLibrary: Bool?,
        request: AddVirtualFolderRequest
    ) async throws
    func removeVirtualFolder(name: String?, refreshLibrary: Bool?) async throws
    func updateLibraryOptions(_ request: UpdateLibraryOptionsRequest) async throws
    func renameVirtualFolder(name: String?, newName: String?, refreshLibrary: Bool?) async throws
    func addMediaPath(_ request: MediaPathRequest, refreshLibrary: Bool?) async throws
    func removeMediaPath(name: String?, path: String?, refreshLibrary: Bool?) async throws
    func updateMediaPath(_ request: UpdateMediaPathRequest) async throws
}
