import ProjectDescription

let project = Project(
    name: "GHReposApp",
    organizationName: "com.aaacarrr",
    targets: [
        Target(
            name: "GHReposApp",
            platform: .iOS,
            product: .app,
            bundleId: "com.aaacarrr.GHReposApp",
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "Networking", path: "../Networking")
            ]
        )
    ]
)
