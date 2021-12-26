import Foundation

public struct UserProfileCompactViewModel {
    public let username: String
    public let profileImage: LoadableImage
    
    public init(
        username: String,
        profileImage: LoadableImage
    ) {
        self.username = username
        self.profileImage = profileImage
    }
}
