//
//  Message.swift
//  PainspaceMessages
//

import Foundation

@objc class Message: NSObject {
    let text: String
    let timestamp: Date
    
    @objc init(text: String, timestamp: Date) {
        self.text = text
        self.timestamp = timestamp
    }
}
