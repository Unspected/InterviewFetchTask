import Foundation

enum APIEndPoint {
    case list
    case detail(id: String)
    
    var url: URL {
        switch self {
        case .list:
            URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")!
        case .detail(id: let id):
            URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)")!
        }
    }
}

enum ServiceErrors: Error {
    case internalError(_ statusCode: Int)
    case serverError(_ statusCode: Int)
}


protocol NetworkProtocol {
    func fetch<T>(_ url: URL) async throws -> T where T : Decodable
    func fetch<T>(_ endPoint: APIEndPoint) async throws -> T where T : Decodable
}

extension NetworkProtocol {
    func fetch<T>(_ endPoint: APIEndPoint) async throws -> T where T : Decodable {
        try await fetch(endPoint.url)
    }
}

final class NetworkManager: NetworkProtocol {
    
    private let urlSession: URLSession
    
    private let decoder = JSONDecoder()
    
    // Initializer allowing for dependency injection of a URLSession, defaults to the shared session.
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func fetch<T>(_ url: URL) async throws -> T where T : Decodable {
        // Perform the URL session data task asynchronously, suspending until completion.
        let (data, response) = try await urlSession.data(from: url)
        
        // handle error
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            switch (response as! HTTPURLResponse).statusCode {
            case (400...499):
                throw ServiceErrors.internalError(( response as! HTTPURLResponse).statusCode)
            default:
                throw ServiceErrors.serverError(( response as! HTTPURLResponse).statusCode)
            }
        }
        
        // Parse the JSON data
        let result = try decoder.decode(T.self, from: data)
        return result
    }
}

