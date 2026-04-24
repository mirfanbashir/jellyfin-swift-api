# JellyfinSwiftAPI

A Swift package that provides a type-safe, async/await-based client for the [Jellyfin](https://jellyfin.org) Media Server REST API.

> **Status:** Early development — foundational package structure is in place; API endpoints will be implemented progressively.

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
```

More API methods (authentication, library browsing, playback, etc.) will be added in upcoming releases.

---

## Contributing

1. Fork the repository and create your feature branch (`git checkout -b feature/my-feature`).
2. Make your changes and add tests.
3. Run the test suite: `swift test`.
4. Open a Pull Request.

---

## License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.
