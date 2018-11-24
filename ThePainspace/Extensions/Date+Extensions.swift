//
//  Date+Extensions.swift
//  PainspaceMessages
//

import Foundation

extension Date {
    var messageFormatted: String {
        return DateFormatter.messageTime.string(from: self)
    }
}

extension DateFormatter {
    static let messageTime: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter
    }()
}

