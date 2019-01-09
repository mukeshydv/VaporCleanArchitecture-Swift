// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "VaporCleanArchitecture-Swift",
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),

        // 🔵 Swift ORM (queries, models, relations, etc) built on SQLite 3.,
        .package(url: "https://github.com/vapor/fluent-sqlite.git", from: "3.0.0")
    ],
    targets: [
        .target(name: "App", dependencies: ["Vapor", "Data"]),
        .target(name: "Run", dependencies: ["App"]),
        .target(name: "Domain", dependencies: []),
        .target(name: "Data", dependencies: ["FluentSQLite", "Domain"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)
