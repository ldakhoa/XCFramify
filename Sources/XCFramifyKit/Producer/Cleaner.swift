import Foundation

struct Cleaner<E: Executor> {
    private let rootProject: Project
    private let xcodebuild: XcodeBuildClient<E>

    init(rootProject: Project, executor: E = ProcessExecutor()) {
        self.rootProject = rootProject
        self.xcodebuild = .init(executor: executor)
    }

    func clean() async throws {
        logger.info("🗑️ Cleaning \(rootProject.name)...")
        try await xcodebuild.clean(project: rootProject)
    }
}
