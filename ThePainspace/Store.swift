//
//  Store.swift
//  ThePainspace
//
//  Created by James Ireland on 02/12/2018.
//  Copyright © 2018 The Painspace. All rights reserved.
//

import UIKit

final class Store {
    
    static var hasCompletedIntro: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "PSHasCompletedIntro")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "PSHasCompletedIntro")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var messagesScheduleStart: Date? {
        get {
            return UserDefaults.standard.object(forKey: "PSMessagesScheduleStart") as? Date
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "PSMessagesScheduleStart")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var messageDefs: [MessageDef] {
        get {
            let path = Bundle.main.path(forResource: "sample-messages", ofType: "json")!
            let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            let decoder = JSONDecoder()
            let messageDefs = try? decoder.decode([MessageDef].self, from: data)
            return messageDefs != nil ? messageDefs! : []
        }
    }
    
}
