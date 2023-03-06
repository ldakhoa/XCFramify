import Foundation
import struct TSCBasic.AbsolutePath

struct Project {
    let projectDirectory: AbsolutePath
    let name: String

    var buildDirectory: AbsolutePath {
        projectDirectory.appending(component: ".build")
    }

    var workspaceDirectory: AbsolutePath {
        buildDirectory.appending(component: "xcframify")
    }

    var projectPath: AbsolutePath {
        projectDirectory.appending(component: "\(name).xcodeproj")
    }

    private let executor: any Executor

    init(
        projectDirectory: AbsolutePath,
        name: String,
        buildConfiguration: BuildConfiguration,
        executor: any Executor = ProcessExecutor()
    ) async throws {
        self.projectDirectory = projectDirectory
        self.name = name
        self.executor = executor
    }
}

public enum ProjectLocator {
    case workspace(URL)
    case projectFile(URL)
}
