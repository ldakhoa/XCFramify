import Foundation
import OrderedCollections

/// A struct representing build options for a framework.
struct BuildOptions: Hashable, Codable {

    /// Initializes a new instance of `BuildOptions`.
    /// - Parameters:
    ///   - buildConfiguration: The build configuration used to build the framework.
    ///   - isSimulatorSupported: A flag indicating whether to support simulator.
    ///   - isDebugSymbolsEmbedded: A flag indicating whether to embed debug symbols in the built framework.
    ///   - frameworkType: The type of framework to build.
    ///   - sdks: An ordered set of `SDK`s to build the framework for.
    ///   - extraFlags: Extra build flags to pass to the build system.
    ///   - extraBuildParameters: Extra build parameters to pass to the build system.
    ///   - enableLibraryEvolution: A flag indicating whether to enable library evolution for the built framework.
    ///   - enableBuildLibraryForDistribution: A flag indicating whether to build a library for distribution.
    init(
        buildConfiguration: BuildConfiguration,
        isSimulatorSupported: Bool,
        isDebugSymbolsEmbedded: Bool,
        frameworkType: FrameworkType,
        sdks: OrderedSet<SDK>,
        extraFlags: ExtraFlags?,
        extraBuildParameters: ExtraBuildParameters?,
        enableLibraryEvolution: Bool,
        enableBuildLibraryForDistribution: Bool
    ) {
        self.buildConfiguration = buildConfiguration
        self.isSimulatorSupported = isSimulatorSupported
        self.isDebugSymbolsEmbedded = isDebugSymbolsEmbedded
        self.frameworkType = frameworkType
        self.sdks = sdks
        self.extraFlags = extraFlags
        self.extraBuildParameters = extraBuildParameters
        self.enableLibraryEvolution = enableLibraryEvolution
        self.enableBuildLibraryForDistribution = enableBuildLibraryForDistribution
    }

    /// The build configuration used to build the framework.
    var buildConfiguration: BuildConfiguration

    /// A flag indicating whether to support simulator.
    var isSimulatorSupported: Bool

    /// A flag indicating whether to embed debug symbols in the built framework.
    var isDebugSymbolsEmbedded: Bool

    /// The type of framework to build.
    var frameworkType: FrameworkType

    /// An ordered set of `SDK`s to build the framework for.
    var sdks: OrderedSet<SDK>

    /// Extra build flags to pass to the build system.
    var extraFlags: ExtraFlags?

    /// Extra build parameters to pass to the build system.
    var extraBuildParameters: ExtraBuildParameters?

    /// A flag indicating whether to enable library evolution for the built framework.
    var enableLibraryEvolution: Bool

    /// A flag indicating whether to build a library for distribution.
    var enableBuildLibraryForDistribution: Bool
}

/// A structure for specifying extra build flags.
public struct ExtraFlags: Hashable, Codable {
    /// An array of additional C compiler flags.
    var cFlags: [String]?
    /// An array of additional C++ compiler flags.
    var cxxFlags: [String]?
    /// An array of additional Swift compiler flags.
    var swiftFlags: [String]?
    /// An array of additional linker flags.
    var linkerFlags: [String]?
}

public typealias ExtraBuildParameters = [String: String]

/// An enumeration of build configurations.
public enum BuildConfiguration: String, Codable {
    case debug
    case release

    var settingsValue: String {
        switch self {
        case .debug: return "Debug"
        case .release: return "Release"
        }
    }
}

/// An enumeration of the types of frameworks that can be built.
public enum FrameworkType: String, Codable {
    case dynamic
    case `static`
}

/// An enumeration of the supported SDKs.
public enum SDK: String, Codable {
    case iOS
    case iOSSimulator
    case watchOS
    case watchOSSimulator

    init?(platformName: String) {
        switch platformName {
        case "ios":
            self = .iOS
        case "watchos":
            self = .watchOS
        default:
            return nil
        }
    }

    /// Returns a set of SDKs for simulators based on the current SDK.
    func extractForSimulators() -> Set<SDK> {
        switch self {
        case .iOS: return [.iOS, .iOSSimulator]
        case .watchOS: return [.watchOS, .watchOSSimulator]
        default: return [self]
        }
    }

    var displayName: String {
        switch self {
        case .iOS:
            return "iOS"
        case .iOSSimulator:
            return "iPhone Simulator"
        case .watchOS:
            return "watchOS"
        case .watchOSSimulator:
            return "Watch Simulator"
        }
    }

    var settingValue: String {
        switch self {
        case .iOS:
            return "iphoneos"
        case .iOSSimulator:
            return "iphonesimulator"
        case .watchOS:
            return "watchos"
        case .watchOSSimulator:
            return "watchsimulator"
        }
    }

    var name: String {
        switch self {
        case .iOS:
            return "iphoneos"
        case .iOSSimulator:
            return "iphonesimulator"
        case .watchOS:
            return "watchos"
        case .watchOSSimulator:
            return "watchsimulator"
        }
    }

    var destination: String {
        switch self {
        case .iOS:
            return "generic/platform=iOS"
        case .iOSSimulator:
            return "generic/platform=iOS Simulator"
        case .watchOS:
            return "generic/platform=watchOS"
        case .watchOSSimulator:
            return "generic/platform=watchOS Simulator"
        }
    }
}
