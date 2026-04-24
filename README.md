# JellyfinSwiftAPI

A Swift package that provides a type-safe, async/await-based client for the [Jellyfin](https://jellyfin.org) Media Server REST API.

> **Status:** Service-first client surface implemented across authentication, users, sessions, library, catalog, metadata, images, playback, Live TV, system, and administration APIs.

---

## Requirements

| Platform | Minimum Version |
|----------|----------------|
| iOS      | 15.0           |
| macOS    | 12.0           |
| tvOS     | 15.0           |
| watchOS  | 8.0            |

- Swift 5.9+
- Xcode 15+
- Linux with Swift Foundation / FoundationNetworking

---

## Installation

### Swift Package Manager

Add the package to your `Package.swift` dependencies:

```swift
dependencies: [
    .package(url: "https://github.com/mirfanbashir/jellyfin-swift-api.git", from: "0.1.0"),
]
```

Then add `"JellyfinSwiftAPI"` to your target's dependencies:

```swift
.target(
    name: "MyApp",
    dependencies: ["JellyfinSwiftAPI"]
),
```

Or add it via **Xcode → File → Add Package Dependencies…** and paste the repository URL.

---

## Usage

```swift
import JellyfinSwiftAPI

let client = JellyfinSwiftAPI(serverURL: URL(string: "https://jellyfin.example.com")!)
let authenticationService: any AuthenticationService = client.authentication
let catalogService: any CatalogService = client.catalog
let sessionsService: any SessionsService = client.sessions
let imagesService: any ImagesService = client.images
let libraryService: any LibraryService = client.library
let playbackService: any PlaybackService = client.playback
let liveTVService: any LiveTVService = client.liveTV
let administrationService: any AdministrationService = client.administration
let metadataService: any MetadataService = client.metadata
let systemService: any SystemService = client.system
let usersService: any UsersService = client.users

let authenticatedClient = JellyfinSwiftAPI(
    serverURL: URL(string: "https://jellyfin.example.com")!,
    authorization: .header("<Authorization header value>")
)

let publicInfo = try await client.system.publicSystemInfo()
let artists = try await authenticatedClient.catalog.artists(CatalogQuery(limit: 20))
let poster = try await authenticatedClient.images.itemImage(
    itemID: UUID(uuidString: "D2C48876-BD8F-4D6A-8734-712267F7F9F6")!,
    type: .primary,
    query: ImageRequestOptions(maxWidth: 600)
)
let playbackInfo = try await authenticatedClient.playback.playbackInfo(
    itemID: UUID(uuidString: "D2C48876-BD8F-4D6A-8734-712267F7F9F6")!,
    userID: nil
)
let liveTVInfo = try await authenticatedClient.liveTV.liveTVInfo()
let configuration = try await authenticatedClient.administration.serverConfiguration()
let libraryItems = try await authenticatedClient.library.items(
    LibraryItemsQuery(limit: 20, includeItemTypes: ["Movie"])
)
let externalIDs = try await authenticatedClient.metadata.externalIDInfos(
    itemID: UUID(uuidString: "5F6D5A13-4B25-4F8D-B9FB-A3B4699EF301")!
)
let serverInfo = try await authenticatedClient.system.systemInfo()
let providers = try await authenticatedClient.authentication.authProviders()
let activeSessions = try await authenticatedClient.sessions.sessions(SessionQuery(activeWithinSeconds: 300))
let currentUser = try await authenticatedClient.users.currentUser()
```

`JellyfinSwiftAPI` is `Sendable`, exposes protocol-typed services, and keeps concrete implementations internal to the package. The transport layer is prepared for Apple platforms and Linux.

## Included services

The root client exposes 11 protocol-typed service groups:

- `authentication`
- `catalog`
- `sessions`
- `library`
- `images`
- `playback`
- `liveTV`
- `administration`
- `metadata`
- `system`
- `users`

## Notes

- Public API surface is service-first: consumers access `client.system`, `client.playback`, `client.sessions`, and the other domain services from the root client.
- `JellyfinSwiftAPI` keeps concrete implementations internal to the package.
- For contributor and maintainer documentation, see [MAINTAINERS.md](MAINTAINERS.md).

---

## Contributing

1. Fork the repository and create your feature branch (`git checkout -b feature/my-feature`).
2. Make your changes and add tests.
3. Run the test suite: `swift test`.
4. Review [MAINTAINERS.md](MAINTAINERS.md) for development workflow details.
5. Open a Pull Request.

---

## License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.
