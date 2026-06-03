import Foundation

/// Service interface for Jellyfin image retrieval, upload, and deletion endpoints.
public protocol ImagesService: JellyfinService {
    /// Gets image metadata for an item.
    func itemImageInfos(itemID: UUID) async throws -> [ImageInfo]

    /// Gets the primary image resource for an item and image type.
    func itemImage(itemID: UUID, type: ImageType, query: ImageRequestOptions) async throws -> JellyfinRawData

    /// Issues a `HEAD` request for an item's primary image resource.
    func headItemImage(itemID: UUID, type: ImageType, query: ImageRequestOptions) async throws

    /// Gets a specific indexed image resource for an item and image type.
    func itemImage(itemID: UUID, type: ImageType, imageIndex: Int, query: ImageRequestOptions) async throws -> JellyfinRawData

    /// Issues a `HEAD` request for a specific indexed item image.
    func headItemImage(itemID: UUID, type: ImageType, imageIndex: Int, query: ImageRequestOptions) async throws

    /// Gets a versioned item image using Jellyfin's cache-friendly image route.
    func versionedItemImage(_ request: VersionedItemImageRequest) async throws -> JellyfinRawData

    /// Issues a `HEAD` request for a versioned item image.
    func headVersionedItemImage(_ request: VersionedItemImageRequest) async throws

    /// Uploads or replaces the primary image for an item and image type.
    func setItemImage(itemID: UUID, type: ImageType, data: Data, contentType: String) async throws

    /// Uploads or replaces a specific indexed image for an item and image type.
    func setItemImage(itemID: UUID, type: ImageType, imageIndex: Int, data: Data, contentType: String) async throws

    /// Deletes an item image, optionally targeting a specific image index.
    func deleteItemImage(itemID: UUID, type: ImageType, imageIndex: Int?) async throws

    /// Reorders an indexed item image to a new position.
    func updateItemImageIndex(itemID: UUID, type: ImageType, imageIndex: Int, newIndex: Int) async throws

    /// Gets an image for a named catalog resource such as an artist, genre, music genre, or studio.
    func image(
        resource: NamedImageResource,
        named name: String,
        type: ImageType,
        imageIndex: Int?,
        query: ImageRequestOptions
    ) async throws -> JellyfinRawData

    /// Issues a `HEAD` request for a named catalog resource image.
    func headImage(
        resource: NamedImageResource,
        named name: String,
        type: ImageType,
        imageIndex: Int?,
        query: ImageRequestOptions
    ) async throws

    /// Gets the current user's image or an explicitly selected user's image.
    func userImage(userID: UUID?, tag: String?, format: ImageFormat?) async throws -> JellyfinRawData

    /// Issues a `HEAD` request for a user image.
    func headUserImage(userID: UUID?, tag: String?, format: ImageFormat?) async throws

    /// Uploads or replaces a user image.
    func postUserImage(userID: UUID?, data: Data, contentType: String) async throws

    /// Deletes the current user's image.
    func deleteUserImage() async throws

    /// Gets the server splashscreen image.
    func splashscreen(tag: String?, format: ImageFormat?) async throws -> JellyfinRawData

    /// Uploads or replaces the server splashscreen image.
    func uploadSplashscreen(data: Data, contentType: String) async throws

    /// Deletes the server splashscreen image.
    func deleteSplashscreen() async throws
}
