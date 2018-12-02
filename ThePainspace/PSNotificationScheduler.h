//
//  PSNotificationScheduler.h
//  ThePainspace
//
//  Created by Jin Cong & Nick Taras on 24/11/2018.
//  Copyright © 2018 The Painspace. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PSNotificationScheduler : NSObject

+ (void)requestAuthorization;

+ (void)addNotificationRequestsForMessages:(NSArray *) messages;

@end

NS_ASSUME_NONNULL_END

