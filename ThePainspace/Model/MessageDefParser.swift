//
//  MessageDefParser.swift
//  ThePainspace
//

import Foundation

@objc class MessageDefParser: NSObject {
    @objc func getSampleMessages() -> [MessageDef] {
        let path = Bundle.main.path(forResource: "sample-messages", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
        let decoder = JSONDecoder()
        return try! decoder.decode([MessageDef].self, from: data)
    }
}
