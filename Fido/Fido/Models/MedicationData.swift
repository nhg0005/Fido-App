//
//  MedicationData.swift
//  Fido
//
//  Created by Naeem Ghossein
//

import Foundation

class MedicationData: ObservableObject {
    
    // Saving medication to a file in the Documents folder
    // Find the user's internal documents folder
    private static var documentsFolder: URL {
        do {
            return try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        } catch {
            fatalError("Can't find documents directory")
        }
    }
    
    // Read-only type property that returns the URL of a file named 'medications'
    private static var fileURL: URL {
        return documentsFolder.appendingPathComponent("medications.data")
    }
    
    // Published wrapper used to create observable objects that react to changes in the app's data
    @Published var medications: [Medications] = []
    
    // Load data
    func load() {
        // Dispatch queues to choose which tasks run on the main thread or in the background
        // Weak reference used to avoid a retain cycle
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let data = try? Data(contentsOf: Self.fileURL) else {
                #if DEBUG
                DispatchQueue.main.async {
                    self?.medications = Medications.data
                }
                #endif
                return
            }
            // Decode the medication data
            guard let medicationData = try? JSONDecoder().decode([Medications].self , from: data) else {
                fatalError("Can't decode saved meal data.")
            }
            // Load the data on the main queue
            DispatchQueue.main.async {
                self?.medications = medicationData
            }
        }
    }
    
    // Save data
    func save() {
        // Check if self is in scope
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let medications = self?.medications else { fatalError("Self out of scope") }
            // Encode the medication data
            guard let data = try? JSONEncoder().encode(medications) else { fatalError("Error encoding data") }
            do {
                let outfile = Self.fileURL
                try data.write(to: outfile)
            } catch {
                fatalError("Can't write to file")
            }
        }
    }
    
}
