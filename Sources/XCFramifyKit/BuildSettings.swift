import Foundation

struct BuildSettings {
    /// All build settings given at initialization.
    let settings: [String: String]

    /// The target to which these settings apply.
    let target: String

    let scheme: Scheme

    init(
        settings: [String: String],
        target: String,
        scheme: Scheme
    ) {
        self.settings = settings
        self.target = target
        self.scheme = scheme
    }

    enum Error: Swift.Error, LocalizedError {
        case missingBuildSetting(key: String)

        var errorDescription: String? {
            switch self {
            case let .missingBuildSetting(setting):
                return "xcodebuild did not return a value for build setting \(setting)"
            }
        }
    }

    subscript(key: String) -> String? {
        settings[key]
    }

    // swiftlint:disable:this force_try
    private static let targetSettingsRegex = try! NSRegularExpression(
        pattern: "^Build settings for action (?:\\S+) and target \\\"?([^\":]+)\\\"?:$",
        options: [.caseInsensitive, .anchorsMatchLines ]
    )

    static func load<E: Executor>(fromScheme scheme: Scheme, executor: E = ProcessExecutor()) async throws -> BuildSettings {
        var currentSettings: [String: String] = [:]
        var currentTarget: String?

        try await executor.execute(
            "/usr/bin/xcrun",
            "xcodebuild",
            "-scheme",
            scheme.name,
            "-showBuildSettings",
            "-skipUnavailableActions"
        )
        .unwrapOutput()
        .enumerateLines { line, stop in
            if let result = self.targetSettingsRegex.firstMatch(in: line, range: NSRange(line.startIndex..., in: line)) {
                let targetRange = Range(result.range(at: 1), in: line)!
                currentTarget = String(line[targetRange])
                return
            }
            let trimSet = CharacterSet.whitespacesAndNewlines
            let components = line
                .split(maxSplits: 1) { $0 == "=" }
                .map { $0.trimmingCharacters(in: trimSet) }

            if components.count == 2 {
                currentSettings[components[0]] = components[1]
            }
        }

        return self.init(
            settings: currentSettings,
            target: currentTarget ?? "",
            scheme: scheme
        )
    }

    /// Attempts to determine the SDKs this scheme builds for.
    var buildSDKRawNames: Set<String> {
        let supportedPlatforms = self["SUPPORTED_PLATFORMS"]
        if let supportedPlatforms = supportedPlatforms {
            return Set(
                supportedPlatforms.split(separator: " ").map(String.init)
            )
        } else if let platformName = self["PLATFORM_NAME"] {
            return [platformName] as Set
        } else {
            return []
        }
    }
}
