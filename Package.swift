// swift-tools-version: 5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let version = "6.10.0"

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
      checksum: "5065ab565366f30f25f384e4e25eb6e9294dc760d563aa49989350bd2089d2a4"
    )
  ]
)
