//
//  EditMedicationView.swift
//  Fido
//
//  Created by Naeem Ghossein
//

import SwiftUI

struct EditMedicationView: View {
    
    // Binding for passing medication data between views
    @Binding var medicationData: Medications.Data
    
    var body: some View {
        List {
            Section(header: Text("Medication")
                        .font(.subheadline)) {
                TextField("Medication", text: $medicationData.title)
            }
            Section(header: Text("Date")
                        .font(.subheadline)) {
                DatePicker("Date", selection: $medicationData.time)
            }
            Section(header: Text("Note")
                        .font(.subheadline)) {
                TextEditor(text: $medicationData.note)
            }
        }
        .navigationTitle(medicationData.title)
        .listStyle(InsetGroupedListStyle())
    }
}

struct EditMedicationView_Previews: PreviewProvider {
    static var previews: some View {
        EditMedicationView(medicationData: .constant(Medications.data[0].data))
    }
}
