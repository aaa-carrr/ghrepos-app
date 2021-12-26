import ProjectDescription

let project = Project(
    name: "Routers",
    organizationName: "com.aaacarrr",
    packages: [
        .remote(
            url: "https://github.com/ReactiveX/RxSwift.git",
            requirement: .exact("6.2.0")
        )
    ],
    targets: [
        Target(
            name: "Routers",
            platform: .iOS,
            product: .framework,
            bundleId: "com.aaacarrr.Routers",
            deploymentTarget: .iOS(targetVersion: "14.4", devices: .iphone),
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: [
                .package(product: "RxSwift"),
                .project(target: "Networking", path: "../Networking"),
                .project(target: "Interactors", path: "../Interactors"),
                .project(target: "RepoListFeature", path: "../RepoListFeature"),
                .project(target: "Reducers", path: "../Reducers")
            ]
        ),
        Target(
            name: "RoutersTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "com.aaacarrr.RoutersTests",
            deploymentTarget: .iOS(targetVersion: "14.4", devices: .iphone),
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "Routers"),
            ]
        )
    ]
)

