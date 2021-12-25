import ProjectDescription

let project = Project(
    name: "DesignSystem",
    organizationName: "com.aaacarrr",
    packages: [
        .remote(
            url: "https://github.com/pointfreeco/swift-snapshot-testing.git",
            requirement: .exact("1.9.0")
        ),
        .remote(
            url: "https://github.com/ReactiveX/RxSwift.git",
            requirement: .exact("6.2.0")
        )
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
                .package(product: "RxSwift"),
                .package(product: "RxCocoa")
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
                .package(product: "SnapshotTesting")
            ]
        )
    ]
)
