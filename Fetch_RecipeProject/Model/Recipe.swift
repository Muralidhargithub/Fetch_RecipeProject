//
//  FoodItem.swift
//  Fetch_RecipeProject
//
//  Created by Muralidhar reddy Kakanuru on 2/8/25.
//


import Foundation


// MARK: - Models
struct RecipeResponse: Decodable {
    let recipes: [RecipeCusine]
}

struct RecipeCusine: Decodable, Identifiable {
    let id: String
    let name: String
    let cuisine: String
    let photoURLLarge: String?
    let photoURLSmall: String?
    let sourceURL: String?
    let youtubeURL: String?

    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case name
        case cuisine
        case photoURLLarge = "photo_url_large"
        case photoURLSmall = "photo_url_small"
        case sourceURL = "source_url"
        case youtubeURL = "youtube_url"
    }
}


//struct RecipeResponse: Decodable {
//    let recipes: [Recipe]
//}
//
//struct Recipe: Decodable, Identifiable {
//    let id: String
//    let name: String
//    let cuisine: String
//    let photoURLSmall: String?
//    let photoURLLarge: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id = "uuid"
//        case name
//        case cuisine
//        case photoURLSmall = "photo_url_small"
//        case photoURLLarge = "photo_url_large"
//    }
//}
