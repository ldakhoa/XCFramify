import Foundation
import protocol TSCBasic.FileSystem
import var TSCBasic.localFileSystem

struct FrameworkProducer {
    // MARK: - Dependencies

    private let rootProject: Project
    private let buildOptions: BuildOptions
    private let outputDir: URL

    // MARK: - Mics.

    private let fileSystem: any FileSystem

    // TODO: - Initilizer

    init(
        rootProject: Project,
        buildOptions: BuildOptions,
        outputDir: URL,
        fileSystem: any FileSystem = localFileSystem
    ) {
        self.rootProject = rootProject
        self.buildOptions = buildOptions
        self.outputDir = outputDir
        self.fileSystem = fileSystem
    }

    // MARK: - Public

    func produce() async throws {}

    // MARK: - Private
}
