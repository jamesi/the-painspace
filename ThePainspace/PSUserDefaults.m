//
//  PSUserDefaults.m
//  ThePainspace
//
//  Created by James Ireland on 25/11/2018.
//  Copyright © 2018 The Painspace. All rights reserved.
//

#import "PSUserDefaults.h"

@implementation PSUserDefaults

+ (PSMainSequence)initialSequence
{
    NSInteger value = [[NSUserDefaults standardUserDefaults] integerForKey:@"PSInitialSequence"];
    return (PSMainSequence)value; // defaults to PSMainSequenceIntro0 if not set
}

+ (void)setInitialSequence:(PSMainSequence)initialSequence
{
    [[NSUserDefaults standardUserDefaults] setInteger:(NSInteger)initialSequence forKey:@"PSInitialSequence"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSDate *)messagesScheduleEpoch
{
    NSDate *epoch = (NSDate *)[[NSUserDefaults standardUserDefaults] objectForKey:@"PSMessagesScheduleEpoch"];
    return epoch ? epoch : [NSDate date];
}

+ (void)setMessagesScheduleEpoch:(NSDate *)epoch
{
    [[NSUserDefaults standardUserDefaults] setObject:epoch forKey:@"PSMessagesScheduleEpoch"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
