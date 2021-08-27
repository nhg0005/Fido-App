//
//  Walks.swift
//  Fido
//
//  Created by Naeem Ghossein on 8/24/21.
//

import SwiftUI

// Walk structure construct
struct Walks: Identifiable, Codable {
    
    // Walk properties
    let id: UUID
    var time: Date
    
    // Walk initializer
    init(id: UUID = UUID(), time: Date) {
        self.id = id
        self.time = time
    }
}

// Example walk data used for defaults and testing
extension Walks {
    static var data: [Walks] {
        [
            Walks(time: Date()),
            Walks(time: Date())
        ]
    }
}

// Extension to help with writing and updating data
extension Walks {
    struct Data {
        var time: Date = Date()
    }
    
    var data: Data {
        return Data(time: time)
    }
    
    // Update function
    mutating func update(from data: Data) {
        time = data.time
    }
}
