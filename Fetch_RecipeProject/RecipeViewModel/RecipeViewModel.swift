//
//  FoodViewModel.swift
//  Fetch_RecipeProject
//
//  Created by Muralidhar reddy Kakanuru on 2/8/25.
//


import Foundation
import SwiftUI
import Observation

@Observable class RecipeViewModel {
    var foodGroups: [RecipeCusine] = []
    var isLoading: Bool = false
    
    private var networkManager: RecipeApiInterface
    
    init(networkManager: RecipeApiInterface ) {
        self.networkManager = networkManager
    }
    
    func fetchData() {
        guard !isLoading else { return }
        isLoading = true
        Task {
            do {
                let storedData: [RecipeCusine] = try await networkManager.fetchRecipes(url: ServerConstants.serverURL)
                self.foodGroups = storedData
            }
            catch {
                print("Error fetching data: \(error.localizedDescription)")
            }
            self.isLoading = false
        }
    }
    
    func fetchImage(url: String)async -> UIImage? {
        do {
            return try await networkManager.fetchImages(url: url)
        }
        catch {
            print("cant able to fetch image from url because of \(error)")
            return nil
        }
    }
}
