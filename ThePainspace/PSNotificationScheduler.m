//
//  PSNotificationScheduler.m
//  ThePainspace
//
//  Created by Jin Cong & Nick Taras on 24/11/2018.
//  Copyright © 2018 The Painspace. All rights reserved.
//

#import "PSNotificationScheduler.h"
#import <ThePainspace-Swift.h>

@interface PSNotificationScheduler()


@property (nonatomic) NSTimer *timer;

@end

@implementation PSNotificationScheduler

+(void)addNotificationRequestsForMessages:(NSArray *) messages
{
    
    NSLog(@"PSNotificationScheduler invoked");
    
    // clear previously scheduled messages
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center removeAllDeliveredNotifications];
    [center removeAllPendingNotificationRequests];
    
    // parse each message and add to schedule
    [NSMutableArray arrayWithCapacity:[messages count]];
    
    // dispatch notification for each message recieved
    for(Message * message in messages) {
        [self dispatchScheduledNotification:message];
    }
    
}

 +(void)dispatchScheduledNotification:(Message *)message {
     
     NSLog(@"%@", message.text);
     
     // *center stores a local reference to the UNUserNotificationCenter
     UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
     
     // assign alert types to options
     UNAuthorizationOptions options = UNAuthorizationOptionAlert + UNAuthorizationOptionSound + UNAuthorizationOptionBadge;
     
     // assign options to notification
     [center requestAuthorizationWithOptions:options
       completionHandler:^(BOOL granted, NSError * _Nullable error) {
           if (!granted) {
               NSLog(@"Something went wrong");
           }
       }];
     
     
     // Notifcation content - set title and body.
     UNMutableNotificationContent *content = [UNMutableNotificationContent new];
     content.title = @"The Painspace";
     content.body = message.text;
     content.sound = [UNNotificationSound defaultSound];
     
     // Set interval timer
     //UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
     
     // Convert timestamp value to day object and call trigger
     NSDateComponents *triggerDate = [[NSCalendar currentCalendar]
                                      components:NSCalendarUnitYear +
                                      NSCalendarUnitMonth + NSCalendarUnitDay +
                                      NSCalendarUnitHour + NSCalendarUnitMinute +
                                      NSCalendarUnitSecond fromDate:message.timestamp];
     
     UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:triggerDate repeats:NO];
     
     // Create notification request with content applied
     NSString *identifier = @"UYLLocalNotification";
     UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:trigger];
     
     // Add notifcation to IOS notification scheduler, with fall back error handler.
     [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
         if (error != nil) {
             NSLog(@"Something went wrong: %@",error);
         }
     }];
    
}

@end

