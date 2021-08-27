//
//  Meals.swift
//  Fido
//
//  Created by Naeem Ghossein
//

import SwiftUI

// Meal structure construct
struct Meals: Identifiable, Codable {
    
    // Meal properties
    let id: UUID
    var title: String
    var time: Date
    var note: String
    
    // Meal initializer
    init(id: UUID = UUID(), title: String, time: Date, note: String) {
        self.id = id
        self.title = title
        self.time = time
        self.note = note
    }
}

// Example meal data used for defaults and testing
extension Meals {
    static var data: [Meals] {
        [
            Meals(title: "Breakfast", time: Date(), note: "Note 1"),
            Meals(title: "Lunch", time: Date(), note: "Note 2"),
            Meals(title: "Dinner", time: Date(), note: "Note 3")
        ]
    }
}

// Extension to help with writing and updating data
extension Meals {
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
