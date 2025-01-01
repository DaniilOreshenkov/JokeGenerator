import Foundation

enum NetworkError: Error {
    case httpStatusCode
    case urlRequestError
    case noData
}
