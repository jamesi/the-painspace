//
//  PSMainViewController.h
//  ThePainspace
//
//  Created by James Ireland on 23/11/2018.
//  Copyright © 2018 The Painspace. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PSMessageScheduler.h"
#import "PSTransitioningViewController.h"

#import "ThePainspace-Swift.h"

typedef NS_ENUM(NSInteger, PSMainSequence) {
    PSMainSequenceIntro0 = 0,
    PSMainSequenceIntro1,
    PSMainSequenceIntro2,
    PSMainSequenceIntro3,
    PSMainSequenceIntro4,
    PSMainSequenceIntro5,
    PSMainSequenceIntro6,
    PSMainSequenceIntro7,
    PSMainSequenceIntro8,
    PSMainSequenceWelcome,
    PSMainSequenceMessages
};

@interface PSMainViewController : PSTransitioningViewController <WelcomeViewControllerDelegate>

@property (nonatomic, readonly) PSMessageScheduler *messageScheduler;

@property (nonatomic) PSMainSequence mainSequence;

- (instancetype)initWithMainSequence:(PSMainSequence)mainSequence;

@end
