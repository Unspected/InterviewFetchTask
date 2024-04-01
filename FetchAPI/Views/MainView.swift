//
//  MainView.swift
//  FetchAPI
//
//  Created by Pavel Andreev on 4/1/24.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel: MainViewModel
    
    init(manager: NetworkManager) {
        _viewModel = .init(wrappedValue: MainViewModel(manager: manager))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    ForEach(viewModel.meals, id: \.idMeal) { meal in
                        Text(meal.strMeal)
                        Text(meal.strMealThumb)
                    }
                }
            }
           
        }
        .onAppear {
            viewModel.fetchMeals()
        }
    }
    
}

#Preview {
    MainView(manager: NetworkManager())
}
