import Foundation
import protocol TSCBasic.FileSystem
import var TSCBasic.localFileSystem

/// A type representing a compiler used to build XCFramework from a given project and configuration.
struct Compiler<E: Executor> {
    // MARK: - Dependencies

    private let buildOptions: BuildOptions
    private let fileSytem: any FileSystem
    private let rootProject: Project
    private let xcodebuild: XcodeBuildClient<E>

    // MARK: - Initializer

    init(
        buildOptions: BuildOptions,
        fileSytem: any FileSystem = localFileSystem,
        executor: E = ProcessExecutor(),
        rootProject: Project
    ) {
        self.buildOptions = buildOptions
        self.fileSytem = fileSytem
        self.rootProject = rootProject
        self.xcodebuild = XcodeBuildClient(executor: executor)
    }

    // MARK: - Public

    /// Creates an XCFramework from the root project for the specified SDKs and outputs it to the specified directory.
    /// - Parameter outputDirectory: The `URL` of the output directory to which the XCFramework should be written.
    func createXCFramework(outputDirectory: URL) async throws {
        let buildConfiguration = buildOptions.buildConfiguration
        let sdks = extractSDKs(isSimulatorSupported: buildOptions.isSimulatorSupported)
        let sdkNames = sdks.map(\.displayName).joined(separator: ", ")

        logger.info("📦 Building \(rootProject.name) for \(sdkNames)")

        for sdk in sdks {
            try await xcodebuild.archive(
                project: rootProject,
                buildConfiguration: buildConfiguration,
                sdk: sdk
            )
        }

        logger.info("🚀 Combining into XCFramework...")

        try await xcodebuild.createXCFramework(
            project: rootProject,
            buildConfiguration: buildConfiguration,
            sdks: sdks,
            debugSymbolPaths: nil,
            outputDir: outputDirectory
        )
    }

    // MARK: - Private

    /// Extracts the SDKs from the build options and returns the set of SDKs to build for.
    ///
    /// - Parameter isSimulatorSupported: A flag indicating whether simulator SDKs are supported.
    private func extractSDKs(isSimulatorSupported: Bool) -> Set<SDK> {
        if isSimulatorSupported {
            return Set(buildOptions.sdks.flatMap { $0.extractForSimulators() })
        } else {
            return Set(buildOptions.sdks)
        }
    }
}

extension Project {
    var archivesPath: URL {
        workspaceDirectory.appendingPathExtension("archives")
    }

    var xcFrameworkName: String {
        "\(name).xcframework"
    }
}
