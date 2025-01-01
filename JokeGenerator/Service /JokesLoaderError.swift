import Foundation

enum JokesLoaderError: Error {
    case invalidURL
    case networkError(Error)
    case decodingError(Error)
    case noData
}
