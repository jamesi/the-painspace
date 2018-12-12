//
//  Coordinator.swift
//  ThePainspace
//
//  Created by James Ireland on 02/12/2018.
//  Copyright © 2018 The Painspace. All rights reserved.
//

import UIKit
import UserNotifications

@objc final class Coordinator: NSObject {

    @objc enum Screen : Int {
        case intro0 = 0
        case intro1
        case intro2
        case intro3
        case intro4
        case intro5
        case intro6
        case intro7
        case welcome
        case messages
    }
    
    private let rootViewController: PSTransitioningViewController
    
    private let messagesSchedule = MessagesSchedule(messageDefs: Store.messageDefs, start: Store.messagesScheduleStart)

    private lazy var messagesHistory: MessagesHistory = MessagesHistory(messagesSchedule: self.messagesSchedule, referenceDate: Date())
    
    private var screen: Screen = .intro0 {
        didSet {
            if (screen.rawValue > Screen.intro7.rawValue) {
                Store.hasCompletedIntro = true
            }
            self.rootViewController.setViewController(self.viewControllerFor(screen: self.screen), animated: true)
        }
    }

    private var observers: [NSObjectProtocol] = []
    
    private weak var messagesViewController: MessagesViewController?
    
    @objc init(_ rootViewController: PSTransitioningViewController) {
        self.rootViewController = rootViewController
        super.init()
        self.screen = initialScreen()
        self.rootViewController.setViewController(self.viewControllerFor(screen: self.screen), animated: false)

        UNUserNotificationCenter.current().delegate = self
        UserNotificationService.addNotificationRequests(for: messagesSchedule.futureMessagesAfter(date: Date()))

        observers.append(NotificationCenter.default.addObserver(forName: MessagesSchedule.changedNotification, object: nil, queue: OperationQueue.main) { [weak self] (notification) in
            self?.handleMessagesScheduleChanged()
        })
    }
    
    deinit {
        for observer in self.observers {
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    func initialScreen() -> Screen {
        if (Store.messagesScheduleStart != nil) {
            return .messages
        } else if (Store.hasCompletedIntro) {
            return .welcome
        } else {
            return .intro0
        }
    }
    
    func viewControllerFor(screen: Screen) -> UIViewController {
        switch screen {
        case .intro0, .intro1, .intro2, .intro3, .intro4, .intro5,. intro6, .intro7:
            let textKey = String(format: "SLIDE%ld", screen.rawValue)
            let text = NSLocalizedString(textKey, comment: "")
            let imageName = String(format: "cloud%ld", screen.rawValue + 1);
            let viewController = IntroViewController(text: text, imageName: imageName, textColor: PSStyle.lightTextColor())
            viewController.delegate = self
            return viewController
        case .welcome:
            let viewController = WelcomeViewController()
            viewController.delegate = self
            return viewController
        case .messages:
            let viewController = MessagesViewController(messagesHistory: self.messagesHistory)
            let navigationController = UINavigationController(rootViewController: viewController)
            viewController.delegate = self
            self.messagesViewController = viewController
            return navigationController
        }
    }
    
    func continueMainSequence() {
        if (self.screen.rawValue < Screen.messages.rawValue) {
            self.screen = Screen(rawValue: self.screen.rawValue + 1)!
        }
    }
    
    func handleMessagesScheduleChanged() {
        let futureMessages = messagesSchedule.futureMessagesAfter(date: Date())
        UserNotificationService.addNotificationRequests(for: futureMessages)
    }
}

extension Coordinator: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(UNNotificationPresentationOptions.sound)
        
        self.messagesHistory.referenceDate = Date()
    }
    
}

extension Coordinator: IntroViewControllerDelegate {
    
    func introViewControllerDidFinish() {
        continueMainSequence()
    }
    
}

extension Coordinator: WelcomeViewControllerDelegate {
    
    func welcomeViewControllerDidSelectContinue() {
        Store.messagesScheduleStart = Date()
        // todo: should messageScheduler start date be updated via notification from store?
        self.messagesSchedule.start = Store.messagesScheduleStart
        UserNotificationService.requestAuthorization()
        continueMainSequence()
    }
    
    func welcomeViewControllerDidSelectTerms() {
        
    }
    
}

extension Coordinator: MessagesViewControllerDelegate {
    
    func messagesViewControllerDidSelectInfo() {
        
    }
    
}
