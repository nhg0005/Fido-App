//
//  MedicationDetailView.swift
//  Fido
//
//  Created by Naeem Ghossein
//

import SwiftUI

struct MedicationDetailView: View {
    
    // Binding for passing medication data between views
    @Binding var medication: Medications
    
    // State properties for reading and writing medication values
    @State private var noteText: String = "Example medication note"
    @State private var medicationData: Medications.Data = Medications.Data()
    @State private var isPresented = false
    
    var body: some View {
        List {
            
            // Medication title section
            Section(header: Text("Medication")
                        .font(.subheadline)) {
                Text(medication.title)
            }
            
            // Medication date and time section
            Section(header: Text("Date")
                        .font(.subheadline)) {
                HStack {
                Text(medication.time, style: .date)
                Spacer()
                Text(medication.time, style: .time)
                }
            }
            
            // Medication note section
            Section(header: Text("Note")
                        .font(.subheadline)) {
                Text(medication.note)
            }
        }
        .navigationTitle(medication.title)
        .listStyle(InsetGroupedListStyle())
        
        // Edit button used to bring up an EditView
        .navigationBarItems(trailing: Button("Edit") {
            isPresented = true
            medicationData = medication.data
        }.foregroundColor(Color(UIColor.purple)))
        
        // EditView used to edit the selected medication's data
        .fullScreenCover(isPresented: $isPresented) {
            NavigationView {
                 EditMedicationView(medicationData: $medicationData)
                    .navigationTitle(medication.title)
                    .navigationBarItems(leading: Button("Cancel") {
                        isPresented = false
                    }.foregroundColor(Color(UIColor.purple)), trailing: Button("Done") {
                        isPresented = false
                        medication.update(from: medicationData)
                        
                    }.foregroundColor(Color(UIColor.purple)))
            }
        }
    }
}

struct MedicationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MedicationDetailView(medication: .constant(Medications.data[0]))
        }
    }
}
