import Foundation

struct CleanCommand: XcodeBuildCommand {
    // MARK: - XcodeBuildCommand

    let subCommand: String = "clean"

    var options: [XcodeBuildOption] {
        [.init(key: "project", value: project.projectPath.pathString)]
    }

    var environmentVaribles: [XcodeBuildEnvironmentVariable] {
        [.init(key: "BUILD_DIR", value: project.workspaceDirectory.pathString)]
    }

    // MARK: - Dependency

    let project: Project
}
