# XCFramify

⚠️ This project is currently under development. Feedbacks and pull requests are welcome.

XCFramify is a tool designed to wrap `xcodebuild` to build `xcframework`

This product is highly inspired by [Carthage](https://github.com/Carthage/Carthage), [swift-create-xcframework](https://github.com/unsignedapps/swift-create-xcframework) and [Scipio](https://github.com/giginet/Scipio).

### Options (not supported yet)

Updated...

|Flag|Description|Default|
|---------|------------|-----------|
|-\-configuration, -c|Build configuration for generated frameworks (debug/release)|release|
|-\-build-library-distribution| TBD | TBD |
|-\-output, -o|Path indicates a XCFrameworks output directory|$PROJECT_ROOT/XCFrameworks|
|-\-static|Whether generated frameworks are Static Frameworks or not|-|
|-\-support-simulators|Whether also building for simulators of each SDKs or not|-|

## Usage

`xcframify create path/to/project`

## Why XCFramify

The name "XCFramify" combines the acronym for Xcode (XC), the term "framework," and the suffix "-ify," which suggests the tool's ability to generate, create or produce.
