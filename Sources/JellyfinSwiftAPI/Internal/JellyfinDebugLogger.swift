import Foundation

#if DEBUG
internal enum JellyfinDebugLogger {
    internal static func logRequest(_ request: URLRequest) {
        var lines = ["[JellyfinSwiftAPI] Request"]
        lines.append("\(request.httpMethod ?? "GET") \(request.url?.absoluteString ?? "<unknown-url>")")

        if let headers = request.allHTTPHeaderFields, !headers.isEmpty {
            lines.append("Headers:")
            for (field, value) in headers.sorted(by: { $0.key < $1.key }) {
                let renderedValue = field.caseInsensitiveCompare("Authorization") == .orderedSame
                    ? "<redacted>"
                    : value
                lines.append("  \(field): \(renderedValue)")
            }
        }

        if let body = request.httpBody, !body.isEmpty {
            lines.append("Body:")
            lines.append(renderBody(body, contentType: request.value(forHTTPHeaderField: "Content-Type")))
        }

        Swift.print(lines.joined(separator: "\n"))
    }

    internal static func logResponse(_ response: JellyfinTransportResponse, for request: URLRequest) {
        var lines = ["[JellyfinSwiftAPI] Response"]
        lines.append("\(response.response.statusCode) \(request.url?.absoluteString ?? "<unknown-url>")")

        let headers = response.response.allHeaderFields
            .compactMap { key, value -> (String, String)? in
                guard let key = key as? String else { return nil }
                return (key, String(describing: value))
            }
            .sorted(by: { $0.0 < $1.0 })

        if !headers.isEmpty {
            lines.append("Headers:")
            for (field, value) in headers {
                lines.append("  \(field): \(value)")
            }
        }

        if !response.data.isEmpty {
            lines.append("Body:")
            lines.append(renderBody(response.data, contentType: response.response.value(forHTTPHeaderField: "Content-Type")))
        }

        Swift.print(lines.joined(separator: "\n"))
    }

    internal static func logError(_ error: Error, for request: URLRequest) {
        Swift.print(
            [
                "[JellyfinSwiftAPI] Error",
                "\(request.httpMethod ?? "GET") \(request.url?.absoluteString ?? "<unknown-url>")",
                String(describing: error),
            ].joined(separator: "\n")
        )
    }

    private static func renderBody(_ data: Data, contentType: String?) -> String {
        let contentType = contentType?.lowercased() ?? ""
        let isTextLike = contentType.contains("json")
            || contentType.hasPrefix("text/")
            || contentType.contains("xml")
            || contentType.contains("javascript")
            || contentType.contains("form-urlencoded")

        if isTextLike || String(data: data, encoding: .utf8) != nil {
            let string = String(decoding: data.prefix(16_384), as: UTF8.self)
            if data.count > 16_384 {
                return "\(string)\n<trimmed \(data.count - 16_384) bytes>"
            }
            return string
        }

        return "<\(data.count) bytes>"
    }
}
#else
internal enum JellyfinDebugLogger {
    internal static func logRequest(_: URLRequest) {}
    internal static func logResponse(_: JellyfinTransportResponse, for _: URLRequest) {}
    internal static func logError(_: Error, for _: URLRequest) {}
}
#endif
