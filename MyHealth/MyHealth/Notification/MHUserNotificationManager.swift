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
    
    func makeNotification() {
        let center =  UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Brother Of King"
        //content.subtitle = "Lunch"
        content.body = "Its lunch time at EGS, have a funny lunch time"
        content.sound = UNNotificationSound.default()
        
        //notification trigger can be based on time, calendar or location
        var dateComponents = DateComponents()
        dateComponents.hour = 11
        dateComponents.minute = 55
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        //create request to display
        let request = UNNotificationRequest(identifier: "ContentIdentifier", content: content, trigger: trigger)
        
        //add request to notification center
        center.add(request) { (error) in
            if error != nil {
                print("error \(String(describing: error))")
            }
        }
    }
    
}
