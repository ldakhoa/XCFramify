import Foundation
import ArgumentParser

@main
struct NABCreateXCFrameworkKit: AsyncParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "A build tool to create XCFrameworks from Swift packages.",
        subcommands: [Create.self],
        defaultSubcommand: Create.self
    )
}

extension NABCreateXCFrameworkKit {
    struct Create: AsyncParsableCommand {
        static var configuration: CommandConfiguration = .init(abstract: "Create XCFramework for a single package.")

        @Argument(help: "Path indicates a package directory.", completion: .directory)
        var packageDirectory: URL = URL(fileURLWithPath: ".")

        @Flag(name: [.long, .short], help: "Provide additional build progress.")
        var verbose: Bool = false

        @OptionGroup var buildOptions: BuildOptionGroup

        func run() async throws {
            print("Hello")
        }
    }
}
