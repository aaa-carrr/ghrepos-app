import ProjectDescription

let project = Project(
    name: "Interactors",
    organizationName: "com.aaacarrr",
    targets: [
        Target(
            name: "Reducers",
            platform: .iOS,
            product: .framework,
            bundleId: "com.aaacarrr.Interactors",
            deploymentTarget: .iOS(targetVersion: "14.4", devices: .iphone),
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "Models", path: "../Models"),
                .project(target: "Networking", path: "../Networking")
            ]
        ),
        Target(
            name: "InteractorsTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "com.aaacarrr.InteractorsTests",
            deploymentTarget: .iOS(targetVersion: "14.4", devices: .iphone),
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "Interactors")
            ]
        )
    ]
)
