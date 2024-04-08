import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel: MainViewModel
    @Environment(\.colorScheme) var colorScheme
   
    
    init(manager: MealManager) {
        _viewModel = .init(wrappedValue: MainViewModel(manager: manager))
    }
    
    var body: some View {
        NavigationView {

            List(viewModel.meals ) { meal in
                NavigationLink(destination: DessertDetailView(id: meal.id, manager: DI.mealManager)) {
                    DessertCell(name: meal.name, imageURL: meal.thumb)
                }
            }
            .id(viewModel.isSorted)
            .toolbar(content: {
                ToolbarItem(placement: .navigation) {
                    Button(action: {
                        viewModel.isSorted.toggle()
                    },
                           label: {
                        Text(viewModel.isSorted ? "Sort to Z-A" : "Sort to A-Z")
                            .font(.headline)
                            .foregroundStyle( colorScheme == .dark ? .white : .black)
                        Image(systemName: viewModel.isSorted ? "arrow.down.square" : "arrow.up.square")
                            .foregroundStyle( colorScheme == .dark ? .white : .black)
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
    MainView(manager: DI.Preview.mealManager)
}
