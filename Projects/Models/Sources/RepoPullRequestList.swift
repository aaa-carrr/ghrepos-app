import Foundation

public struct RepoPullRequest: Decodable {
    public let id: Int
    public let url: String
    public let title: String
    public let body: String?
    public let user: PullRequestAuthor
    public let createdAt: String

    enum CodingKeys: String, CodingKey {
        case title, body, user, id
        case createdAt = "created_at"
        case url = "html_url"
    }

    public init(
        id: Int,
        url: String,
        title: String,
        body: String?,
        user: PullRequestAuthor,
        createdAt: String
    ) {
        self.id = id
        self.url = url
        self.title = title
        self.body = body
        self.user = user
        self.createdAt = createdAt
    }

    public struct PullRequestAuthor: Decodable {
        public let login: String
        public let avatarUrl: String

        public init(
            login: String,
            avatarUrl: String
        ) {
            self.login = login
            self.avatarUrl = avatarUrl
        }

        enum CodingKeys: String, CodingKey {
            case login
            case avatarUrl = "avatar_url"
        }
    }
}
