//
//  EditWalkView.swift
//  Fido
//
//  Created by Naeem Ghossein on 8/24/21.
//

import SwiftUI

struct EditWalkView: View {
    
    // Binding for passing walk data between views
    @Binding var walkData: Walks.Data
    
    var body: some View {
        List {
            Section(header: Text("Time")
                        .font(.subheadline)) {
                DatePicker("Time", selection: $walkData.time, displayedComponents: .hourAndMinute)
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}

struct EditWalkView_Previews: PreviewProvider {
    static var previews: some View {
        EditWalkView(walkData: .constant(Walks.data[0].data))
    }
}
