// swift-tools-version: 5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let version = "6.5.0"

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
      checksum: "ec535350ce450203e26e045ff314926f28ee8353d9d4f168c9a58e90b5de17f3")
  ]
)
