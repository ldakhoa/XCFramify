import Foundation
import Logging
import Rainbow

// TODO: Rename label
private(set) var logger = Logger(label: "space.khoale.xcframify")

extension Logger.MetadataValue {
    static func color(_ color: NamedColor) -> Self {
        .stringConvertible(color.rawValue)
    }
}

extension Logger.Metadata {
    static func color(_ color: NamedColor) -> Self { ["color": .color(color)] }
}

extension Logger {
    func error(_ error: Error) {
        if let error = error as? LocalizedError, let description = error.errorDescription {
            self.error("❌ \(description)", metadata: .color(.red))
        } else {
            self.error("❌ \(error.localizedDescription)", metadata: .color(.red))
        }
    }
}

func setLogLevel(_ level: Logger.Level) {
    logger.logLevel = level
}
