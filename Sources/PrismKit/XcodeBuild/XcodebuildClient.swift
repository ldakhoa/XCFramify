import Foundation

struct XcodeBuildClient<E: Executor> {
    let executor: E

    func createXCFramework(
        project: Project,
        buildConfiguration: BuildConfiguration,
        sdks: Set<SDK>,
        debugSymbolPaths: [URL]?,
        outputDir: URL
    ) async throws {
        try await executor.execute(CreateXCFrameworkCommand(
            project: project,
            buildConfiguration: buildConfiguration,
            sdks: sdks,
            debugSymbolPaths: debugSymbolPaths,
            outputDir: outputDir
        ))
    }

    func archive(
        project: Project,
        buildConfiguration: BuildConfiguration,
        sdk: SDK
    ) async throws {
        try await executor.execute(ArchiveCommand(
            project: project,
            buildConfiguration: buildConfiguration,
            sdk: sdk
        ))
    }

    func clean(project: Project) async throws {
        try await executor.execute(CleanCommand(project: project))
    }
}

extension Executor {
    @discardableResult
    fileprivate func execute(_ command: some XcodeBuildCommand) async throws -> ExecutorResult {
        try await execute(command.buildArguments())
    }
}
