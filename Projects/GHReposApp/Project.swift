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
            deploymentTarget: .iOS(targetVersion: "14.4", devices: .iphone),
            infoPlist: .extendingDefault(with: [
                "UILaunchStoryboardName": .string("LaunchScreen.storyboard")
            ]),
            sources: ["Sources/**"],
            resources: [
                "Resources/LaunchScreen.storyboard"
            ],
            dependencies: [
                .project(target: "Routers", path: "../Routers")
            ]
        )
    ]
)
