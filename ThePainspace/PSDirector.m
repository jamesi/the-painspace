//
//  PSDirector.m
//  ThePainspace
//
//  Created by James Ireland on 23/11/2018.
//  Copyright © 2018 The Painspace. All rights reserved.
//

#import "PSDirector.h"

static PSDirector *PSDirectorInstance;

@implementation PSDirector

+ (void)initialize
{
    PSDirectorInstance = [[PSDirector alloc] init];
}

+ (instancetype)instance
{
    return PSDirectorInstance;
}

- (void)continueAppSequence
{
    PSMainSequence sequence = self.mainViewController.mainSequence;
    if (sequence < PSMainSequenceMessages) {
        sequence++;
    }
    self.mainViewController.mainSequence = sequence;
}

- (void)presentTerms
{
}

- (void)presentPrivacyPolicy
{
}

@end
