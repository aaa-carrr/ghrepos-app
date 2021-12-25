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
            infoPlist: .default,
            sources: ["Sources/**"]
        )
    ]
)
