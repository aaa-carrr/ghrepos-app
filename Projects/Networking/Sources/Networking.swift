import Foundation
import RxSwift
import UIKit

public protocol NetworkingType {
    func perform<T: Decodable>(_ request: URLRequest, for type: T.Type) -> Single<T>
    func loadImage(from request: URLRequest) -> Single<UIImage>
}

public protocol HTTPClient {
    func dataTask(with: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: HTTPClient {}

public struct Networking: NetworkingType {
    private let http: HTTPClient
    public init(
        http: HTTPClient = URLSession.shared
    ) {
        self.http = http
    }

    public func perform<T: Decodable>(_ request: URLRequest, for type: T.Type) -> Single<T> {
        return Single.create { single in
            let serviceTask = http.dataTask(with: request, completionHandler: { (data, response, error) in
                if error != nil && response == nil {
                    single(.failure(NetworkingError.requestFailed))
                }

                if let httpResponse = response as? HTTPURLResponse {
                    guard 200...299 ~= httpResponse.statusCode else {
                        single(.failure(NetworkingError.unexpectedHTTPStatusCode))
                        return
                    }

                    guard let unwrappedData = data else {
                        single(.failure(NetworkingError.missingData))
                        return
                    }

                    do {
                        let decoder = JSONDecoder()
                        let decoded = try decoder.decode(T.self, from: unwrappedData)
                        single(.success(decoded))
                    } catch let error as Error {
                        single(.failure(NetworkingError.decodingFailed))
                    }

                } else {
                    single(.failure(NetworkingError.unexpectedResponseType))
                }
            })
            serviceTask.resume()

            return Disposables.create {
                serviceTask.cancel()
            }
        }
    }

    public func loadImage(from request: URLRequest) -> Single<UIImage> {
        return Single.create { single in
            let serviceTask = http.dataTask(with: request, completionHandler: { (data, response, error) in
                if error != nil && response == nil {
                    single(.failure(NetworkingError.requestFailed))
                }

                if let httpResponse = response as? HTTPURLResponse {
                    guard 200...299 ~= httpResponse.statusCode else {
                        single(.failure(NetworkingError.unexpectedHTTPStatusCode))
                        return
                    }

                    guard let unwrappedData = data else {
                        single(.failure(NetworkingError.missingData))
                        return
                    }

                    if let image = UIImage(data: unwrappedData) {
                        single(.success(image))
                    } else {
                        single(.failure(NetworkingError.decodingFailed))
                    }
                } else {
                    single(.failure(NetworkingError.unexpectedResponseType))
                }
            })
            serviceTask.resume()

            return Disposables.create {
                serviceTask.cancel()
            }
        }
    }
}

public enum NetworkingError: Error {
    case requestFailed
    case unexpectedHTTPStatusCode
    case missingData
    case decodingFailed
    case unexpectedResponseType
}
