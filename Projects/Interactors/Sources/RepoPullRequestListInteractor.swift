import Foundation
import Networking
import Models
import RxSwift
import UIKit

public protocol RepoPullRequestListInteractorType {
    func pullRequestList(from resource: RepoPullRequestListResource) -> Single<[RepoPullRequest]>
    func authorProfileImage(from url: String) -> Single<UIImage>
}

public struct RepoPullRequestListInteractor: RepoPullRequestListInteractorType {
    private let networking:NetworkingType

    public init(
        networking: NetworkingType = Networking()
    ) {
        self.networking = networking
    }

    public func pullRequestList(from resource: RepoPullRequestListResource) -> Single<[RepoPullRequest]> {
        guard let url = URL(string: "https://api.github.com/repos/\(resource.author)/\(resource.repo)/pulls")
        else {
            return Single<[RepoPullRequest]>.create { single in
                single(.failure(NetworkingError.requestFailed))
                return Disposables.create {}
            }
        }
        let request = URLRequest(url: url)
        return networking.perform(request, for: [RepoPullRequest].self)
    }

    public func authorProfileImage(from url: String) -> Single<UIImage> {
        guard let url = URL(string: url) else {
            return Single<UIImage>.create { single in
                single(.failure(NetworkingError.requestFailed))
                return Disposables.create {}
            }
        }
        let request = URLRequest(url: url)
        return networking.loadImage(from: request)
    }
}

