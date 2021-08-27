//
//  Medications.swift
//  Fido
//
//  Created by Naeem Ghossein
//

import SwiftUI

// Medication structure construct
struct Medications: Identifiable, Codable {
    
    // Medication properties
    let id: UUID
    var title: String
    var time: Date
    var note: String
    
    // Medication initializer
    init(id: UUID = UUID(), title: String, time: Date, note: String) {
        self.id = id
        self.title = title
        self.time = time
        self.note = note
    }
}

// Example medication data used for defaults and testing
extension Medications {
    static var data: [Medications] {
        [
            Medications(title: "Flea medicine", time: Date(), note: "Sentinel")
        ]
    }
}

// Extension to help with writing and updating data
extension Medications {
    struct Data {
        var title: String = ""
        var time: Date = Date()
        var note: String = ""
    }
    
    var data: Data {
        return Data(title: title, time: time, note: note)
    }
    
    // Update function
    mutating func update(from data: Data) {
        title = data.title
        time = data.time
        note = data.note
    }
}
