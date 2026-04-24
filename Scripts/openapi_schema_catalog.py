#!/usr/bin/env python3

from __future__ import annotations

import argparse
import json
import pathlib
import re
import sys
import urllib.request
from collections import Counter, defaultdict
from typing import Any

SWIFT_KEYWORDS = {
    "associatedtype",
    "class",
    "deinit",
    "enum",
    "extension",
    "fileprivate",
    "func",
    "import",
    "init",
    "inout",
    "internal",
    "let",
    "open",
    "operator",
    "private",
    "protocol",
    "public",
    "rethrows",
    "static",
    "struct",
    "subscript",
    "typealias",
    "var",
}


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Normalize Jellyfin OpenAPI schemas into a Swift-facing model catalog."
    )
    parser.add_argument(
        "--spec",
        required=True,
        help="Path or URL to the OpenAPI JSON document.",
    )
    parser.add_argument(
        "--overrides",
        default=str(pathlib.Path(__file__).with_name("openapi_schema_overrides.json")),
        help="Path to the schema override configuration JSON.",
    )
    parser.add_argument(
        "--output",
        help="Optional path to write the generated schema catalog JSON.",
    )
    return parser.parse_args()


def load_json(source: str) -> dict[str, Any]:
    if source.startswith(("http://", "https://")):
        with urllib.request.urlopen(source) as response:
            return json.load(response)

    return json.loads(pathlib.Path(source).read_text())


def normalize_swift_type_name(name: str, schema_renames: dict[str, str]) -> str:
    renamed = schema_renames.get(name, name)
    parts = re.split(r"[^0-9A-Za-z]+", renamed)
    pieces: list[str] = []

    for part in parts:
        if not part:
            continue
        if part.isupper() and len(part) > 1:
            pieces.append(part.title())
        else:
            pieces.append(part[0].upper() + part[1:])

    normalized = "".join(pieces) or "UnnamedSchema"

    if normalized[0].isdigit():
        normalized = "_" + normalized

    if normalized.lower() in SWIFT_KEYWORDS:
        normalized += "Value"

    return normalized


def schema_kind(schema: dict[str, Any]) -> str:
    if "oneOf" in schema:
        return "oneOf"
    if "allOf" in schema:
        return "allOf"
    if "anyOf" in schema:
        return "anyOf"
    if "enum" in schema:
        return "enum"
    if "$ref" in schema:
        return "reference"
    if schema.get("type") == "array" or "items" in schema:
        return "array"
    if schema.get("type") == "object" or "properties" in schema or "additionalProperties" in schema:
        return "object"
    return "primitive"


def collect_refs(value: Any) -> list[str]:
    refs: list[str] = []

    if isinstance(value, dict):
        ref = value.get("$ref")
        if ref:
            refs.append(ref.split("/")[-1])
        for nested_value in value.values():
            refs.extend(collect_refs(nested_value))
    elif isinstance(value, list):
        for entry in value:
            refs.extend(collect_refs(entry))

    return refs


def resolve_format_mapping(
    schema: dict[str, Any], format_mappings: list[dict[str, str]]
) -> str | None:
    schema_type = schema.get("type")
    schema_format = schema.get("format")

    for mapping in format_mappings:
        if mapping["openapiType"] != schema_type:
            continue
        if mapping.get("format") != schema_format:
            continue
        return mapping["swiftType"]

    for mapping in format_mappings:
        if mapping["openapiType"] == schema_type and "format" not in mapping:
            return mapping["swiftType"]

    return None


def build_schema_catalog(
    spec: dict[str, Any], overrides: dict[str, Any]
) -> tuple[dict[str, Any], list[str]]:
    schemas = spec.get("components", {}).get("schemas", {})
    schema_renames = overrides.get("schemaRenames", {})
    format_mappings = overrides.get("formatMappings", [])
    manual_schemas = overrides.get("manualSchemas", {})

    descriptors: list[dict[str, Any]] = []
    collisions: defaultdict[str, list[str]] = defaultdict(list)
    issues: list[str] = []

    for schema_name, schema in schemas.items():
        swift_type_name = normalize_swift_type_name(schema_name, schema_renames)
        collisions[swift_type_name].append(schema_name)
        kind = schema_kind(schema)
        reference_dependencies = sorted(set(collect_refs(schema)))
        manual_handling = manual_schemas.get(schema_name)

        if kind == "oneOf" and schema_name not in manual_schemas:
            issues.append(f"Missing manual schema override for oneOf schema: {schema_name}")

        descriptor = {
            "openapiName": schema_name,
            "swiftTypeName": swift_type_name,
            "kind": kind,
            "nullable": bool(schema.get("nullable")),
            "propertyCount": len(schema.get("properties", {})),
            "requiredProperties": sorted(schema.get("required", [])),
            "nullablePropertyCount": sum(
                1
                for prop in (schema.get("properties") or {}).values()
                if prop.get("nullable")
            ),
            "enumValues": schema.get("enum", []),
            "referenceDependencies": reference_dependencies,
            "manualHandling": manual_handling,
            "swiftPrimitiveType": resolve_format_mapping(schema, format_mappings),
        }
        descriptors.append(descriptor)

    collision_groups = {
        swift_type_name: sorted(original_names)
        for swift_type_name, original_names in collisions.items()
        if len(original_names) > 1
    }

    if collision_groups:
        for swift_type_name, original_names in collision_groups.items():
            issues.append(
                f"Swift type name collision for {swift_type_name}: {', '.join(original_names)}"
            )

    summary = {
        "schemaCount": len(descriptors),
        "kindCounts": dict(sorted(Counter(item["kind"] for item in descriptors).items())),
        "manualSchemaCount": len(manual_schemas),
        "collisionCount": len(collision_groups),
        "issueCount": len(issues),
    }

    catalog = {
        "summary": summary,
        "collisions": collision_groups,
        "manualSchemas": manual_schemas,
        "formatMappings": format_mappings,
        "schemas": sorted(descriptors, key=lambda item: item["openapiName"]),
    }

    return catalog, issues


def main() -> int:
    args = parse_args()
    spec = load_json(args.spec)
    overrides = load_json(args.overrides)
    catalog, issues = build_schema_catalog(spec, overrides)

    rendered = json.dumps(catalog, indent=2)

    if args.output:
        output_path = pathlib.Path(args.output)
        output_path.parent.mkdir(parents=True, exist_ok=True)
        output_path.write_text(rendered + "\n")
    else:
        sys.stdout.write(rendered + "\n")

    return 0 if not issues else 1


if __name__ == "__main__":
    raise SystemExit(main())
