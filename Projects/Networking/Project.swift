import ProjectDescription

let project = Project(
    name: "Networking",
    organizationName: "com.aaacarrr",
    targets: [
        Target(
            name: "Networking",
            platform: .iOS,
            product: .framework,
            bundleId: "com.aaacarrr.Networking",
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: [
                .xcframework(path: "../../Frameworks/RxSwift.xcframework"),
                .project(target: "Models", path: "../Models")
            ]
        ),
        Target(
            name: "NetworkingTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "com.aaacarrr.NetworkingTests",
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "Networking"),
                .xcframework(path: "../../Frameworks/RxSwift.xcframework"),
            ]
        )
    ]
)
