import UIKit

enum JokesLoaderError: Error {
    case invalidURL
    case networkError(Error)
    case decodingError(Error)
    case noData
}

struct JokesLoader {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    private var jokeGeneralUrl: URL? {
        guard let url = URL(string: R.URL.jokeUrl) else {
            print("Unable to construct jokeGeneralUrl")
            return nil
        }
        return url
    }
    
    func loadJokes(completion: @escaping (Result<JokeGeneral, JokesLoaderError>) -> Void) {
        guard let url = jokeGeneralUrl else {
            print("invalid URL")
            completion(.failure(.invalidURL))
            return
        }
        
        networkService.fetch(url: url) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let jokeGeneral = try decoder.decode(JokeGeneral.self, from: data)
                    completion(.success(jokeGeneral))
                } catch let error {
                    print("decoding error - \(error)")
                    completion(.failure(.decodingError(error)))
                }

            case .failure(let error):
                completion(.failure(.networkError(error)))
            }
        }
    }
}
