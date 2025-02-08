//
//  EmptyStateView.swift
//  Fetch_RecipeProject
//
//  Created by Muralidhar reddy Kakanuru on 2/8/25.
//


import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack {
            Image(systemName: "tray.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.gray)
                .padding(.bottom, 10)

            Text("No Recipes Available")
                .font(.headline)
                .foregroundColor(.gray)
        }
        .padding()
    }
}
