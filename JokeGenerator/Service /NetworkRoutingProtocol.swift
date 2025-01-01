import Foundation

protocol NetworkRoutingProtocol {
    func fetch(url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void)
}
