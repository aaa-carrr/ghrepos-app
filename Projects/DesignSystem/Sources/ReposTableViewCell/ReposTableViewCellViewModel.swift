import Foundation

public struct ReposTableViewCellViewModel: Hashable {
    public let id: Int
    public let repoName: String
    public let repoDescription: String
    public let repoAuthor: UserProfileCompactViewModel
    public let repoStars: String
    public let repoForks: String
    
    public init(
        id: Int,
        repoName: String,
        repoDescription: String,
        repoAuthor: UserProfileCompactViewModel,
        repoStars: String,
        repoForks: String
    ) {
        self.id = id
        self.repoName = repoName
        self.repoDescription = repoDescription
        self.repoAuthor = repoAuthor
        self.repoStars = repoStars
        self.repoForks = repoForks
    }
    
    public static func == (lhs: ReposTableViewCellViewModel, rhs: ReposTableViewCellViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
}
