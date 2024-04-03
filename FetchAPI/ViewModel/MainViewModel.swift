import Foundation
import Combine

protocol GetMealsProtocol {
    func fetchMeals() async
}

@MainActor
class MainViewModel: ObservableObject, GetMealsProtocol {
    
    // Public
    @Published var meals: [Meal] = []
    
    // Private
    private let manager: MealManager
    private var errorMessage: String = ""
    
    init(manager: MealManager) {
        self.manager = manager
    }
    
    // Protocol Methods
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
