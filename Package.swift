// swift-tools-version: 5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let version = "7.5.0"

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
      checksum: "f45029a0b72d8833b271f993b8ae34a91666226b061bfc725cb523e080eb628d"
    )
  ]
)
