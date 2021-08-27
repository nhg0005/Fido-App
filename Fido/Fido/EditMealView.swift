//
//  EditMealView.swift
//  Fido
//
//  Created by Naeem Ghossein
//

import SwiftUI

struct EditMealView: View {
    
    // Binding for passing meal data between views
    @Binding var mealData: Meals.Data
    
    var body: some View {
        List {
            Section(header: Text("Meal")
                        .font(.subheadline)) {
                TextField("Meal", text: $mealData.title)
            }
            Section(header: Text("Time")
                        .font(.subheadline)) {
                DatePicker("Time", selection: $mealData.time, displayedComponents: .hourAndMinute)
            }
            Section(header: Text("Note")
                        .font(.subheadline)) {
                TextEditor(text: $mealData.note)
            }
        }
        .navigationTitle(mealData.title)
        .listStyle(InsetGroupedListStyle())
    }
}

struct EditMealView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EditMealView(mealData: .constant(Meals.data[0].data))
        }
    }
}
