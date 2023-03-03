# Prism

⚠️ This project is currently under development. Feedbacks and pull requests are welcome.

Prism is a tool designed to wrap `xcodebuild` to build `xcframework`

This product is highly inspired by [Carthage](https://github.com/Carthage/Carthage), [swift-create-xcframework](https://github.com/unsignedapps/swift-create-xcframework) and [Scipio](https://github.com/giginet/Scipio).

### Options (not supported yet)

Updated...

|Flag|Description|Default|
|---------|------------|-----------|
|-\-configuration, -c|Build configuration for generated frameworks (debug/release)|release|
|-\-build-library-distribution|auaoeu|aoeu|
|-\-output, -o|Path indicates a XCFrameworks output directory|$PROJECT_ROOT/XCFrameworks|
|-\-static|Whether generated frameworks are Static Frameworks or not|-|
|-\-support-simulators|Whether also building for simulators of each SDKs or not|-|

## Usage

`prism create path/to/project`

## Why Prism

> It suggests the idea of breaking up light into its constituent colors. This is a fitting metaphor for what the tool does, which is to break up a static library into its constituent architectures in order to create an XCFramework that can be used across multiple platforms. The prism also reflects the tool's ability to simplify the process of creating cross-platform frameworks, which can often be complex and time-consuming. Additionally, the name Prism has a modern and futuristic feel, which is appropriate for a tool that is designed to facilitate cross-platform development.
