import UIKit

struct NetworkService: NetworkRoutingProtocol {
    func fetch(url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
               print("url request error - \(error.localizedDescription)")
                completion(.failure(.urlRequestError))
               return
             }
            
            if let response = response as? HTTPURLResponse,
               response.statusCode < 200 || response.statusCode >= 300 {
                print("Unexpected status code \(response.statusCode)")
                completion(.failure(.httpStatusCode))
                return
            }
            
            guard
                let data = data else {
                print("Data error")
                completion(.failure(.noData))
                return
            }
            
            completion(.success(data))
        }.resume()
    }
}
