//
//  UserNotificationService.swift
//  ThePainspace
//
//  Created by James Ireland on 04/12/2018.
//  Copyright © 2018 The Painspace. All rights reserved.
//

import UIKit
import UserNotifications

final class UserNotificationService {

    static func requestAuthorization() {
        let options : UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (granted, error) in
            if (!granted) {
                NSLog("User notifications not authorized")
            }
        }
    }
    
    static func addNotificationRequests(for messages:[Message]) {
        let center = UNUserNotificationCenter.current()
        center.removeAllDeliveredNotifications()
        center.removeAllPendingNotificationRequests()
        for (index, message) in messages.enumerated() {
            if (index > 63) {
                // System limit of 64 user notifications
                break;
            }
            center.add(self.notificationRequest(for: message)) { (error) in
                if (error != nil) {
                    NSLog("Failed to add user notification")
                }
            }
        }
    }
    
    static func notificationRequest(for message:Message) -> UNNotificationRequest {
        let content = UNMutableNotificationContent()
        content.title = NSLocalizedString("USER_NOTIFICATION_TITLE", comment: "")
        content.body = message.text
        content.sound = UNNotificationSound.default
        
        let dateComponents = Calendar.current.dateComponents(MessagesSchedule.calendarUnits, from: message.timestamp)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let identifier = UUID().uuidString
        return UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
    }
    
}
