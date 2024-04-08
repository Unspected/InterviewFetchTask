import Foundation
import Combine

@MainActor
class MainViewModel: ObservableObject {
    
    // Public
    @Published var meals: [Meal] = []
    @Published var isSorted: Bool = false {
        didSet {
            toggleSorting()
        }
    }
    
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
    
    private func toggleSorting() {
        meals.sort(by: { isSorted ? $0.strMeal < $1.strMeal : $0.strMeal > $1.strMeal })
    }
}
