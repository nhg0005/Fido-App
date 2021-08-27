//
//  LocalNotificationManager.swift
//  LocalNotificationManager
//
//  Created by Naeem Ghossein
//

import Foundation
import SwiftUI
import UserNotifications

class LocalNotificationManager: ObservableObject {
    
    // Array of notification objects
    var notifications = [Notification]()
    
    // Ask the user for permission if needed upon initialization
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) {
            granted, error in
            if granted == true && error == nil {
                print("Notifications active")
            } else {
                print("Notifications inactive")
            }
        }
    }
    
    // Function for creating a Meal notification
    func sendMealNotification(id: UUID, title: String, subtitle: String?, body: String?, date: Date) {
       
        // Content of the notification
        let content = UNMutableNotificationContent()
        content.title = title
        if let subtitle = subtitle {
            content.subtitle = subtitle
        }
        if let body = body {
            content.body = body
        }
        
        // Turn the date into components to pass into the trigger
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        
        // Set the trigger and request
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: id.uuidString, content: content, trigger: trigger)
        
        // Add the request to the user notification center
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    // Function for creating a Walk notification
    func sendWalkNotification(id: UUID, title: String,  body: String?, date: Date) {
       
        // Content of the notification
        let content = UNMutableNotificationContent()
        content.title = title
        if let body = body {
            content.body = body
        }
        
        // Turn the date into components to pass into the trigger
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        
        // Set the trigger and request
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: id.uuidString, content: content, trigger: trigger)
        
        // Add the request to the user notification center
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    // Function for creating a Medication notification
    func sendMedicationNotification(id: UUID, title: String, subtitle: String?, body: String?, date: Date) {
       
        // Content of the notification
        let content = UNMutableNotificationContent()
        content.title = title
        if let subtitle = subtitle {
            content.subtitle = subtitle
        }
        if let body = body {
            content.body = body
        }
        
        // Turn the date into components to pass into the trigger
        let components = Calendar.current.dateComponents([.timeZone, .year, .month, .day, .hour, .minute, .second], from: date)
        
        // Set the trigger and request
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: id.uuidString, content: content, trigger: trigger)
        
        // Add the request to the user notification center
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    // Function for deleting a notification matching an entity's UUID
    func deleteNotification(id: UUID) {
        let idString = id.uuidString
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [idString])
    }
    
}
