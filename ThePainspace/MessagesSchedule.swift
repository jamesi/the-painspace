//
//  MessagesSchedule.swift
//  ThePainspace
//
//  Created by James Ireland on 03/12/2018.
//  Copyright © 2018 The Painspace. All rights reserved.
//

import Foundation

final class MessagesSchedule {

    static let changedNotification = Notification.Name("MessagesScheduleChanged")

    static let calendarUnits = Set<Calendar.Component>([.calendar, .timeZone, .year, .month, .day, .hour, .minute, .second])

    var messageDefs = [MessageDef]() {
        didSet {
            self.messages = instantiateMessages(messageDefs: messageDefs, start: self.start)
        }
    }

    var start: Date? = nil {
        didSet {
            self.messages = instantiateMessages(messageDefs: self.messageDefs, start: start)
        }
    }
    
    private var messages: [Message] {
        didSet {
            NotificationCenter.default.post(name: MessagesSchedule.changedNotification, object: nil, userInfo: nil)
        }
    }
    
    init(messageDefs: [MessageDef], start: Date?) {
        self.messageDefs = messageDefs
        self.start = start
        self.messages = instantiateMessages(messageDefs: messageDefs, start: start)
    }
    
    func pastMessagesUntil(date: Date) -> [Message]
    {
        // todo: derive the split index directly when date algorithm is known
        let slice = self.messages.prefix(while: { (m:Message) -> Bool in
            return m.timestamp <= date
        })
        return Array(slice)
    }
    
    func futureMessagesAfter(date: Date) -> [Message]
    {
        // todo: derive the split index directly when date algorithm is known
        let slice = self.messages.prefix(while: { (m:Message) -> Bool in
            return m.timestamp > date
        })
        return Array(slice)
    }

}

private func instantiateMessages(messageDefs: [MessageDef], start: Date?) -> [Message]
{
    var messages = [Message]()
    if (start != nil) {
        for (index, messageDef) in messageDefs.enumerated() {
            // todo: store identifier in message
            let date = dateForMessage(index: index, fromStart: start!)
            let message = Message(text: messageDef.content, timestamp: date)
            messages.append(message)
        }
    }
    return messages
}

private func dateForMessage(index: Int, fromStart: Date) -> Date
{
    // todo: replace with real date calculation algorithm
    // demo sequence messages at 20 second intervals after start date
    var components = Calendar.current.dateComponents(MessagesSchedule.calendarUnits, from: fromStart)
    components.second = components.second! + (index + 1) * 20
    return components.date!
}
