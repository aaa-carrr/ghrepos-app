import Foundation

public enum NetworkingError: Error {
    case requestFailed
    case unexpectedHTTPStatusCode
    case missingData
    case decodingFailed
    case unexpectedResponseType
    case failedToLoadImage
}
