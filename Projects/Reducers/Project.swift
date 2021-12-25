import ProjectDescription

let project = Project(
    name: "Reducers",
    organizationName: "com.aaacarrr",
    targets: [
        Target(
            name: "Reducers",
            platform: .iOS,
            product: .framework,
            bundleId: "com.aaacarrr.Reducers",
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "Models", path: "../Models")
            ]
        ),
        Target(
            name: "ReducersTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "com.aaacarrr.ReducersTests",
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "Reducers"),
            ]
        )
    ]
)
