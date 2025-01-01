import Foundation

protocol JokeLoadingProtocol {
    func fetch(url: URL, completion: Result<JokeGeneral, Error>)
}
