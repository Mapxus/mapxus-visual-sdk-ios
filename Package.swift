// swift-tools-version: 5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let version = "8.0.0"

let package = Package(
  name: "MapxusVisualSDK",
  platforms: [
    .iOS(.v13),
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
      checksum: "1a7298ea999a2d985a5f620dae1b30e0b371a1728d439e1da9f94f9da7689bdd"
    )
  ]
)
