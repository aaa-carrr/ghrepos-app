import Foundation

public struct RepoListInteractorResource {
    public let page: Int
    public let language: String

    public init(
        page: Int,
        language: String = "Swift"
    ) {
        self.page = page
        self.language = language
    }
}
