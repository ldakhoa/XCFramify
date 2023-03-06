import Foundation

struct ListCommand: XcodeBuildCommand {
    var buildConfiguration: BuildConfiguration
    var project: Project

    let subCommand: String = "list"

    var options: [XcodeBuildOption] {
        [
            ("project", project.projectPath.pathString),
            ("configuration", buildConfiguration.settingsValue)
        ].map(XcodeBuildOption.init(key:value:))
    }

    var environmentVaribles: [XcodeBuildEnvironmentVariable] {
        []
    }
}
