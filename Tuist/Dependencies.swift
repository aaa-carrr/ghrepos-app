import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: SwiftPackageManagerDependencies(
        [
            .remote(
                url: "https://github.com/ReactiveX/RxSwift.git",
                requirement: .exact("6.2.0")
            )
        ],
        productTypes: [
            "RxSwift": .dynamicLibrary,
            "RxCocoa": .dynamicLibrary,
            "RxCocoaRuntime": .dynamicLibrary,
            "RxTest": .dynamicLibrary,
        ]
    ),
    platforms: [.iOS]
)
