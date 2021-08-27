//
//  MealDetailView.swift
//  Fido
//
//  Created by Naeem Ghossein
//

import SwiftUI

struct MealDetailView: View {
    
    // Binding for passing meal data between views
    @Binding var meal: Meals
    
    // State properties for reading and writing meal values
    @State private var noteText: String = "Example meal note"
    @State private var mealData: Meals.Data = Meals.Data()
    @State private var isPresented = false
    
    var body: some View {
        List {
            
            // Meal title section
            Section(header: Text("Meal")
                        .font(.subheadline)) {
                Text(meal.title)
            }
            
            // Meal time section
            Section(header: Text("Time")
                        .font(.subheadline)) {
                Text(meal.time, style: .time)
            }
            
            // Meal note section
            Section(header: Text("Note")
                        .font(.subheadline)) {
                Text(meal.note)
            }
        }
        .navigationTitle(meal.title)
        .listStyle(InsetGroupedListStyle())
        
        // Edit button used to bring up an EditView
        .navigationBarItems(trailing: Button("Edit") {
            isPresented = true
            mealData = meal.data
        }.foregroundColor(Color(UIColor.purple)))
        
        // EditView used to edit the selected meal's data
        .fullScreenCover(isPresented: $isPresented) {
            NavigationView {
                EditMealView(mealData: $mealData)
                    .navigationTitle(meal.title)
                    .navigationBarItems(leading: Button("Cancel") {
                        isPresented = false
                    }.foregroundColor(Color(UIColor.purple)), trailing: Button("Done") {
                        isPresented = false
                        meal.update(from: mealData)
                    }.foregroundColor(Color(UIColor.purple)))
            }
        }
    }
}

struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MealDetailView(meal: .constant(Meals.data[0]))
        }
    }
}
