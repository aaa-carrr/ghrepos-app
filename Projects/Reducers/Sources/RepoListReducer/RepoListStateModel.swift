import Foundation

public struct RepoListStateModel {
    public let currentPage: Int
    public let numberOfPages: Int
    public let lastFetchedPage: Int
    public let isFetching: Bool
    public let repos: [RepoStateModel]

    public init(
        currentPage: Int,
        lastFetchedPage: Int,
        isFetching: Bool,
        numberOfPages: Int,
        repos: [RepoStateModel]
    ) {
        self.currentPage = currentPage
        self.isFetching = isFetching
        self.lastFetchedPage = lastFetchedPage
        self.numberOfPages = numberOfPages
        self.repos = repos
    }
}

public struct RepoStateModel {
    public let id: Int
    public let name: String
    public let description: String
    public let owner: OwnerStateModel
    public let stars: Int
    public let forks: Int

    public init(
        id: Int,
        name: String,
        description: String,
        owner: OwnerStateModel,
        stars: Int,
        forks: Int
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.owner = owner
        self.stars = stars
        self.forks = forks
    }


    public struct OwnerStateModel {
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
