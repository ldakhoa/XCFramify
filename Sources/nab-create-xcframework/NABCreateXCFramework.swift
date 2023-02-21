@main
struct NABCreateXCFrameworkKit: AsyncParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "A build tool to create XCFrameworks from Swift packages."
    )
}
