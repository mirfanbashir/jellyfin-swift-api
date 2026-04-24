# Maintainers README

This document is for contributors and maintainers of `JellyfinSwiftAPI`.

## Development commands

```bash
swift build
swift test
```

## Package structure

- `Sources/JellyfinSwiftAPI/` contains the public service protocols, public models, and internal runtime/service implementations.
- `Tests/JellyfinSwiftAPITests/` contains fixture-backed decoding tests and request-construction tests organized by service area.
- `Scripts/` contains OpenAPI maintenance tooling used to keep the package aligned with Jellyfin's published API surface.

## OpenAPI workflow

The package exposes a service-first Swift API, while Jellyfin publishes a large tag-based OpenAPI document. The scripts in `Scripts/` exist to keep those two views aligned.

### Service mapping inventory

`openapi_service_map.json` defines how upstream OpenAPI tags and operation IDs map onto this package's public services.

`openapi_inventory.py` classifies every OpenAPI operation into exactly one public service and fails if any operation is unassigned or ambiguous.

```bash
python3 Scripts/openapi_inventory.py \
  --spec https://api.jellyfin.org/openapi/jellyfin-openapi-stable.json \
  --output /tmp/jellyfin-openapi-inventory.json
```

Use it when:

- the upstream Jellyfin spec changes
- adding a new service area
- validating coverage after larger API additions

### Schema catalog

`openapi_schema_catalog.py` builds a Swift-facing schema inventory from the OpenAPI document.

```bash
python3 Scripts/openapi_schema_catalog.py \
  --spec https://api.jellyfin.org/openapi/jellyfin-openapi-stable.json \
  --output /tmp/jellyfin-openapi-schema-catalog.json
```

It helps identify:

- schema naming collisions
- `oneOf` schemas that need manual handling
- primitive and format mappings
- schema dependency relationships

Schema overrides live in `openapi_schema_overrides.json`.

## Service boundaries

The root client currently exposes these service groups:

- `AuthenticationService`
- `UsersService`
- `SessionsService`
- `LibraryService`
- `CatalogService`
- `MetadataService`
- `ImagesService`
- `PlaybackService`
- `LiveTVService`
- `SystemService`
- `AdministrationService`

## Testing approach

- Keep tests under `Tests/JellyfinSwiftAPITests/<Service>/`.
- Keep fixtures under `Tests/JellyfinSwiftAPITests/Fixtures/<Service>/`.
- Prefer transport-mocked request-construction tests for path, query, header, and body validation.
- Prefer fixture-backed decoding tests for representative JSON payloads.
