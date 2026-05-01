/// Identifies the client application making Jellyfin requests.
public struct JellyfinClientInfo: Sendable, Equatable {
    /// The application name reported to Jellyfin.
    public let appName: String

    /// The user-visible device name reported to Jellyfin.
    public let deviceName: String

    /// The stable device identifier reported to Jellyfin.
    public let deviceID: String

    /// The application version reported to Jellyfin.
    public let version: String

    /// Creates a new Jellyfin client identity payload.
    ///
    /// - Parameters:
    ///   - appName: The application name reported to Jellyfin.
    ///   - deviceName: The user-visible device name reported to Jellyfin.
    ///   - deviceID: The stable device identifier reported to Jellyfin.
    ///   - version: The application version reported to Jellyfin.
    public init(
        appName: String,
        deviceName: String,
        deviceID: String,
        version: String
    ) {
        self.appName = appName
        self.deviceName = deviceName
        self.deviceID = deviceID
        self.version = version
    }
}

internal extension JellyfinClientInfo {
    func authorizationHeaderValue(token: String?) -> String {
        let components = [
            #"Client="\#(quotedHeaderValue(appName))""#,
            #"Device="\#(quotedHeaderValue(deviceName))""#,
            #"DeviceId="\#(quotedHeaderValue(deviceID))""#,
            #"Version="\#(quotedHeaderValue(version))""#,
        ]
        var header = "MediaBrowser " + components.joined(separator: ",")

        if let token {
            header += #",Token="\#(quotedHeaderValue(token))""#
        }

        return header
    }

    private func quotedHeaderValue(_ value: String) -> String {
        value
            .replacingOccurrences(of: "\\", with: "\\\\")
            .replacingOccurrences(of: "\"", with: "\\\"")
    }
}
