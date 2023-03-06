import Foundation
import struct TSCBasic.AbsolutePath

struct CreateXCFrameworkCommand: XcodeBuildCommand {
    // MARK: - Dependencies

    var project: Project
    var buildConfiguration: BuildConfiguration
    var sdks: Set<SDK>
    var debugSymbolPaths: [URL]?
    var outputDir: AbsolutePath

    // MARK: - XcodeBuildCommand

    let subCommand: String = "-create-xcframework"

    var environmentVaribles: [XcodeBuildEnvironmentVariable] {
        []
    }

    var options: [XcodeBuildOption] {
        sdks.map { sdk in
                .init(key: "framework", value: buildFramemorkPath(sdk: sdk).pathString)
        }
        +
        (debugSymbolPaths.flatMap {
            $0.map { .init(key: "debug-symbols", value: $0.path) }
        } ?? [])
        +
        [.init(key: "output", value: xcFrameworkPath.pathString)]
    }

    // MARK: - Private

    private var xcFrameworkPath: AbsolutePath {
        outputDir.appending(component: "\(project.name).xcframework")
    }

    private func buildFramemorkPath(sdk: SDK) -> AbsolutePath {
        buildXCArchivePath(project: project, sdk: sdk)
            .appending(component: "Products")
            .appending(component: "Library")
            .appending(component: "Frameworks")
            .appending(component: "\(project.name).framework")
    }
}
