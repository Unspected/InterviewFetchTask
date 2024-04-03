import Foundation

@MainActor
final class DessertDetailViewModel: ObservableObject {
    
    // Public
    enum ViewModelError: LocalizedError {
        case mealNotFound
        
        var errorDescription: String? {
            switch self {
            case .mealNotFound: "Meal not found"
            }
        }
    }
    
    enum ViewState {
        case initial
        case loading
        case loaded(MealDetail)
        case failed(Error)
        
        var shouldFetch: Bool {
            switch self {
            case .initial, .failed: true
            case .loading, .loaded: false
            }
        }
        
    }
    
    @Published var state: ViewState = .initial
    
    // Private
    private let manager: MealManager
    
    init(manager: MealManager) {
        self.manager = manager
    }
    
    
    func fetchMealDetail(_ id: String) async {
        
        guard state.shouldFetch else {
            return
        }

        state = .loading
        
        do {
            let mealDetail = try await manager.fetchMealDetail(id: id)
            try Task.checkCancellation()
            if let mealDetail {
                self.state = .loaded(mealDetail)
            } else {
                self.state = .failed(ViewModelError.mealNotFound)
            }
        } catch {
            self.state = .failed(error)
        }
        
    }
}
