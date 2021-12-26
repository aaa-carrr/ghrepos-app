import Foundation
import Networking
import Models
import RxSwift
import UIKit

public protocol RepoListInteractorType {
    func repoList(from resource: RepoListInteractorResource) -> Single<RepoList>
    func authorProfileImage(from url: String) -> Single<UIImage>
}

public struct RepoListInteractor: RepoListInteractorType {
    private let networking:NetworkingType

    public init(
        networking: NetworkingType = Networking()
    ) {
        self.networking = networking
    }

    public func repoList(from resource: RepoListInteractorResource) -> Single<RepoList> {
        guard let url = URL(string: "https://api.github.com/search/repositories?q=language:\(resource.language)&sort=stars&page=\(resource.page)")
        else {
            return Single<RepoList>.create { single in
                single(.failure(NetworkingError.requestFailed))
                return Disposables.create {}
            }
        }
        let request = URLRequest(url: url)
        return networking.perform(request, for: RepoList.self)
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

