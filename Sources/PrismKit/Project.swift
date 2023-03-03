import Foundation

struct Project {
    let projectDirectory: URL
    let name: String
    let scheme: String

    var buildDirectory: URL {
        projectDirectory.appendingPathComponent(".build")
    }

    var workspaceDirectory: URL {
        buildDirectory.appendingPathExtension("prism")
    }

    var projectPath: URL {
        buildDirectory.appendingPathComponent("\(name).xcodeproj")
    }
}

public enum ProjectLocator {
    case workspace(URL)
    case projectFile(URL)
}
