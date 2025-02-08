//
//  Fetch_RecipeProjectApp.swift
//  Fetch_RecipeProject
//
//  Created by Muralidhar reddy Kakanuru on 2/8/25.
//

import SwiftUI

@main
struct Fetch_RecipeProjectApp: App {
    private let useMockAPI = false
    
    var body: some Scene {
        WindowGroup {
            let apiService: RecipeApiInterface = useMockAPI ? MockApiService() : RecipeApiService.shared
            ContentView()
                .environment(RecipeViewModel(networkManager: apiService)) 
        }
    }
}

