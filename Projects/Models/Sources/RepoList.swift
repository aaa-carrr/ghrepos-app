import Foundation

public struct RepoList: Decodable {
    public let totalCount: Int
    public let items: [RepoList.Repo]

    enum CodingKeys: String, CodingKey {
        case items
        case totalCount = "total_count"
    }

    public init(
        totalCount: Int,
        items: [RepoList.Repo]
    ) {
        self.totalCount = totalCount
        self.items = items
    }

    public struct Repo: Decodable {
        public let id: Int
        public let name: String
        public let owner: RepoList.Repo.RepoOwner
        public let description: String?
        public let stargazersCount: Int
        public let forks: Int

        public init(
            id: Int,
            name: String,
            owner: RepoList.Repo.RepoOwner,
            description: String?,
            stargazersCount: Int,
            forks: Int
        ) {
            self.id = id
            self.name = name
            self.owner = owner
            self.description = description
            self.stargazersCount = stargazersCount
            self.forks = forks
        }

        enum CodingKeys: String, CodingKey {
            case id, name, owner, description, forks
            case stargazersCount = "stargazers_count"
        }

        public struct RepoOwner: Decodable {
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
}
