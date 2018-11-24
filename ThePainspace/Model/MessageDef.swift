//
//  MessageDef.swift
//  ThePainspace
//

import Foundation

@objcMembers class MessageDef: NSObject, Codable {
    let id: Int
    let day: Int
    let hours: Int
    let content: String
    
    init(id: Int, day: Int, hours: Int, content: String) {
        self.id = id
        self.day = day
        self.hours = hours
        self.content = content
    }
}
