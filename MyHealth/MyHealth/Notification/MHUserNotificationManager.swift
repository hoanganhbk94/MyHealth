//
//  MHUserNotificationManager.swift
//  MyHealth
//
//  Created by Mai Hoang Anh on 5/4/18.
//  Copyright © 2018 Mai Hoang Anh. All rights reserved.
//

import Foundation
import UserNotifications

class MHUserNotificationManager {
    static let sharedInstance = MHUserNotificationManager()
    
    func requestAuthorization() {
        let center = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        center.requestAuthorization(options: options) { (granted, error) in
            if !granted {
                print("Something went wrong")
            }
        }
    }
    
    func makeCalendarNotification(title: String, message: String, dateComponents: DateComponents) {
        let center =  UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = title
        //content.subtitle = "Subtitle"
        content.body = message
        content.sound = UNNotificationSound.default()
        
        /// Notification trigger can be based on time, calendar or location
        //var dateComponents = DateComponents()
        //dateComponents.hour = 11
        //dateComponents.minute = 55
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        /// Create request to display
        let request = UNNotificationRequest(identifier: "ContentIdentifier", content: content, trigger: trigger)
        
        /// Add request to notification center
        center.add(request) { (error) in
            if error != nil {
                print("error \(String(describing: error))")
            }
        }
    }
    
    func removeNotification(identifier: String) {
        let center =  UNUserNotificationCenter.current()
        center.removeDeliveredNotifications(withIdentifiers: [identifier])
        center.removePendingNotificationRequests(withIdentifiers: [identifier])
    }
    
}
