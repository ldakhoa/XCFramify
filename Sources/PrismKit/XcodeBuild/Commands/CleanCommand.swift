import Foundation

struct CleanCommand: XcodeBuildCommand {
    // MARK: - XcodeBuildCommand

    let subCommand: String = "clean"

    var options: [XcodeBuildOption] {
        [.init(key: "project", value: project.projectPath.path)]
    }

    var environmentVaribles: [XcodeBuildEnvironmentVariable] {
        [.init(key: "BUILD_DIR", value: project.workspaceDirectory.path)]
    }

    // MARK: - Dependency

    let project: Project
}
