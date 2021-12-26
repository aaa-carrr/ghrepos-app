import Foundation

public struct RepoPullRequestListResource {
    public let author: String
    public let repo: String

    public init(
        author: String,
        repo: String
    ) {
        self.author = author
        self.repo = repo
    }
}
