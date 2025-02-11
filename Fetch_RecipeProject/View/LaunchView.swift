//
//  LaunchView.swift
//  Fetch_RecipeProject
//
//  Created by Muralidhar reddy Kakanuru on 2/10/25.
//


import SwiftUI

struct LaunchView: View {
    @State private var isActive = false
    @State private var opacity = 0.0

    var body: some View {
        if isActive {
            ContentView() 
        } else {
            VStack {
                Image("app_logo") // Add your logo in Assets
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .opacity(opacity)
                    .animation(.easeIn(duration: 1.5), value: opacity)

                Text("Discover Delicious Recipes")
                    .font(.title2)
                    .foregroundColor(.white)
                    .opacity(opacity)
                    .animation(.easeIn(duration: 1.5).delay(0.5), value: opacity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .ignoresSafeArea()
            .onAppear {
                opacity = 1.0
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    isActive = true
                }
            }
        }
    }
}
