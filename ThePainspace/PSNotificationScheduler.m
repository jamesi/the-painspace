//
//  PSNotificationScheduler.m
//  ThePainspace
//
//  Created by Jin Cong & Nick Taras on 24/11/2018.
//  Copyright © 2018 The Painspace. All rights reserved.
//

#import "PSNotificationScheduler.h"

#import <ThePainspace-Swift.h>
#import <UserNotifications/UserNotifications.h>

@implementation PSNotificationScheduler

+ (void)requestAuthorization
{
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    UNAuthorizationOptions options = UNAuthorizationOptionAlert + UNAuthorizationOptionSound + UNAuthorizationOptionBadge;
    [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (!granted) {
            NSLog(@"User notifications permission declined");
        }
    }];
}

+ (void)addNotificationRequestsForMessages:(NSArray *) messages
{
    
    NSLog(@"PSNotificationScheduler invoked");
    
    // clear previously scheduled messages
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center removeAllDeliveredNotifications];
    [center removeAllPendingNotificationRequests];
    
    // parse each message and add to schedule
    [NSMutableArray arrayWithCapacity:[messages count]];
    
    // dispatch notification for each message recieved
    int i = 0;
    for(Message * message in messages) {
        NSString *identifier = [NSString stringWithFormat:@"%d", i++];
        [self dispatchScheduledNotification:message withIdentifier:identifier];
    }
    
}

+(void)dispatchScheduledNotification:(Message *)message withIdentifier:(NSString *)identifier {
     
     //NSLog(@"%@", message.text);
     //NSLog(@"%@", message.timestamp);
     
     UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
     
     
     // Notifcation content - set title and body.
     UNMutableNotificationContent *content = [UNMutableNotificationContent new];
     content.title = @"The Painspace";
     content.body = message.text;
     content.sound = [UNNotificationSound defaultSound];
     
     
     // Set interval timer
     //UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
     
     // Convert timestamp value to day object and call trigger
     NSDateComponents *triggerDate = [[NSCalendar currentCalendar]
                                      components:(NSCalendarUnitTimeZone | NSCalendarUnitYear |
                                      NSCalendarUnitMonth | NSCalendarUnitDay |
                                      NSCalendarUnitHour | NSCalendarUnitMinute |
                                      NSCalendarUnitSecond) fromDate:message.timestamp];
     
     NSLog(@"%@", triggerDate);
     
     UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:triggerDate repeats:YES];
     
     // Create notification request with content applied + identifier
     UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:trigger];
     
     // Add notifcation to IOS notification scheduler, with fall back error handler.
     [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
         if (error != nil) {
             NSLog(@"Something went wrong: addNotificationRequest failed? %@",error);
         }
     }];
    
}

@end

