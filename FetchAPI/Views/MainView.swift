import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel: MainViewModel
    @State var isSorted: Bool = true
    
    init(manager: MealManager) {
        _viewModel = .init(wrappedValue: MainViewModel(manager: manager))
    }
    
    var body: some View {
        NavigationView {

            List(viewModel.meals ) { meal in
                NavigationLink(destination: DessertDetailCell(id: meal.id)) {
                    DessertCell(name: meal.strMeal, imageURL: meal.strMealThumb)
                }
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigation) {
                    Button(action: {
                        isSorted.toggle()
                        viewModel.meals.sort(by: { isSorted ? $0.strMeal < $1.strMeal : $0.strMeal > $1.strMeal })
                    },
                           label: {
                        Text(isSorted ? "Sort to Z-A" : "Sort to A-Z")
                    })
                    
                }
            })
        }
        .task {
            await viewModel.fetchMeals()
        }
    }
}
    

#Preview {
    MainView(manager: MealManager(networkManager: NetworkManager()))
}
