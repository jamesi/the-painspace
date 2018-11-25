//
//  PSMessageScheduler.m
//  ThePainspace
//
//  Created by James Ireland on 24/11/2018.
//  Copyright © 2018 The Painspace. All rights reserved.
//

#import "PSMessageScheduler.h"

@interface PSMessageScheduler ()

@property (nonatomic) NSArray<Message *> *messagesSchedule;

@end

@implementation PSMessageScheduler

- (instancetype)initWithMessageDefs:(NSArray *)messageDefs scheduleEpoch:(NSDate *)scheduleEpoch
{
    self = [super init];
    if (self) {
        _messagesSchedule = [self messagesScheduleFromMessageDefs:messageDefs scheduleEpoch:scheduleEpoch];
    }
    return self;
}

- (NSArray<Message *> *)historicalMessagesRelativeToTimepoint:(NSDate *)timepoint
{
    NSRange range = [self rangeOfMessages:self.messagesSchedule beforeTimestamp:timepoint];
    return [self.messagesSchedule subarrayWithRange:range];
}

- (NSArray<Message *> *)futureMessagesRelativeToTimepoint:(NSDate *)timepoint
{
    NSRange range = [self rangeOfMessages:self.messagesSchedule atOrAfterTimestamp:timepoint];
    return [self.messagesSchedule subarrayWithRange:range];
}

- (NSArray<Message *> *)messagesScheduleFromMessageDefs:(NSArray *)messageDefs scheduleEpoch:(NSDate *)scheduleEpoch
{
    NSMutableArray<Message *> *messages = [NSMutableArray new];
    int i = 0;
    for (MessageDef *messageDef in messageDefs) {
        NSDate *date = [self demoDateForMessageSequence:i relativeToScheduleEpoch:scheduleEpoch];
        Message *message = [[Message alloc] initWithText:messageDef.content timestamp:date];
        [messages addObject:message];
        i++;
    }
    return messages;
}

- (NSDate *)demoDateForMessageSequence:(NSInteger)sequence relativeToScheduleEpoch:(NSDate *)scheduleEpoch
{
    // derive 00:00 hours on day of epoch
    NSCalendarUnit units = (NSCalendarUnitCalendar | NSCalendarUnitTimeZone | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond);
    NSDateComponents *components = [[NSCalendar currentCalendar] components:units fromDate:scheduleEpoch];

    components.second = components.second + 20.0 + (sequence * 60.0);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    dateFormatter.timeStyle = NSDateFormatterFullStyle;
    
    NSDate *date = [components date];
    
    NSLog(@"** Scheduling for %@", [dateFormatter stringFromDate:date]);
    
    return date;
}

- (NSDate *)dateForDayIndex:(NSInteger)dayIndex hours:(NSInteger)hours relativeToScheduleEpoch:(NSDate *)scheduleEpoch
{
    // derive 00:00 hours on day of epoch
    NSCalendarUnit units = (NSCalendarUnitCalendar | NSCalendarUnitTimeZone | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay);
    NSDateComponents *components = [[NSCalendar currentCalendar] components:units fromDate:scheduleEpoch];

    // add days and hours
    components.day += dayIndex;
    components.hour = hours;

    // prevent the date being earlier than the schedule epoch
    NSDate *date = [components date];
    BOOL isBeforeEpoch = date && ([date compare:scheduleEpoch] == NSOrderedAscending);
    if (isBeforeEpoch) date = scheduleEpoch;
    
    return date;
}

- (NSDate *)demoDateForDayIndex:(NSInteger)dayIndex hours:(NSInteger)hours relativeToScheduleEpoch:(NSDate *)scheduleEpoch
{
    NSCalendarUnit units = (NSCalendarUnitCalendar | NSCalendarUnitTimeZone | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond);
    NSDateComponents *components = [[NSCalendar currentCalendar] components:units fromDate:scheduleEpoch];

    // add 20 seconds for each day
    components.second = components.second + 10.0 + dayIndex * 20.0;
    
    // prevent the date being earlier than the schedule epoch
    NSDate *date = [components date];
    BOOL isBeforeEpoch = date && ([date compare:scheduleEpoch] == NSOrderedAscending);
    if (isBeforeEpoch) date = scheduleEpoch;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    dateFormatter.timeStyle = NSDateFormatterFullStyle;
    NSLog(@"** Scheduling for %@", [dateFormatter stringFromDate:date]);

    return date;
}

- (NSRange)rangeOfMessages:(NSArray<Message *> *)messages beforeTimestamp:(NSDate *)timestamp
{
    NSInteger loc = 0;
    NSInteger len = 0;
    for (Message *message in messages) {
        if ([message.timestamp compare:timestamp] == NSOrderedAscending) {
            len++;
        } else {
            break;
        }
    }
    return NSMakeRange(loc, len);
}

- (NSRange)rangeOfMessages:(NSArray<Message *> *)messages atOrAfterTimestamp:(NSDate *)timestamp
{
    NSInteger loc = 0;
    for (Message *message in messages) {
        if ([message.timestamp compare:timestamp] == NSOrderedAscending) {
            loc++;
        } else {
            break;
        }
    }
    NSInteger len = [messages count] - loc;
    return NSMakeRange(loc, len);
}

@end
