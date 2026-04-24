import Foundation

internal struct ImagesServiceClient: ImagesService {
    private let executor: JellyfinRequestExecutor

    internal init(executor: JellyfinRequestExecutor) {
        self.executor = executor
    }

    internal func itemImageInfos(itemID: UUID) async throws -> [ImageInfo] {
        try await executor.executeJSON(
            [ImageInfo].self,
            for: JellyfinRequest(path: "/Items/\(itemID.uuidString)/Images")
        )
    }

    internal func itemImage(
        itemID: UUID,
        type: ImageType,
        query: ImageRequestOptions = ImageRequestOptions()
    ) async throws -> JellyfinRawData {
        try await raw(path: "/Items/\(itemID.uuidString)/Images/\(type.rawValue)", queryItems: query.queryItems)
    }

    internal func headItemImage(
        itemID: UUID,
        type: ImageType,
        query: ImageRequestOptions = ImageRequestOptions()
    ) async throws {
        try await head(path: "/Items/\(itemID.uuidString)/Images/\(type.rawValue)", queryItems: query.queryItems)
    }

    internal func itemImage(
        itemID: UUID,
        type: ImageType,
        imageIndex: Int,
        query: ImageRequestOptions = ImageRequestOptions()
    ) async throws -> JellyfinRawData {
        try await raw(
            path: "/Items/\(itemID.uuidString)/Images/\(type.rawValue)/\(imageIndex)",
            queryItems: query.queryItems
        )
    }

    internal func headItemImage(
        itemID: UUID,
        type: ImageType,
        imageIndex: Int,
        query: ImageRequestOptions = ImageRequestOptions()
    ) async throws {
        try await head(
            path: "/Items/\(itemID.uuidString)/Images/\(type.rawValue)/\(imageIndex)",
            queryItems: query.queryItems
        )
    }

    internal func versionedItemImage(_ request: VersionedItemImageRequest) async throws -> JellyfinRawData {
        try await raw(path: request.path, queryItems: request.query.queryItemsWithoutPathFields)
    }

    internal func headVersionedItemImage(_ request: VersionedItemImageRequest) async throws {
        try await head(path: request.path, queryItems: request.query.queryItemsWithoutPathFields)
    }

    internal func setItemImage(itemID: UUID, type: ImageType, data: Data, contentType: String) async throws {
        try await upload(
            path: "/Items/\(itemID.uuidString)/Images/\(type.rawValue)",
            data: data,
            contentType: contentType
        )
    }

    internal func setItemImage(
        itemID: UUID,
        type: ImageType,
        imageIndex: Int,
        data: Data,
        contentType: String
    ) async throws {
        try await upload(
            path: "/Items/\(itemID.uuidString)/Images/\(type.rawValue)/\(imageIndex)",
            data: data,
            contentType: contentType
        )
    }

    internal func deleteItemImage(itemID: UUID, type: ImageType, imageIndex: Int?) async throws {
        let path = if let imageIndex {
            "/Items/\(itemID.uuidString)/Images/\(type.rawValue)/\(imageIndex)"
        } else {
            "/Items/\(itemID.uuidString)/Images/\(type.rawValue)"
        }
        let queryItems = imageIndex == nil ? [URLQueryItem]() : []

        try await executor.executeEmpty(
            for: JellyfinRequest(path: path, method: .delete, queryItems: queryItems)
        )
    }

    internal func updateItemImageIndex(itemID: UUID, type: ImageType, imageIndex: Int, newIndex: Int) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: "/Items/\(itemID.uuidString)/Images/\(type.rawValue)/\(imageIndex)/Index",
                method: .post,
                queryItems: [URLQueryItem(name: "newIndex", value: String(newIndex))]
            )
        )
    }

    internal func image(
        resource: NamedImageResource,
        named name: String,
        type: ImageType,
        imageIndex: Int?,
        query: ImageRequestOptions = ImageRequestOptions()
    ) async throws -> JellyfinRawData {
        let path = namedResourcePath(resource: resource, name: name, type: type, imageIndex: imageIndex)
        return try await raw(path: path, queryItems: query.queryItems)
    }

    internal func headImage(
        resource: NamedImageResource,
        named name: String,
        type: ImageType,
        imageIndex: Int?,
        query: ImageRequestOptions = ImageRequestOptions()
    ) async throws {
        let path = namedResourcePath(resource: resource, name: name, type: type, imageIndex: imageIndex)
        try await head(path: path, queryItems: query.queryItems)
    }

    internal func userImage(userID: UUID?, tag: String?, format: ImageFormat?) async throws -> JellyfinRawData {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("userId", userID?.uuidString)
        queryItems.appendOptional("tag", tag)
        queryItems.appendOptional("format", format?.rawValue)
        return try await raw(path: "/UserImage", queryItems: queryItems)
    }

    internal func headUserImage(userID: UUID?, tag: String?, format: ImageFormat?) async throws {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("userId", userID?.uuidString)
        queryItems.appendOptional("tag", tag)
        queryItems.appendOptional("format", format?.rawValue)
        try await head(path: "/UserImage", queryItems: queryItems)
    }

    internal func postUserImage(userID: UUID?, data: Data, contentType: String) async throws {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("userId", userID?.uuidString)
        try await upload(path: "/UserImage", queryItems: queryItems, data: data, contentType: contentType)
    }

    internal func deleteUserImage() async throws {
        try await executor.executeEmpty(for: JellyfinRequest(path: "/UserImage", method: .delete))
    }

    internal func splashscreen(tag: String?, format: ImageFormat?) async throws -> JellyfinRawData {
        var queryItems: [URLQueryItem] = []
        queryItems.appendOptional("tag", tag)
        queryItems.appendOptional("format", format?.rawValue)
        return try await raw(path: "/Branding/Splashscreen", queryItems: queryItems)
    }

    internal func uploadSplashscreen(data: Data, contentType: String) async throws {
        try await upload(path: "/Branding/Splashscreen", data: data, contentType: contentType)
    }

    internal func deleteSplashscreen() async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(path: "/Branding/Splashscreen", method: .delete)
        )
    }

    private func raw(path: String, queryItems: [URLQueryItem]) async throws -> JellyfinRawData {
        let response = try await executor.executeData(for: JellyfinRequest(path: path, queryItems: queryItems))
        return JellyfinRawData(data: response.data, mimeType: response.mimeType, statusCode: response.statusCode)
    }

    private func head(path: String, queryItems: [URLQueryItem]) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(path: path, method: .head, queryItems: queryItems)
        )
    }

    private func upload(
        path: String,
        queryItems: [URLQueryItem] = [],
        data: Data,
        contentType: String
    ) async throws {
        try await executor.executeEmpty(
            for: JellyfinRequest(
                path: path,
                method: .post,
                queryItems: queryItems,
                body: .raw(data, contentType: contentType)
            )
        )
    }

    private func namedResourcePath(
        resource: NamedImageResource,
        name: String,
        type: ImageType,
        imageIndex: Int?
    ) -> String {
        if let imageIndex {
            return "/\(resource.rawValue)/\(name)/Images/\(type.rawValue)/\(imageIndex)"
        }
        return "/\(resource.rawValue)/\(name)/Images/\(type.rawValue)"
    }
}

private extension ImageRequestOptions {
    var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = []
        items.appendOptional("tag", tag)
        items.appendOptional("format", format?.rawValue)
        items.appendOptional("maxWidth", maxWidth)
        items.appendOptional("maxHeight", maxHeight)
        items.appendOptional("percentPlayed", percentPlayed)
        items.appendOptional("unplayedCount", unplayedCount)
        items.appendOptional("width", width)
        items.appendOptional("height", height)
        items.appendOptional("quality", quality)
        items.appendOptional("fillWidth", fillWidth)
        items.appendOptional("fillHeight", fillHeight)
        items.appendOptional("blur", blur)
        items.appendOptional("backgroundColor", backgroundColor)
        items.appendOptional("foregroundLayer", foregroundLayer)
        items.appendOptional("imageIndex", imageIndex)
        items.append(contentsOf: additionalQueryItems)
        return items
    }

    var queryItemsWithoutPathFields: [URLQueryItem] {
        var copy = self
        copy.tag = nil
        copy.format = nil
        copy.maxWidth = nil
        copy.maxHeight = nil
        copy.percentPlayed = nil
        copy.unplayedCount = nil
        copy.imageIndex = nil
        return copy.queryItems
    }
}

private extension VersionedItemImageRequest {
    var path: String {
        "/Items/\(itemID.uuidString)/Images/\(type.rawValue)/\(imageIndex)/\(tag)/\(format.rawValue)/\(maxWidth)/\(maxHeight)/\(percentPlayed)/\(unplayedCount)"
    }
}

private extension Array where Element == URLQueryItem {
    mutating func appendOptional<T: CustomStringConvertible>(_ name: String, _ value: T?) {
        guard let value else { return }
        append(URLQueryItem(name: name, value: value.description))
    }
}
