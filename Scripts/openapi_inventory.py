#!/usr/bin/env python3

from __future__ import annotations

import argparse
import json
import pathlib
import sys
import urllib.request
from collections import Counter
from typing import Any

HTTP_METHODS = {"get", "post", "put", "delete", "patch", "options", "head", "trace"}


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Normalize the Jellyfin OpenAPI document into a service-oriented inventory."
    )
    parser.add_argument(
        "--spec",
        required=True,
        help="Path or URL to the OpenAPI JSON document.",
    )
    parser.add_argument(
        "--service-map",
        default=str(pathlib.Path(__file__).with_name("openapi_service_map.json")),
        help="Path to the JSON service mapping file.",
    )
    parser.add_argument(
        "--output",
        help="Optional path to write the generated inventory JSON.",
    )
    return parser.parse_args()


def load_json(source: str) -> dict[str, Any]:
    if source.startswith(("http://", "https://")):
        with urllib.request.urlopen(source) as response:
            return json.load(response)

    return json.loads(pathlib.Path(source).read_text())


def iter_operations(spec: dict[str, Any]) -> list[dict[str, Any]]:
    operations: list[dict[str, Any]] = []

    for path, path_item in spec.get("paths", {}).items():
        for method, operation in path_item.items():
            if method.lower() not in HTTP_METHODS:
                continue

            request_content_types = sorted(
                (operation.get("requestBody", {}).get("content") or {}).keys()
            )
            response_content_types = sorted(
                {
                    content_type
                    for response in (operation.get("responses") or {}).values()
                    for content_type in (response.get("content") or {}).keys()
                }
            )

            operations.append(
                {
                    "method": method.upper(),
                    "path": path,
                    "operationId": operation.get("operationId"),
                    "tags": operation.get("tags") or [],
                    "requiresAuth": bool(operation.get("security")),
                    "requestContentTypes": request_content_types,
                    "responseContentTypes": response_content_types,
                }
            )

    return operations


def matches_service(service: dict[str, Any], operation: dict[str, Any]) -> bool:
    operation_id = operation.get("operationId")
    include_operation_ids = set(service.get("includeOperationIds", []))
    exclude_operation_ids = set(service.get("excludeOperationIds", []))
    include_tags = set(service.get("includeTags", []))

    if operation_id in include_operation_ids:
        return True

    if operation_id in exclude_operation_ids:
        return False

    return bool(include_tags.intersection(operation.get("tags", [])))


def classify_operations(
    operations: list[dict[str, Any]], services: list[dict[str, Any]]
) -> tuple[list[dict[str, Any]], list[dict[str, Any]], list[dict[str, Any]]]:
    classified: list[dict[str, Any]] = []
    unassigned: list[dict[str, Any]] = []
    ambiguous: list[dict[str, Any]] = []

    for operation in operations:
        matches = [
            service["name"] for service in services if matches_service(service, operation)
        ]

        if len(matches) == 1:
            enriched = dict(operation)
            enriched["service"] = matches[0]
            classified.append(enriched)
            continue

        if len(matches) == 0:
            unassigned.append(operation)
            continue

        ambiguous.append(
            {
                **operation,
                "candidateServices": matches,
            }
        )

    return classified, unassigned, ambiguous


def build_summary(
    spec: dict[str, Any],
    classified: list[dict[str, Any]],
    unassigned: list[dict[str, Any]],
    ambiguous: list[dict[str, Any]],
    services: list[dict[str, Any]],
) -> dict[str, Any]:
    counts_by_service = Counter(operation["service"] for operation in classified)
    counts_by_tag = Counter(
        tag for operation in classified for tag in operation.get("tags", [])
    )

    return {
        "spec": {
            "title": spec.get("info", {}).get("title"),
            "version": spec.get("info", {}).get("version"),
            "pathCount": len(spec.get("paths", {})),
            "operationCount": len(classified) + len(unassigned) + len(ambiguous),
            "schemaCount": len(spec.get("components", {}).get("schemas", {})),
            "securitySchemes": sorted(
                spec.get("components", {}).get("securitySchemes", {}).keys()
            ),
        },
        "services": [
            {
                "name": service["name"],
                "operationCount": counts_by_service.get(service["name"], 0),
                "includeTags": service.get("includeTags", []),
                "includeOperationIds": service.get("includeOperationIds", []),
                "excludeOperationIds": service.get("excludeOperationIds", []),
            }
            for service in services
        ],
        "countsByTag": dict(sorted(counts_by_tag.items())),
        "unassignedCount": len(unassigned),
        "ambiguousCount": len(ambiguous),
    }


def main() -> int:
    args = parse_args()
    spec = load_json(args.spec)
    service_map = load_json(args.service_map)
    services = service_map.get("services", [])
    operations = iter_operations(spec)
    classified, unassigned, ambiguous = classify_operations(operations, services)

    inventory = {
        "summary": build_summary(spec, classified, unassigned, ambiguous, services),
        "classifiedOperations": sorted(
            classified, key=lambda item: (item["service"], item["path"], item["method"])
        ),
        "unassignedOperations": sorted(
            unassigned, key=lambda item: (item["path"], item["method"])
        ),
        "ambiguousOperations": sorted(
            ambiguous, key=lambda item: (item["path"], item["method"])
        ),
    }

    rendered = json.dumps(inventory, indent=2)

    if args.output:
        output_path = pathlib.Path(args.output)
        output_path.parent.mkdir(parents=True, exist_ok=True)
        output_path.write_text(rendered + "\n")
    else:
        sys.stdout.write(rendered + "\n")

    return 0 if not unassigned and not ambiguous else 1


if __name__ == "__main__":
    raise SystemExit(main())
