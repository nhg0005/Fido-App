//
//  WalkDetailView.swift
//  Fido
//
//  Created by Naeem Ghossein on 8/24/21.
//

import SwiftUI

struct WalkDetailView: View {
    
    // Binding for passing walk data between views
    @Binding var walk: Walks
    
    // State properties for reading and writing walk values
    @State private var isPresented = false
    @State private var walkData: Walks.Data = Walks.Data()
    
    var body: some View {
        List {
            
            // Walk time section
            Section(header: Text("Time")
                        .font(.subheadline)) {
                Text(walk.time, style: .time)
            }
        }
        .listStyle(InsetGroupedListStyle())
        
        // Edit button used to bring up an EditView
        .navigationBarItems(trailing: Button("Edit") {
            isPresented = true
            walkData = walk.data
        }.foregroundColor(Color(UIColor.purple)))
        
        // EditView used to edit the selected walk's data
        .fullScreenCover(isPresented: $isPresented) {
            NavigationView {
                EditWalkView(walkData: $walkData)
                    .navigationBarItems(leading: Button("Cancel") {
                        isPresented = false
                    }.foregroundColor(Color(UIColor.purple)), trailing: Button("Done") {
                        isPresented = false
                        walk.update(from: walkData)
                        
                    }.foregroundColor(Color(UIColor.purple)))
            }
        }
    }
}

struct WalkDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WalkDetailView(walk: .constant(Walks.data[0]))
    }
}
