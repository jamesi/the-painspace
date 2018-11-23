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
    PSMainSequenceIntro = 0,
    PSMainSequenceWelcome,
    PSMainSequenceMessages
};

@interface PSMainViewController : PSTransitioningViewController

@property (nonatomic) PSMainSequence mainSequence;

- (instancetype)initWithMainSequence:(PSMainSequence)mainSequence;

@end
