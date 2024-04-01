
import Foundation
import Combine

protocol GetMealsProtocol {
    func fetchMeals()
}

class MainViewModel: ObservableObject, GetMealsProtocol {
    
    private var cancallables = Set<AnyCancellable>()
    @Published var meals: [Meal] = []
    @Published var mealDetail: MealDetail? = nil
    
    private let manager: NetworkManager
    private var errorMessage: String = ""
    
    
    init(manager: NetworkManager) {
        self.manager = manager
    }
    
    // Protocol
    func fetchMeals() {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else { return }
        
        manager.fetchElements(url)
            .sink(
                receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .finished:
                        print("finished")
                    case .failure(let error):
                        self?.errorMessage = error.localizedDescription
                    }
                }, receiveValue: { [weak self] (response: Meals) in
                    guard let self else { return }
                    self.meals = response.meals
                })
            .store(in: &cancallables)
    }
    
    func fetchMealDetail(_ id: String) {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)") else { return }
        
        manager.fetchElements(url)
            .sink(
                receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .finished:
                        print("finished")
                    case .failure(let error):
                        self?.errorMessage = error.localizedDescription
                    }
                }, receiveValue: { [weak self] (response: MealDetail) in
                    self?.mealDetail = response
                    
                })
            .store(in: &cancallables)
        
        
    }
    
}
