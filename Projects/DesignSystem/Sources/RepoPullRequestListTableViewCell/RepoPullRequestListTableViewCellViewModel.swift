import Foundation

public struct RepoPullRequestListTableViewCellViewModel: Hashable {
    public let id: Int
    public let pullRequestTitle: String
    public let pullRequestBody: String
    public let pullRequestAuthor: UserProfileCompactViewModel
    public let pullRequestDateOfCreation: String

    public init(
        id: Int,
        pullRequestTitle: String,
        pullRequestBody: String,
        pullRequestAuthor: UserProfileCompactViewModel,
        pullRequestDateOfCreation: String
    ) {
        self.id = id
        self.pullRequestTitle = pullRequestTitle
        self.pullRequestBody = pullRequestBody
        self.pullRequestAuthor = pullRequestAuthor
        self.pullRequestDateOfCreation = pullRequestDateOfCreation
    }

    public static func == (lhs: RepoPullRequestListTableViewCellViewModel, rhs: RepoPullRequestListTableViewCellViewModel) -> Bool {
        return lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
}
