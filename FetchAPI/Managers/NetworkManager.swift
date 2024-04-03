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
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func fetch<T>(_ url: URL) async throws -> T where T : Decodable {
        // Use the async variant of URLSession to fetch data
            // Code might suspend here
        let (data, _) = try await urlSession.data(from: url)

        // Parse the JSON data
        let result = try decoder.decode(T.self, from: data)
        return result
        
    }
}


final class MealManager {
    
    private let networkManager: NetworkProtocol
    
    init(networkManager: NetworkProtocol) {
        self.networkManager = networkManager
    }
    
    func fetchMeals() async throws -> [Meal] {
        let response: MealsResponse<[Meal]> = try await networkManager.fetch(.list)
        return response.meals
    }
    
    func fetchMealDetail(id: Meal.ID) async throws -> MealDetail? {
        let response: MealsResponse<[MealDetail]> = try await networkManager.fetch(.detail(id: id))
        return response.meals.first
    }
}
