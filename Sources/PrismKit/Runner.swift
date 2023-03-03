import Foundation
import protocol TSCBasic.FileSystem
import var TSCBasic.localFileSystem

public struct Runner {
    private let fileSystem: any FileSystem
    private let options: Options

    public init(
        options: Options,
        fileSystem: (any FileSystem) = localFileSystem
    ) {
        self.options = options
        self.fileSystem = fileSystem

        if options.verbose {
            setLogLevel(.trace)
        } else {
            setLogLevel(.info)
        }
    }

    public func run(
        projectDirectory: URL,
        productName: String?,
        frameworkOutputDir: OutputDirectory
    ) async throws {}
}

extension Runner {
    public struct Options {
        public var buildConfiguration: BuildConfiguration
        public var isSimulatorSupported: Bool
        public var isDebugSymbolsIsEmbedded: Bool
        public var frameworkType: FrameworkType
        public var outputDirectory: URL?
        public var verbose: Bool
        public var enableLibraryEvolution: Bool
        public var enableBuildLibraryForDistribution: Bool

        public init(
            buildConfiguration: BuildConfiguration,
            isSimulatorSupported: Bool,
            isDebugSymbolsIsEmbedded: Bool,
            frameworkType: FrameworkType,
            outputDirectory: URL? = nil,
            verbose: Bool,
            enableLibraryEvolution: Bool = false,
            enableBuildLibraryForDistribution: Bool = false
        ) {
            self.buildConfiguration = buildConfiguration
            self.isSimulatorSupported = isSimulatorSupported
            self.isDebugSymbolsIsEmbedded = isDebugSymbolsIsEmbedded
            self.frameworkType = frameworkType
            self.outputDirectory = outputDirectory
            self.verbose = verbose
            self.enableLibraryEvolution = enableLibraryEvolution
            self.enableBuildLibraryForDistribution = enableBuildLibraryForDistribution
        }
    }

    public enum OutputDirectory {
        case `default`
        case custom(URL)
    }
}
