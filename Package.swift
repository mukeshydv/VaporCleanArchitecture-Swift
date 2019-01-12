// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "VaporCleanArchitecture-Swift",
    dependencies: [
        /// Event-driven network application framework for high performance protocol servers & clients, non-blocking.
        .package(url: "https://github.com/apple/swift-nio.git", from: "1.8.0"),
        
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),

        // 🔵 Swift ORM (queries, models, relations, etc) built on PostgreSQL.,
        .package(url: "https://github.com/vapor/fluent-postgresql.git", from: "1.0.0")
    ],
    targets: [
        .target(name: "App", dependencies: ["Vapor", "Data"]),
        .target(name: "Run", dependencies: ["App"]),
        .target(name: "Domain", dependencies: ["NIO"]),
        .target(name: "Data", dependencies: ["FluentPostgreSQL", "Domain"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)
