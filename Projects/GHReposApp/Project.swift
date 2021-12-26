import ProjectDescription

let project = Project(
    name: "GHReposApp",
    organizationName: "com.aaacarrr",
    packages: [
        .remote(
            url: "https://github.com/ReactiveX/RxSwift.git",
            requirement: .exact("6.2.0")
        )
    ],
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
                .package(product: "RxSwift"),
                .package(product: "RxCocoa"),
                .project(target: "DesignSystem", path: "../DesignSystem"),
                .project(target: "Networking", path: "../Networking"),
                .project(target: "RepoListFeature", path: "../RepoListFeature")
            ]
        )
    ]
)
