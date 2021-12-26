import Foundation

public struct RepoPullRequestListStateModel {
    public let repoAuthor: String
    public let repoName: String
    public let currentPage: Int
    public let canFetchNewPage: Bool
    public let pullRequests: [RepoPullRequestStateModel]

    public init(
        repoAuthor: String,
        repoName: String,
        currentPage: Int,
        canFetchNewPage: Bool,
        pullRequests: [RepoPullRequestStateModel]
    ) {
        self.repoName = repoName
        self.repoAuthor = repoAuthor
        self.currentPage = currentPage
        self.canFetchNewPage = canFetchNewPage
        self.pullRequests = pullRequests
    }
}

public struct RepoPullRequestStateModel {
    public let id: Int
    public let title: String
    public let body: String
    public let author: AuthorStateModel
    public let url: String
    public let dateOfCreation: String

    public init(
        id: Int,
        title: String,
        body: String,
        author: AuthorStateModel,
        url: String,
        dateOfCreation: String
    ) {
        self.id = id
        self.title = title
        self.body = body
        self.author = author
        self.url = url
        self.dateOfCreation = dateOfCreation
    }

    public struct AuthorStateModel {
        public let name: String
        public let avatarUrl: String

        public init(
            name: String,
            avatarUrl: String
        ) {
            self.name = name
            self.avatarUrl = avatarUrl
        }
    }
}
