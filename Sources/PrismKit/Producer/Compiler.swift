import Foundation
import struct TSCBasic.AbsolutePath
import protocol TSCBasic.FileSystem
import var TSCBasic.localFileSystem
import OrderedCollections

public typealias PlatformMatrix = [Scheme: OrderedSet<SDK>]

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
    func createXCFramework(outputDirectory: AbsolutePath) async throws {
        let buildConfiguration = buildOptions.buildConfiguration
        let sdks = extractSDKs(isSimulatorSupported: buildOptions.isSimulatorSupported)
        let sdkNames = sdks.map(\.displayName).joined(separator: ", ")

        print("sdkNames", sdkNames)
        logger.info("📦 Building \(rootProject.name) for \(sdkNames)")

        for sdk in sdks {
            try await xcodebuild.archive(
                project: rootProject,
                buildConfiguration: buildConfiguration,
                sdk: sdk,
                scheme: .init("")
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

    private func extractPlatformMatrix(sdks: Set<SDK>) -> PlatformMatrix {
        [:]
    }

    private func schemes() async throws -> [Scheme] {
        try await xcodebuild.list(
            project: rootProject,
            buildConfiguration: buildOptions.buildConfiguration)
        .unwrapOutput()
        .components(separatedBy: .newlines)
        .drop(while: { !$0.hasSuffix("Schemes:") })
        .dropFirst()
        .prefix(while: { !$0.isEmpty })
        .map { $0.trimmingCharacters(in: .whitespaces) }
        .map { Scheme($0) }
    }
}

extension Project {
    var archivesPath: AbsolutePath {
        workspaceDirectory.appending(component: "archives")
    }

    var xcFrameworkName: String {
        "\(name).xcframework"
    }
}
