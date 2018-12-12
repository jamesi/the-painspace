//
//  MessagesHistory.swift
//  ThePainspace
//
//  Created by James Ireland on 12/12/2018.
//  Copyright © 2018 The Painspace. All rights reserved.
//

import Foundation

class MessagesHistory {
    
    let changedNotification = Notification.Name("MessagesHistoryChanged")
    
    let messagesSchedule: MessagesSchedule
    
    var referenceDate: Date {
        didSet {
            updateMessages()
        }
    }
    
    var messages: [Message] = [] {
        didSet {
            NotificationCenter.default.post(name: changedNotification, object: self)
        }
    }
    
    var observers: [NSObjectProtocol] = []

    var referenceTimer: Timer? {
        willSet {
            referenceTimer?.invalidate()
        }
    }

    init(messagesSchedule: MessagesSchedule, referenceDate: Date) {
        self.messagesSchedule = messagesSchedule
        self.referenceDate = referenceDate
        updateMessages()

        observers.append(NotificationCenter.default.addObserver(forName: MessagesSchedule.changedNotification, object: nil, queue: OperationQueue.main) { [weak self] (notification) in
            self?.handleMessagesScheduleChanged()
        })
    }
    
    deinit {
        referenceTimer?.invalidate()
        for observer in self.observers {
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    func updateMessages() {
        self.messages = messagesSchedule.pastMessagesUntil(date: self.referenceDate)
        updateReferenceTimer()
    }
    
    func updateReferenceTimer() {
//        self.referenceTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true, block: { (timer) in
//            self.referenceDate = Date()
//            print("Timer fired \(self.referenceDate)")
//        })
    }
    
    func handleMessagesScheduleChanged() {
        updateMessages()
    }
    
}
