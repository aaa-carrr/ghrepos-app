import ProjectDescription

let project = Project(
    name: "RepoListFeature",
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
            name: "RepoListFeature",
            platform: .iOS,
            product: .framework,
            bundleId: "com.aaacarrr.RepoListFeature",
            deploymentTarget: .iOS(targetVersion: "14.4", devices: .iphone),
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "DesignSystem", path: "../DesignSystem"),
                .project(target: "Networking", path: "../Networking"),
                .project(target: "Reducers", path: "../Reducers"),
                .project(target: "Interactors", path: "../Interactors"),
                .project(target: "Models", path: "../Models"),
                .package(product: "RxSwift"),
                .package(product: "RxCocoa")
            ]
        ),
        Target(
            name: "RepoListFeatureTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "com.aaacarrr.RepoListFeatureTests",
            deploymentTarget: .iOS(targetVersion: "14.4", devices: .iphone),
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "RepoListFeature"),
                .package(product: "SnapshotTesting"),
                .package(product: "RxTest")
            ]
        )
    ]
)
