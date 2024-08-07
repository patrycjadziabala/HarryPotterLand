//
//  NotificationManager.swift
//  HarryPotterLand
//
//  Created by Patka on 05/04/2024.
//

import SwiftUI
import UserNotifications

protocol NotificationManagerProtocol {
    func requestAuthorisation()
    func scheduleNotification()
    func removeNotifications()
}

class NotificationManager: NotificationManagerProtocol {
    
    func requestAuthorisation() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
            } else {
                print("Notifications authorisation SUCCESS")
            }
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "It has been so long 🥺"
        content.subtitle = "Your favourite Harry Potter characters miss you. Visit them in the app to make them feel better 🤩"
        content.sound = .default
        content.badge = 1
        
        var dateComponents = DateComponents()
        dateComponents.hour = 19
        dateComponents.minute = 0
        dateComponents.weekday = 7
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func removeNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}

// sample implementation
/*
 struct NotifictaionManager: View {
 
 var body: some View {
 VStack {
 Button {
 NotificationManager.instance.requestAuthorisation()
 } label: {
 Text("Request permission")
 }
 
 Button {
 NotificationManager.instance.scheduleNotification()
 } label: {
 Text("Schedule notification")
 }
 }
 .onAppear {
 UNUserNotificationCenter.current().setBadgeCount(0)
 }
 }
 }
 */



