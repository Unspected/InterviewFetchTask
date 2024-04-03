import SwiftUI

struct IngredientMeassuremnt {
    let nameIngredient: String
    let measurement: String
}

struct DessertDetailView: View {
    
    
    @StateObject var model: DessertDetailViewModel
    let id: String
    
    init(id: String, manager: MealManager) {
        self.id = id
        _model = .init(wrappedValue: DessertDetailViewModel(manager: manager))
    }
    
    
    
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
                ForEach(meal.ingredients, id: \.id) { ingredient in
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

#Preview {
    DessertDetailView(id: "1", manager: DI.Preview.mealManager)
}
