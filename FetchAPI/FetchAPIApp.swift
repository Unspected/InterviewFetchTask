//
//  FetchAPIApp.swift
//  FetchAPI
//
//  Created by Pavel Andreev on 4/1/24.
//

import SwiftUI

@main
struct FetchAPIApp: App {
    
    private let manager = MealManager(networkManager: NetworkManager())
    
    var body: some Scene {
        WindowGroup {
            MainView(manager: manager)
        }
    }
}
