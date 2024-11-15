import ProjectDescription

let project = Project(
    name: "Networking",
    organizationName: "com.aaacarrr",
    packages: [
        .remote(
            url: "https://github.com/ReactiveX/RxSwift.git",
            requirement: .exact("6.2.0")
        )
    ],
    targets: [
        Target(
            name: "Networking",
            platform: .iOS,
            product: .framework,
            bundleId: "com.aaacarrr.Networking",
            deploymentTarget: .iOS(targetVersion: "14.4", devices: .iphone),
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: [
                .package(product: "RxSwift"),
                .project(target: "Models", path: "../Models")
            ]
        ),
        Target(
            name: "NetworkingTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "com.aaacarrr.NetworkingTests",
            deploymentTarget: .iOS(targetVersion: "14.4", devices: .iphone),
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "Networking")
            ]
        )
    ]
)
