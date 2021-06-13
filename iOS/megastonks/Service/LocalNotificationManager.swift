//
//  LocalNotificationManager.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-06-07.
//

import Foundation
import UserNotifications

class LocalNotificationManager: ObservableObject{
    var notifications = [Notification]()
    
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if success {
                    print("All set!")
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
        registerScheduledNotification()
        
    }
    
    func registerScheduledNotification(){
        let content = UNMutableNotificationContent()
        content.title = "Weekly Portfolio Performance"
        content.body = "The stock market is officially closed for the week! Login to check your portfolio performance 💸"
        
        // Configure the recurring date.
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        dateComponents.timeZone = TimeZone.init(abbreviation: "EST")

        dateComponents.weekday = 6  // Friday 6
        dateComponents.hour = 16    // 16:00 hours 16
        dateComponents.minute = 0    // 00:00 minute 0
           
        // Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                    content: content, trigger: trigger)
 
        
        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        
        // Remove all delivered notification request
        notificationCenter.removeAllDeliveredNotifications()
        
        //Remove all pending notifications
        notificationCenter.removeAllPendingNotificationRequests()
        
        notificationCenter.add(request) { (error) in
           if error != nil {
            print("Could not Send Notification")
              // Handle any errors.
           }
        }
        
      
        
    }
}
