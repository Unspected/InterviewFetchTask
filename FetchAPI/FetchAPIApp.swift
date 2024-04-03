//
//  FetchAPIApp.swift
//  FetchAPI
//
//  Created by Pavel Andreev on 4/1/24.
//

import SwiftUI

enum DI {
    static let networkManager: NetworkProtocol = NetworkManager()
    static let mealManager: MealManager = MealManager(networkManager: networkManager)
    
    enum Preview {
        // TODO : mocks implementation
        static let networkManager: NetworkProtocol = NetworkManager()
        static let mealManager: MealManager = MealManager(networkManager: networkManager)
    }
}

@main
struct FetchAPIApp: App {
    
    var body: some Scene {
        WindowGroup {
            MainView(manager: DI.mealManager)
        }
    }
}
