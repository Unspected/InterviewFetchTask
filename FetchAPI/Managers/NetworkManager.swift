
import Foundation
import Combine

protocol NetworkProtocol {
    
    func fetchElements<T:Decodable>(_ url: URL, resultQueue: DispatchQueue) -> AnyPublisher<T, Error>
}


final class NetworkManager: NetworkProtocol {
    
    private let urlSession: URLSession
    
    private let decoder = JSONDecoder()
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func fetchElements<T>(_ url: URL, resultQueue: DispatchQueue = .main) -> AnyPublisher<T, any Error> where T : Decodable {
        urlSession.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: T.self, decoder: decoder)
            .mapError { error in
                print(error.localizedDescription)
                return error
            }
            .receive(on: resultQueue)
            .eraseToAnyPublisher()
    }
}
