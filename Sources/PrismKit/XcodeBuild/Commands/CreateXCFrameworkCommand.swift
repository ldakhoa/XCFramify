import Foundation

struct CreateXCFrameworkCommand: XcodeBuildCommand {
    // MARK: - Dependencies

    var project: Project
    var buildConfiguration: BuildConfiguration
    var sdks: Set<SDK>
    var debugSymbolPaths: [URL]?
    var outputDir: URL

    // MARK: - XcodeBuildCommand

    let subCommand: String = "-create-xcframework"

    var environmentVaribles: [XcodeBuildEnvironmentVariable] {
        []
    }

    var options: [XcodeBuildOption] {
        sdks.map { sdk in
                .init(key: "framework", value: buildFramemorkPath(sdk: sdk).path)
        }
        +
        (debugSymbolPaths.flatMap {
            $0.map { .init(key: "debug-symbols", value: $0.path) }
        } ?? [])
        +
        [.init(key: "output", value: xcFrameworkPath.path)]
    }

    // MARK: - Private

    private var xcFrameworkPath: URL {
        outputDir.appendingPathComponent("\(project.name).xcframework")
    }

    private func buildFramemorkPath(sdk: SDK) -> URL {
        buildXCArchivePath(project: project, sdk: sdk)
            .appendingPathComponent("Products")
            .appendingPathComponent("Library")
            .appendingPathComponent("Frameworks")
            .appendingPathComponent("\(project.scheme).framework")
    }
}
