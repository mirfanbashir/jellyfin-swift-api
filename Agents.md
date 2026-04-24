# Agents.md — JellyfinSwiftAPI

This file provides context and guidance for AI coding agents (e.g. GitHub Copilot Coding Agent) working on the **JellyfinSwiftAPI** Swift package.

---

## Project Overview

**JellyfinSwiftAPI** is a Swift Package Manager library that wraps the [Jellyfin](https://jellyfin.org) REST API. It is designed to be:

- **Type-safe** — all requests and responses are modelled as Swift types.
- **Modern** — built on `async`/`await` and `URLSession`.
- **Cross-platform** — targets iOS 15+, macOS 12+, tvOS 15+, and watchOS 8+.

---

## Repository Layout

```
jellyfin-swift-api/
├── Package.swift                          # SPM manifest (swift-tools-version 5.9)
├── Sources/
│   └── JellyfinSwiftAPI/
│       └── JellyfinSwiftAPI.swift         # Entry-point type; add new source files here
├── Tests/
│   └── JellyfinSwiftAPITests/
│       └── JellyfinSwiftAPITests.swift    # XCTest suite; mirror source structure
├── Agents.md                              # This file
├── README.md                              # User-facing documentation
├── LICENSE
└── .gitignore
```

---

## Development Guidelines for Agents

### Building

```bash
swift build
```

### Testing

```bash
swift test
```

All tests live under `Tests/JellyfinSwiftAPITests/`. New source files in `Sources/JellyfinSwiftAPI/` should have corresponding tests.

### Coding Conventions

- Use **Swift concurrency** (`async`/`await`) for all network operations.
- Model each Jellyfin API resource as a dedicated `struct` conforming to `Codable`.
- Group related endpoints into their own source file (e.g. `AuthAPI.swift`, `LibraryAPI.swift`).
- Prefer `throws` + typed errors over returning `Optional` where failure context matters.
- Write documentation comments (`///`) for every `public` symbol.

### Adding a New API Endpoint

1. Create `Sources/JellyfinSwiftAPI/<Domain>API.swift`.
2. Define request/response models as `Codable` structs.
3. Add an `extension JellyfinSwiftAPI` with the new async method.
4. Add corresponding tests in `Tests/JellyfinSwiftAPITests/<Domain>APITests.swift`.
5. Update `README.md` under the **Usage** section.

### Pull Request Checklist

- [ ] `swift build` succeeds with no warnings.
- [ ] `swift test` passes.
- [ ] All public symbols have doc comments.
- [ ] `README.md` updated if public API changed.
- [ ] No secrets or credentials committed.

---

## Jellyfin API Reference

- Official OpenAPI spec: <https://api.jellyfin.org>
- Jellyfin documentation: <https://jellyfin.org/docs/>
