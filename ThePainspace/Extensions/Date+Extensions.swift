//
//  Date+Extensions.swift
//  PainspaceMessages
//

import Foundation

extension Date {
    // TODO: Use the current date send back a relative time, e.g. Now or 4 days ago
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

