//
//  RecipeListView.swift
//  Fetch_RecipeProject
//
//  Created by Muralidhar reddy Kakanuru on 2/8/25.
//


import SwiftUI

struct RecipeListView: View {
    @State private var viewModel = RecipeViewModel(networkManager: RecipeApiService.shared)
    @State private var searchText = ""  // ✅ Add search text state

    var groupedRecipes: [String: [RecipeCusine]] {
        let filteredRecipes = viewModel.foodGroups.filter {
            searchText.isEmpty || $0.name.localizedCaseInsensitiveContains(searchText)
        }
        return Dictionary(grouping: filteredRecipes, by: { $0.cuisine })
    }

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading Recipes...")
                } else if viewModel.foodGroups.isEmpty {
                    VStack {
                        Text("No Recipes Available")
                            .font(.headline)
                        Button(action: {
                            viewModel.fetchData()
                        }) {
                            Label("Try Again", systemImage: "arrow.clockwise")
                                .font(.headline)
                                .padding()
                                .background(Color.blue.opacity(0.8))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                } else {
                    List {
                        ForEach(groupedRecipes.keys.sorted(), id: \.self) { cuisine in
                            Section(header: Text(cuisine).font(.headline)) {
                                ForEach(groupedRecipes[cuisine] ?? []) { recipe in
                                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                        RecipeRowView(recipe: recipe)
                                    }
                                }
                            }
                        }
                    }
                    .refreshable {
                        viewModel.fetchData()
                    }
                    .searchable(text: $searchText, prompt: "Search recipes")  // ✅ Add search bar
                }
            }
            .navigationTitle("Recipes by Cuisine")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.fetchData()
                    }) {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
            .onAppear {
                if viewModel.foodGroups.isEmpty {
                    viewModel.fetchData()
                }
            }
        }
    }
}

