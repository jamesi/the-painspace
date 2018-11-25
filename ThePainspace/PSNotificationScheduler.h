//
//  PSNotificationScheduler.h
//  ThePainspace
//
//  Created by Jin Cong & Nick Taras on 24/11/2018.
//  Copyright © 2018 The Painspace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@import UserNotifications;

NS_ASSUME_NONNULL_BEGIN

@interface PSNotificationScheduler : NSObject

+(void)addNotificationRequestsForMessages:(NSArray *) messages;

@end

NS_ASSUME_NONNULL_END

