//
//  PSUserDefaults.h
//  ThePainspace
//
//  Created by James Ireland on 25/11/2018.
//  Copyright © 2018 The Painspace. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PSMainViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSUserDefaults : NSObject

+ (PSMainSequence)initialSequence;

+ (void)setInitialSequence:(PSMainSequence)initialSequence;

+ (NSDate *)messagesScheduleEpoch;

+ (void)setMessagesScheduleEpoch:(NSDate *)epoch;


@end

NS_ASSUME_NONNULL_END
