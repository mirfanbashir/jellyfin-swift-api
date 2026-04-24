import Foundation

/// Service interface for Jellyfin image retrieval, upload, and deletion endpoints.
public protocol ImagesService: JellyfinService {
    func itemImageInfos(itemID: UUID) async throws -> [ImageInfo]
    func itemImage(itemID: UUID, type: ImageType, query: ImageRequestOptions) async throws -> JellyfinRawData
    func headItemImage(itemID: UUID, type: ImageType, query: ImageRequestOptions) async throws
    func itemImage(itemID: UUID, type: ImageType, imageIndex: Int, query: ImageRequestOptions) async throws -> JellyfinRawData
    func headItemImage(itemID: UUID, type: ImageType, imageIndex: Int, query: ImageRequestOptions) async throws
    func versionedItemImage(_ request: VersionedItemImageRequest) async throws -> JellyfinRawData
    func headVersionedItemImage(_ request: VersionedItemImageRequest) async throws
    func setItemImage(itemID: UUID, type: ImageType, data: Data, contentType: String) async throws
    func setItemImage(itemID: UUID, type: ImageType, imageIndex: Int, data: Data, contentType: String) async throws
    func deleteItemImage(itemID: UUID, type: ImageType, imageIndex: Int?) async throws
    func updateItemImageIndex(itemID: UUID, type: ImageType, imageIndex: Int, newIndex: Int) async throws
    func image(
        resource: NamedImageResource,
        named name: String,
        type: ImageType,
        imageIndex: Int?,
        query: ImageRequestOptions
    ) async throws -> JellyfinRawData
    func headImage(
        resource: NamedImageResource,
        named name: String,
        type: ImageType,
        imageIndex: Int?,
        query: ImageRequestOptions
    ) async throws
    func userImage(userID: UUID?, tag: String?, format: ImageFormat?) async throws -> JellyfinRawData
    func headUserImage(userID: UUID?, tag: String?, format: ImageFormat?) async throws
    func postUserImage(userID: UUID?, data: Data, contentType: String) async throws
    func deleteUserImage() async throws
    func splashscreen(tag: String?, format: ImageFormat?) async throws -> JellyfinRawData
    func uploadSplashscreen(data: Data, contentType: String) async throws
    func deleteSplashscreen() async throws
}
