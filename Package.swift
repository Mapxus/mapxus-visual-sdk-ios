// swift-tools-version: 5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let version = "6.7.0"

let package = Package(
  name: "MapxusVisualSDK",
  platforms: [
    .iOS(.v9),
  ],
  products: [
    .library(
      name: "MapxusVisualSDK",
      targets: ["MapxusVisualSDK"]),
  ],
  targets: [
    .binaryTarget(
      name: "MapxusVisualSDK",
      url: "https://nexus3.mapxus.com/repository/ios-sdk/\(version)/mapxus-visual-sdk-ios.zip",
      checksum: "566499fbf32fad8d710cde2ea7f9b49ceb839b6a028238702ce93a33aee33a7c"
    )
  ]
)
