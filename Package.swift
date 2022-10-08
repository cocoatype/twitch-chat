// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "TwitchChat",
  platforms: [.macOS(.v12),.iOS(.v15)],
  products: [
    .executable(
      name: "TwitchChatClient",
      targets: ["TwitchChatClient"]
    ),
    .library(
      name: "TwitchChat",
      targets: ["TwitchChat"]
    ),
    .library(
        name: "TwitchChatAppKit",
        targets: ["TwitchChatAppKit"]
    )
  ],
  targets: [
    .executableTarget(
      name: "TwitchChatClient",
      dependencies: ["TwitchChat"]
    ),
    .target(name: "TwitchChat"),
    .target(
        name: "TwitchChatAppKit",
        dependencies: ["TwitchChat"]
    ),
    .testTarget(
      name: "TwitchChatTests",
      dependencies: ["TwitchChat"]
    ),
  ]
)
