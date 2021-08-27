//
//  FidoApp.swift
//  Fido
//
//  Created by Naeem Ghossein
//

import SwiftUI

@main
struct FidoApp: App {
    
    init() {
        // Applies to large text displaymode
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.purple]

        // Applies to .inline text displaymode
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.purple]
    }
    
    // Data from each model observed throughout the app
    @ObservedObject private var mealData = MealData()
    @ObservedObject private var medicationData = MedicationData()
    @ObservedObject private var walkData = WalkData()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView(meals: $mealData.meals, medications: $medicationData.medications, walks: $walkData.walks) {
                    
                    // Save the user's data when the app is inactive
                    mealData.save()
                    medicationData.save()
                    walkData.save()
                }
            }
            // Load the user's data when the app is active
            .onAppear {
                mealData.load()
                medicationData.load()
                walkData.load()
            }
            .accentColor(Color(UIColor.purple))
        }
    }
}
