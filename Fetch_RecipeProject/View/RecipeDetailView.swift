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
        VStack {
            // Recipe Image
            AsyncImage(url: URL(string: recipe.photoURLLarge ?? recipe.photoURLSmall ?? "")) { image in
                image.resizable()
                    .scaledToFit()
                    .frame(height: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            } placeholder: {
                ProgressView()
            }
            .padding()

            // Recipe Name
            Text(recipe.name)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top, 10)

                .padding(.vertical)

            // Action Buttons
            VStack(spacing: 5) {
                if let sourceURL = recipe.sourceURL, !sourceURL.isEmpty {
                    Button(action: {
                        if let url = URL(string: sourceURL) {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        Text("View Recipe")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }

                if let youtubeURL = recipe.youtubeURL, !youtubeURL.isEmpty {
                    Button(action: {
                        if let url = URL(string: youtubeURL) {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        Text("Watch on YouTube")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding()
        .background(Color(.systemGroupedBackground))
        .navigationBarTitleDisplayMode(.inline)
    }
}




