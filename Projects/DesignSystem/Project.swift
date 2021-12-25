import ProjectDescription

let project = Project(
    name: "DesignSystem",
    organizationName: "com.aaacarrr",
    packages: [
        .remote(url: "https://github.com/pointfreeco/swift-snapshot-testing.git", requirement: .exact("1.9.0"))
    ],
    targets: [
        Target(
            name: "DesignSystem",
            platform: .iOS,
            product: .framework,
            bundleId: "com.aaacarrr.DesignSystem",
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: [
                .xcframework(path: "../../Frameworks/RxSwift.xcframework"),
                .xcframework(path: "../../Frameworks/RxCocoaRuntime.xcframework"),
                .xcframework(path: "../../Frameworks/RxCocoa.xcframework")
            ]
        ),
        Target(
            name: "DesignSystemTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "com.aaacarrr.DesignSystemTests",
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "DesignSystem"),
                .xcframework(path: "../../Frameworks/RxSwift.xcframework"),
                .xcframework(path: "../../Frameworks/RxCocoaRuntime.xcframework"),
                .xcframework(path: "../../Frameworks/RxCocoa.xcframework"),
                .package(product: "SnapshotTesting")
            ]
        )
    ]
)
