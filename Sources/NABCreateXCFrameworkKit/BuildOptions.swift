import Foundation
import OrderedCollections

struct BuildOptions: Hashable, Codable {
    init(
        buildConfiguration: BuildConfiguration,
        isDebugSymbolsEmbedded: Bool,
        frameworkType: FrameworkType,
        sdks: OrderedSet<SDK>,
        extraFlags: ExtraFlags?,
        extraBuildParameters: ExtraBuildParameters?,
        enableLibraryEvolution: Bool,
        enableBuildLibraryForDistribution: Bool,
        enableSkipInstall: Bool
    ) {
        self.buildConfiguration = buildConfiguration
        self.isDebugSymbolsEmbedded = isDebugSymbolsEmbedded
        self.frameworkType = frameworkType
        self.sdks = sdks
        self.extraFlags = extraFlags
        self.extraBuildParameters = extraBuildParameters
        self.enableLibraryEvolution = enableLibraryEvolution
        self.enableBuildLibraryForDistribution = enableBuildLibraryForDistribution
        self.enableSkipInstall = enableSkipInstall
    }

    var buildConfiguration: BuildConfiguration
    var isDebugSymbolsEmbedded: Bool
    var frameworkType: FrameworkType
    var sdks: OrderedSet<SDK>
    var extraFlags: ExtraFlags?
    var extraBuildParameters: ExtraBuildParameters?
    var enableLibraryEvolution: Bool
    var enableBuildLibraryForDistribution: Bool
    var enableSkipInstall: Bool
}

public struct ExtraFlags: Hashable, Codable {
    var cFlags: [String]?
    var cxxFlags: [String]?
    var swiftFlags: [String]?
    var linkerFlags: [String]?
}

public typealias ExtraBuildParameters = [String: String]

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

public enum FrameworkType: String, Codable {
    case dynamic
    case `static`
}

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
