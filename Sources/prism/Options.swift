import Foundation
import ArgumentParser
import PrismKit

struct BuildOptionGroup: ParsableArguments {
    @Option(name: [.customLong("configuration"), .customShort("c")],
            help: "Build configuration for generated frameworks. (debug / release)")
    var buildConfiguration: BuildConfiguration = .release

    @Option(name: [.customShort("o"), .customLong("output")],
            help: "Path indicates a XCFrameworks output directory.")
    var customOutputDirectory: URL?

    @Flag(name: .long,
          help: "Whether also building for simulator of each SDKs or not.")
    var supportSimulators = false

    @Flag(name: .customLong("library-evolution"),
          help: "Whether to enable Library Evolution feature or not.")
    var shouldEnableLibraryEvolution = false

    @Flag(name: .customLong("build-library-distribution"),
          help: "Whether to enable Build Library For Distribution feature or not.")
    var shouldBuildLibraryForDistribution = false

    @Flag(name: .customLong("static"),
          help: "Whether generated frameworks are Static Frameworks or not.")
    var shouldBuildStaticFramework = false
}

extension BuildOptionGroup {
    var frameworkType: FrameworkType {
        shouldBuildStaticFramework ? .static : .dynamic
    }
}

extension BuildConfiguration: ExpressibleByArgument {
    public init?(argument: String) {
        switch argument.lowercased() {
        case "debug":
            self = .debug
        case "release":
            self = .release
        default:
            return nil
        }
    }
}
