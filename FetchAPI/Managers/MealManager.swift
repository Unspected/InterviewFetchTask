import Foundation

final class MealManager {
    
    private let networkManager: NetworkProtocol
    
    init(networkManager: NetworkProtocol) {
        self.networkManager = networkManager
    }
    
    // Fetches a list of meals from a network source.
    func fetchMeals() async throws -> [Meal] {
        // The response is expected to conform to MealsResponse<[Meal]>, a generic type expecting an array of Meal.
        let response: MealsResponse<[Meal]> = try await networkManager.fetch(.list)
        return response.meals
    }
    
    // Fetch meal detail
    func fetchMealDetail(id: Meal.ID) async throws -> MealDetail? {
        // The response is expected to conform to MealsResponse<[MealDetail]>, which is a generic type expecting an array of MealDetail.
        let response: MealsResponse<[MealDetail]> = try await networkManager.fetch(.detail(id: id))
        return response.meals.first
    }
}
