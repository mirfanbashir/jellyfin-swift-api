import Foundation
import XCTest
@testable import JellyfinSwiftAPI

final class AdministrationServiceTests: XCTestCase {
    func testServerConfigurationUsesConfigurationPath() async throws {
        let responseData = try FixtureLoader.data(service: "Administration", named: "configuration")
        let transport = TestTransport { request in
            JellyfinTransportResponse(data: responseData, response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200))
        }
        let service = makeAdministrationService(transport: transport)

        let configuration = try await service.serverConfiguration()

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(request.url?.absoluteString, "https://jellyfin.example.com/System/Configuration")
        XCTAssertEqual(configuration.serverName, "Jellyfin Test Server")
    }

    func testUpdateNamedConfigurationPostsRawJSON() async throws {
        let transport = TestTransport { request in
            JellyfinTransportResponse(data: Data(), response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 204))
        }
        let service = makeAdministrationService(transport: transport)

        try await service.updateNamedConfiguration(key: "ui", value: Data("{\"Theme\":\"Dark\"}".utf8), contentType: "application/json")

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.url?.absoluteString, "https://jellyfin.example.com/System/Configuration/ui")
        XCTAssertEqual(String(data: try XCTUnwrap(request.httpBody), encoding: .utf8), "{\"Theme\":\"Dark\"}")
    }

    func testDirectoryContentsUsesPathAndFlags() async throws {
        let responseData = try FixtureLoader.data(service: "Administration", named: "filesystem")
        let transport = TestTransport { request in
            JellyfinTransportResponse(data: responseData, response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200))
        }
        let service = makeAdministrationService(transport: transport)

        let entries = try await service.directoryContents(path: "/media", includeFiles: true, includeDirectories: false)

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/Environment/DirectoryContents?path=/media&includeFiles=true&includeDirectories=false"
        )
        XCTAssertEqual(entries.first?.name, "Movies")
    }

    func testStartupUserCanUseAliasPath() async throws {
        let responseData = try FixtureLoader.data(service: "Administration", named: "startup-user")
        let transport = TestTransport { request in
            JellyfinTransportResponse(data: responseData, response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200))
        }
        let service = makeAdministrationService(transport: transport)

        let user = try await service.startupUser(useFirstUserAlias: true)

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(request.url?.absoluteString, "https://jellyfin.example.com/Startup/FirstUser")
        XCTAssertEqual(user.name, "admin")
    }

    func testUpdateScheduledTaskTriggersPostsJSONArray() async throws {
        let transport = TestTransport { request in
            JellyfinTransportResponse(data: Data(), response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 204))
        }
        let service = makeAdministrationService(transport: transport)

        try await service.updateScheduledTaskTriggers(
            taskID: "task-1",
            triggers: [ScheduledTaskTrigger(type: "Daily", timeOfDayTicks: 36_000_000_000, intervalTicks: nil, dayOfWeek: nil, maxRuntimeTicks: nil)]
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        let body = try JellyfinJSONCoder.decoder().decode([ScheduledTaskTrigger].self, from: try XCTUnwrap(request.httpBody))
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.url?.absoluteString, "https://jellyfin.example.com/ScheduledTasks/task-1/Triggers")
        XCTAssertEqual(body.first?.type, "Daily")
    }

    func testPluginConfigurationReturnsRawPayload() async throws {
        let payload = Data("{\"Enabled\":true}".utf8)
        let transport = TestTransport { request in
            JellyfinTransportResponse(
                data: payload,
                response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200, headers: ["Content-Type": "application/json"])
            )
        }
        let service = makeAdministrationService(transport: transport)

        let config = try await service.pluginConfiguration(pluginID: "plugin-1")

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(request.url?.absoluteString, "https://jellyfin.example.com/Plugins/plugin-1/Configuration")
        XCTAssertEqual(config.mimeType, "application/json")
    }

    func testInstallPackageBuildsPathAndQuery() async throws {
        let transport = TestTransport { request in
            JellyfinTransportResponse(data: Data(), response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 204))
        }
        let service = makeAdministrationService(transport: transport)

        try await service.installPackage(
            name: "intro-skipper",
            assemblyGUID: UUID(uuidString: "D2C48876-BD8F-4D6A-8734-712267F7F9F6"),
            version: "1.0.0",
            repositoryURL: "https://repo.example.com"
        )

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(
            request.url?.absoluteString,
            "https://jellyfin.example.com/Packages/Installed/intro-skipper?assemblyGuid=D2C48876-BD8F-4D6A-8734-712267F7F9F6&version=1.0.0&repositoryUrl=https://repo.example.com"
        )
    }

    func testCreateBackupPostsOptionsBody() async throws {
        let responseData = try FixtureLoader.data(service: "Administration", named: "backup-manifest")
        let transport = TestTransport { request in
            JellyfinTransportResponse(data: responseData, response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200))
        }
        let service = makeAdministrationService(transport: transport)

        let backup = try await service.createBackup(options: BackupOptions(metadata: true, database: true))

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        let body = try JellyfinJSONCoder.decoder().decode(BackupOptions.self, from: try XCTUnwrap(request.httpBody))
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.url?.absoluteString, "https://jellyfin.example.com/Backup/Create")
        XCTAssertEqual(body.database, true)
        XCTAssertEqual(backup.path, "/backups/backup.zip")
    }

    func testUploadClientLogPostsTextPlain() async throws {
        let responseData = try FixtureLoader.data(service: "Administration", named: "client-log-response")
        let transport = TestTransport { request in
            JellyfinTransportResponse(data: responseData, response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 200))
        }
        let service = makeAdministrationService(transport: transport)

        let response = try await service.uploadClientLog(contents: "client log line")

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.value(forHTTPHeaderField: "Content-Type"), "text/plain")
        XCTAssertEqual(request.url?.absoluteString, "https://jellyfin.example.com/ClientLog/Document")
        XCTAssertEqual(response.fileName, "client-log.txt")
    }

    func testCreateAPIKeyUsesRequiredAppQuery() async throws {
        let transport = TestTransport { request in
            JellyfinTransportResponse(data: Data(), response: makeHTTPResponse(url: try XCTUnwrap(request.url), statusCode: 204))
        }
        let service = makeAdministrationService(transport: transport)

        try await service.createAPIKey(app: "Swift App")

        let lastRequest = await transport.lastRequest()
        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.url?.absoluteString, "https://jellyfin.example.com/Auth/Keys?app=Swift%20App")
    }
}

private func makeAdministrationService(
    authorization: JellyfinAuthorization = .header("MediaBrowser Token=test-token"),
    transport: any JellyfinTransporting
) -> AdministrationServiceClient {
    AdministrationServiceClient(executor: makeTestExecutor(authorization: authorization, transport: transport))
}
