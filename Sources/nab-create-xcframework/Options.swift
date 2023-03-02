import Foundation
import ArgumentParser

struct BuildOptionGroup: ParsableArguments {
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
