import Foundation

struct ArchiveCommand: XcodeBuildCommand {
    // MARK: - Dependencies

    var project: Project
    var buildConfiguration: BuildConfiguration
    var sdk: SDK

    // MARK: - XcodeBuildCommand

    let subCommand: String = "archive"

    var options: [XcodeBuildOption] {
        [
            ("project", project.projectPath.path),
            ("configuration", buildConfiguration.settingsValue),
            ("scheme", project.scheme),
            ("archivePath", xcArchivePath.path),
            ("destination", sdk.destination),
        ].map(XcodeBuildOption.init(key:value:))
    }

    var environmentVaribles: [XcodeBuildEnvironmentVariable] {
        [
            ("BUILD_DIR", project.workspaceDirectory.path),
            ("SKIP_INSTALL", "NO"),
        ].map(XcodeBuildEnvironmentVariable.init(key:value:))
    }

    // MARK: - Private

    private var xcArchivePath: URL {
        buildXCArchivePath(project: project, sdk: sdk)
    }
}
