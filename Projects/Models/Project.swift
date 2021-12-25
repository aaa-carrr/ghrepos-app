import ProjectDescription

let project = Project(
    name: "Models",
    organizationName: "com.aaacarrr",
    targets: [
        Target(
            name: "Models",
            platform: .iOS,
            product: .framework,
            bundleId: "com.aaacarrr.Models",
            deploymentTarget: .iOS(targetVersion: "14.4", devices: .iphone),
            infoPlist: .default,
            sources: ["Sources/**"]
        )
    ]
)
