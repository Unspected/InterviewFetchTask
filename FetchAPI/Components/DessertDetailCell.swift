import SwiftUI

struct IngredientMeassuremnt {
    let nameIngredient: String
    let measurement: String
}

struct DessertDetailCell: View {
    
    @StateObject var model = DessertDetailViewModel(manager: MealManager(networkManager: NetworkManager()))
    let id: String
    
    var body: some View {
        
        VStack {
            switch model.state {
                
            case .initial, .loading:
                ProgressView()
            case .loaded(let mealDetail):
                MealDetailView(mealDetail)
            case .failed(let error):
                Text(error.localizedDescription)
            }
            Spacer()
        }
        .task {
            await model.fetchMealDetail(id)
        }
    }
    
    @ViewBuilder
    private func MealDetailView(_ meal: MealDetail) -> some View {
        ScrollView {
            VStack(spacing: 24) {
                AsyncImage(url: meal.strMealThumb) { image in
                    image.resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .cornerRadius(15.0)
                    
                } placeholder: {
                    ProgressView()
                }
                
                Text(meal.strInstructions)
                    .font(.body)
                ForEach(meal.ingredients, id: \.name) { ingredient in
                    HStack(spacing: 16) {
                        Text(ingredient.name)
                            .font(.caption)
                        Spacer()
                        Text(ingredient.measure)
                            .font(.caption)
                    }
                }
            }
            .navigationTitle(meal.strMeal)
            .padding()
        }
    }
}


