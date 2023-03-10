import Foundation
import ArgumentParser
import XCFramifyKit
import OrderedCollections

@main
struct XCFramify: AsyncParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "A build tool to create XCFrameworks from Swift packages.",
        subcommands: [Create.self],
        defaultSubcommand: Create.self
    )
}

extension XCFramify {
    struct Create: AsyncParsableCommand {
        static var configuration: CommandConfiguration = .init(abstract: "Create XCFramework for a single package.")

        @Argument(help: "The product name of the framework.")
        var name: String?

        @Argument(help: "Path indicates a package directory.", completion: .directory)
        var packageDirectory: URL = URL(fileURLWithPath: ".")

        @Flag(name: [.long, .short], help: "Provide additional build progress.")
        var verbose: Bool = false

        @OptionGroup var buildOptions: BuildOptionGroup

        @Option(help: "Platforms to create XCFramework for. (availables: \(availablePlatforms.map(\.rawValue).joined(separator: ", ")))",
                completion: .list(availablePlatforms.map(\.rawValue)))
        var platforms: [SDK] = []

        func run() async throws {
            let runner = Runner(options: .init(
                buildConfiguration: buildOptions.buildConfiguration,
                isSimulatorSupported: buildOptions.supportSimulators,
                isDebugSymbolsIsEmbedded: buildOptions.shouldBuildLibraryForDistribution,
                frameworkType: buildOptions.frameworkType,
                verbose: verbose
            ))

            let outputDir: Runner.OutputDirectory
            if let customOutputDir = buildOptions.customOutputDirectory {
                outputDir = .custom(customOutputDir)
            } else {
                outputDir = .default
            }

            try await runner.run(
                projectDirectory: packageDirectory,
                productName: name,
                frameworkOutputDir: outputDir
            )
        }
    }
}

private let availablePlatforms: OrderedSet<SDK> = [.iOS, .watchOS]

extension SDK: ExpressibleByArgument {
    public init?(argument: String) {
        if let initialized = SDK(rawValue: argument) {
            self = initialized
        } else {
            return nil
        }
    }
}
