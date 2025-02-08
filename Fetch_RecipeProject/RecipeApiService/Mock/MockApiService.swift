//
//  MockApiService.swift
//  Fetch_RecipeProject
//
//  Created by Muralidhar reddy Kakanuru on 2/8/25.
//


import UIKit
import Foundation

class MockApiService: RecipeApiInterface {
    
    // ✅ Mock Recipes (for success cases)
    private let mockRecipes: [RecipeCusine] = [
        RecipeCusine(id: "1", name: "Pancakes", cuisine: "American", photoURLLarge: nil, photoURLSmall: nil, sourceURL: nil, youtubeURL: nil),
        RecipeCusine(id: "2", name: "Sushi", cuisine: "Japanese", photoURLLarge: nil, photoURLSmall: nil, sourceURL: nil, youtubeURL: nil)
    ]
    
    // ✅ Flags to simulate different scenarios
    var shouldReturnEmpty = false
    var shouldReturnMalformed = false
    var shouldFail = false
    
    func fetchRecipes(url: String) async throws -> [RecipeCusine] {
        if shouldFail {
            throw NetworkError.requestFailed(500, "Server Error")
        }
        if shouldReturnMalformed {
            throw NetworkError.decodingError("Malformed JSON")
        }
        if shouldReturnEmpty {
            return []
        }
        return mockRecipes
    }
    
    func fetchImages(url: String) async throws -> UIImage {
        if shouldFail {
            throw NetworkError.networkFailure("Failed to fetch image")
        }
        return UIImage(systemName: "photo")!  // ✅ Mock Image
    }
}
