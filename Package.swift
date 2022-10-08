// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "TwitchChat",
  platforms: [.macOS(.v12)],
  products: [
    .executable(
      name: "TwitchChatClient",
      targets: ["TwitchChatClient"]),
    .library(
      name: "TwitchChat",
      targets: ["TwitchChat"]),
  ],
  targets: [
    .executableTarget(
      name: "TwitchChatClient",
      dependencies: ["TwitchChat"]),
    .target(
      name: "TwitchChat",
      dependencies: []),
    .testTarget(
      name: "TwitchChatTests",
      dependencies: ["TwitchChat"]),
  ]
)
