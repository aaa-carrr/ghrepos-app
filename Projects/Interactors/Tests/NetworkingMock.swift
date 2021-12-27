import Networking
import RxSwift
import UIKit

final class NetworkingTypeMock: NetworkingType {
    var imageToReturn: UIImage?

    func perform<T>(_ request: URLRequest, for type: T.Type) -> Single<T> where T : Decodable {
        return Single.error(NetworkingError.decodingFailed)
    }

    func loadImage(from request: URLRequest) -> Single<UIImage> {
        return Single.just(imageToReturn ?? UIImage())
    }
}
