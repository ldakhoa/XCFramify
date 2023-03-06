import Foundation
import struct TSCBasic.AbsolutePath

protocol XcodeBuildCommand {
    var subCommand: String { get }
    var options: [XcodeBuildOption] { get }
    var environmentVaribles: [XcodeBuildEnvironmentVariable] { get }
}

extension XcodeBuildCommand {
    func buildArguments() -> [String] {
        ["/usr/bin/xcrun", "xcodebuild"]
        + environmentVaribles.map { pair in "\(pair.key)=\(pair.value)" }
        + [subCommand]
        + options.flatMap { option in ["-\(option.key)", option.value] }
            .compactMap { $0 }
    }

    func buildXCArchivePath(project: Project, sdk: SDK) -> AbsolutePath {
        project.archivesPath.appending(component: "\(sdk.name).xcarchive")
    }
}

struct XcodeBuildOption {
    var key: String
    var value: String?
}

struct XcodeBuildEnvironmentVariable {
    var key: String
    var value: String
}
