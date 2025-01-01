import Foundation

protocol JokeLoadingProtocol {
    var jokeGeneralUrl: URL? { get }
    func loadJokes(completion: @escaping (Result<JokeGeneral, JokesLoaderError>) -> Void)
}
