//
//  RecipeDetailView.swift
//  Fetch_RecipeProject
//
//  Created by Muralidhar reddy Kakanuru on 2/8/25.
//


import SwiftUI

struct RecipeDetailView: View {
    let recipe: RecipeCusine

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                AsyncImage(url: URL(string: recipe.photoURLLarge ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 250)
                .clipShape(RoundedRectangle(cornerRadius: 10))

                Text(recipe.name)
                    .font(.largeTitle)
                    .bold()

                Text("Cuisine: \(recipe.cuisine)")
                    .font(.title3)
                    .foregroundColor(.gray)

                if let sourceURL = recipe.sourceURL, let url = URL(string: sourceURL) {
                    Link("View Full Recipe", destination: url)
                        .font(.headline)
                        .foregroundColor(.blue)
                }

                if let youtubeURL = recipe.youtubeURL, let url = URL(string: youtubeURL) {
                    Link("Watch on YouTube", destination: url)
                        .font(.headline)
                        .foregroundColor(.red)
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Recipe Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
