import Foundation

public struct ReposTableViewCellViewModel: Hashable {
    let id: Int
    let repoName: String
    let repoDescription: String
    let repoAuthor: UserProfileCompactViewModel
    let repoStars: String
    let repoForks: String
    
    public static func == (lhs: ReposTableViewCellViewModel, rhs: ReposTableViewCellViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
}
