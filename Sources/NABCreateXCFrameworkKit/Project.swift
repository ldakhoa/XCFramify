import Foundation

struct Project {
    let projectDirectory: URL
    let name: String
    let scheme: String

    var buildDirectory: URL {
        projectDirectory.appendingPathComponent(".build")
    }

    var workspaceDirectory: URL {
        buildDirectory.appendingPathExtension("nab_create_xcframework")
    }

    var projectPath: URL {
        buildDirectory.appendingPathComponent("\(name).xcodeproj")
    }
}
