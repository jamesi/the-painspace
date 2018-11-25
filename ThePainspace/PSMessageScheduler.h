//
//  PSMessageScheduler.h
//  ThePainspace
//
//  Created by James Ireland on 24/11/2018.
//  Copyright © 2018 The Painspace. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <ThePainspace-Swift.h>

@interface PSMessageScheduler : NSObject



- (instancetype)initWithMessageDefs:(NSArray<MessageDef *> *)messageDefs scheduleEpoch:(NSDate *)sheduleEpoch;

- (NSArray<Message *> *)historicalMessagesRelativeToTimepoint:(NSDate *)timepoint;

- (NSArray<Message *> *)futureMessagesRelativeToTimepoint:(NSDate *)timepoint;

@end
