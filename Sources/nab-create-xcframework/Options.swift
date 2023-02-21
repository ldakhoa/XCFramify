import Foundation
import ArgumentParser

struct BuildOptionGroup: ParsableArguments {
    @Flag(name: .long,
          help: "Whether also building for simulator of each SDKs or not.")
    var supportSimulators = false

    @Flag(name: .customLong("library-evolution"),
          help: "Whether to enable Library Evolution feature or not.")
    var shouldEnableLibraryEvolution = false

    @Flag(name: .customLong("build-library-distribution"),
          help: "Whether to enable Build Library For Distribution feature or not.")
    var shouldBuildLibraryForDistribution = false

    @Flag(name: .customLong("skip-install"),
          help: "Whether to enable SKIP INSTALL feature or not.")
    var shouldSkipInstall = false

    @Flag(name: .customLong("static"),
          help: "Whether generated frameworks are Static Frameworks or not.")
    var shouldBuildStaticFramework = false
}