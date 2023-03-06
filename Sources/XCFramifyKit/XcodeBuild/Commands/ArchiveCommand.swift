import Foundation
import struct TSCBasic.AbsolutePath

struct ArchiveCommand: XcodeBuildCommand {
    // MARK: - Dependencies

    var project: Project
    var buildConfiguration: BuildConfiguration
    var sdk: SDK
    var scheme: Scheme

    // MARK: - XcodeBuildCommand

    let subCommand: String = "archive"

    var options: [XcodeBuildOption] {
        [
            ("project", project.projectPath.pathString),
            ("configuration", buildConfiguration.settingsValue),
//            ("scheme", project.scheme),
            ("archivePath", xcArchivePath.pathString),
            ("destination", sdk.destination),
        ].map(XcodeBuildOption.init(key:value:))
    }

    var environmentVaribles: [XcodeBuildEnvironmentVariable] {
        [
            ("BUILD_DIR", project.workspaceDirectory.pathString),
            ("SKIP_INSTALL", "NO"),
        ].map(XcodeBuildEnvironmentVariable.init(key:value:))
    }

    // MARK: - Private

    private var xcArchivePath: AbsolutePath {
        buildXCArchivePath(project: project, sdk: sdk)
    }
}
