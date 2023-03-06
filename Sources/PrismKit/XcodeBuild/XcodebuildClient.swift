import Foundation
import struct TSCBasic.AbsolutePath

struct XcodeBuildClient<E: Executor> {
    let executor: E

    func createXCFramework(
        project: Project,
        buildConfiguration: BuildConfiguration,
        sdks: Set<SDK>,
        debugSymbolPaths: [URL]?,
        outputDir: AbsolutePath
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
        sdk: SDK,
        scheme: Scheme
    ) async throws {
        try await executor.execute(ArchiveCommand(
            project: project,
            buildConfiguration: buildConfiguration,
            sdk: sdk,
            scheme: scheme
        ))
    }

    func list(
        project: Project,
        buildConfiguration: BuildConfiguration
    ) async throws -> ExecutorResult {
        try await executor.execute(ListCommand(
            buildConfiguration: buildConfiguration,
            project: project
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
