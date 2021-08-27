//
//  HomeView.swift
//  Fido
//
//  Created by Naeem Ghossein
//

import SwiftUI

struct HomeView: View {
    // Bindings for passing data between views
    @Binding var meals: [Meals]
    @Binding var medications: [Medications]
    @Binding var walks: [Walks]
    
    // Scene Phase environment used to indicate the current operational state
    @Environment(\.scenePhase) private var scenePhase
    
    // Variables used to bring up the Add child views
    @State private var isPresentedMeal = false
    @State private var isPresentedMedication = false
    @State private var isPresentedWalk = false
    
    // Variables for storing and passing data for new entities
    @State private var newMealData = Meals.Data()
    @State private var newMedicationData = Medications.Data()
    @State private var newWalkData = Walks.Data()
    
    // ObservedObject for notification manager's data
    @ObservedObject var notificationManager = LocalNotificationManager()
    
    let saveAction: () -> Void
    
    // Date Formatters
    // Get the month in Int form
    static let monthIntFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        return formatter
    }()
    // Get the day in Int form
    static let dayIntFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter
    }()
    
    var body: some View {
        List {
            // Meal section
            Section(header: Text("Meals")
                        .font(.subheadline)) {
                ForEach(meals) { meal in
                    NavigationLink(destination: MealDetailView(meal: binding(for: meal))) {
                        Text(meal.title)
                        Spacer()
                        Text(meal.time, style: .time)
                    }
                }
                .onDelete(perform: removeMeals)
            }
            
            // Walk section
            Section(header: Text("Walks")
                    .font(.subheadline)) {
                ForEach(walks) { walk in
                    NavigationLink(destination: WalkDetailView(walk: binding(for: walk))) {
                        Text(walk.time, style: .time)
                    }
                }
                .onDelete(perform: removeWalks)
            }
            
            // Medication section
            Section(header: Text("Medications")
                        .font(.subheadline)) {
                ForEach(medications) { medication in
                    NavigationLink(destination: MedicationDetailView(medication: binding(for: medication))) {
                        Text(medication.title)
                        Spacer()
                        Text("\(medication.time, formatter: Self.monthIntFormat)/\(medication.time, formatter: Self.dayIntFormat)")
                    }
                }
                .onDelete(perform: removeMedications)
            }
        }
        .navigationTitle("Fido")
        
        // Add (plus) button with options for adding different entities
        .navigationBarItems(trailing: Menu {
            Button("Meal", action: { isPresentedMeal = true })
            Button("Walk", action: { isPresentedWalk = true })
            Button("Medication", action: {isPresentedMedication = true })
        } label: {
            Image(systemName: "plus")
                        .foregroundColor(Color(UIColor.purple))
        })
        
        // Sheet for adding new meals
        .sheet(isPresented: $isPresentedMeal) {
            NavigationView {
                EditMealView(mealData: $newMealData)
                    .navigationBarItems(leading: Button("Dismiss") {
                        isPresentedMeal = false
                    }
                    .foregroundColor(Color(UIColor.purple)), trailing: Button("Add") {
                        
                        // Save the new meal data
                        let newMeal = Meals(title: newMealData.title, time: newMealData.time, note: newMealData.note)
                        meals.append(newMeal)
                        isPresentedMeal = false
                        
                        // Create meal notification
                        self.notificationManager.sendMealNotification(id: newMeal.id, title: "Fido", subtitle: newMeal.title, body: "Time for a meal!", date: newMeal.time)
                    }
                    .foregroundColor(Color(UIColor.purple)))
            }
        }
        
        // Sheet for adding new walks
        .sheet(isPresented: $isPresentedWalk) {
            NavigationView {
                EditWalkView(walkData: $newWalkData)
                    .navigationBarItems(leading: Button("Dismiss") {
                        isPresentedWalk = false
                    }
                    .foregroundColor(Color(UIColor.purple)), trailing: Button("Add") {
                        
                        // Save the new walk data
                        let newWalk = Walks(time: newWalkData.time)
                        walks.append(newWalk)
                        isPresentedWalk = false
                        
                        // Create walk notfication
                        self.notificationManager.sendWalkNotification(id: newWalk.id, title: "Fido", body: "Time for a walk!", date: newWalk.time)
                    }
                    .foregroundColor(Color(UIColor.purple)))
            }
        }
        
        // Sheet for adding new medications
        .sheet(isPresented: $isPresentedMedication) {
            NavigationView {
                EditMedicationView(medicationData: $newMedicationData)
                    .navigationBarItems(leading: Button("Dismiss") {
                        isPresentedMedication = false
                    }
                    .foregroundColor(Color(UIColor.purple)), trailing: Button("Add") {
                        
                        // Save the new medication data
                        let newMedication = Medications(title: newMedicationData.title, time: newMedicationData.time, note: newMedicationData.note)
                        medications.append(newMedication)
                        isPresentedMedication = false
                        
                        // Create medication notification
                        self.notificationManager.sendMedicationNotification(id: newMedication.id, title: "Fido", subtitle: "Time for medicine!", body: newMedication.title, date: newMedication.time)
                    }
                    .foregroundColor(Color(UIColor.purple)))
            }
        }
        
        .listStyle(InsetGroupedListStyle())
        
        .onChange(of: scenePhase) { phase in
            // Call saveAction if the scene is moving to the inactive phase
            if phase == .inactive { saveAction() }
        }
    }
    
    // Used to turn meals into a binding to pass into a view
    private func binding(for meal: Meals) -> Binding<Meals> {
        guard let mealIndex = meals.firstIndex(where: { $0.id == meal.id }) else {
            fatalError("Can't find meal in array")
        }
        return $meals[mealIndex]
    }
    
    // Used to turn medications into a binding to pass into a view
    private func binding(for medication: Medications) -> Binding<Medications> {
        guard let medicationIndex = medications.firstIndex(where: { $0.id == medication.id }) else {
            fatalError("Can't find medication in array")
        }
        return $medications[medicationIndex]
    }
    
    // Used to turn walks into a binding to pass into a view
    private func binding(for walk: Walks) -> Binding<Walks> {
        guard let walkIndex = walks.firstIndex(where: { $0.id == walk.id }) else {
            fatalError("Can't find walk in array")
        }
        return $walks[walkIndex]
    }
    
    // Used to remove meal entities from the app's data and delete the associated notification
    private func removeMeals(at offsets: IndexSet) {
        
        // Remove notification associated with the Meal being deleted
        offsets.sorted(by: > ).forEach { (i) in
            let mealUnit = meals[i]
            self.notificationManager.deleteNotification(id: mealUnit.id)
        }
        
        // Delete the Meal
        meals.remove(atOffsets: offsets)
    }
    
    // Used to remove medication entities from the app's data and delete the associated notification
    private func removeMedications(at offsets: IndexSet) {
        
        // Remove notification associated with the Medication being deleted
        offsets.sorted(by: > ).forEach { (i) in
            let medUnit = medications[i]
            self.notificationManager.deleteNotification(id: medUnit.id)
        }
        
        // Delete the Medication
        medications.remove(atOffsets: offsets)
    }
    
    // Used to remove walk entities from the app's data and delete the associated notification
    private func removeWalks(at offsets: IndexSet) {
        
        // Remove notification associated with the Walk being deleted
        offsets.sorted(by: > ).forEach { (i) in
            let walkUnit = walks[i]
            self.notificationManager.deleteNotification(id: walkUnit.id)
        }
        
        // Delete the Walk
        walks.remove(atOffsets: offsets)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView(meals: .constant(Meals.data), medications: .constant(Medications.data), walks: .constant(Walks.data), saveAction: {})
        }
    }
}
