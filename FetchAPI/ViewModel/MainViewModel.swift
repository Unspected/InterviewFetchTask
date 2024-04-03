
import Foundation
import Combine

protocol GetMealsProtocol {
    func fetchMeals() async
}

@MainActor
class MainViewModel: ObservableObject, GetMealsProtocol {
    
    @Published var meals: [Meal] = []
    private let manager: MealManager
    private var errorMessage: String = ""
    
    
    init(manager: MealManager) {
        self.manager = manager
    }
    
    // Protocol
    func fetchMeals() async {
        do {
            let meals = try await manager.fetchMeals()
            try Task.checkCancellation()
            self.meals = meals
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
}
