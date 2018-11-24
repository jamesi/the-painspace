//
//  PSMainViewController.h
//  ThePainspace
//
//  Created by James Ireland on 23/11/2018.
//  Copyright © 2018 The Painspace. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PSTransitioningViewController.h"

typedef NS_ENUM(NSInteger, PSMainSequence) {
    PSMainSequenceIntro0 = 0,
    PSMainSequenceIntro1,
    PSMainSequenceIntro2,
    PSMainSequenceIntro3,
    PSMainSequenceWelcome,
    PSMainSequenceMessages
};

@interface PSMainViewController : PSTransitioningViewController

@property (nonatomic) PSMainSequence mainSequence;

- (instancetype)initWithMainSequence:(PSMainSequence)mainSequence;

@end
