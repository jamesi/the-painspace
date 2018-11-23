//
//  PSMainViewController.m
//  ThePainspace
//
//  Created by James Ireland on 23/11/2018.
//  Copyright © 2018 The Painspace. All rights reserved.
//

#import "PSMainViewController.h"

#import "PSPlaceholderViewController.h"

@interface PSMainViewController ()

@end

@implementation PSMainViewController

- (instancetype)initWithMainSequence:(PSMainSequence)mainSequence
{
    self = [super init];
    if (self) {
        _mainSequence = mainSequence;
        [self setViewController:[self viewControllerForMainSequence:_mainSequence] animated:NO];
    }
    return self;
}

- (void)setMainSequence:(PSMainSequence)mainSequence
{
    if (mainSequence != _mainSequence) {
        _mainSequence = mainSequence;
        [self setViewController:[self viewControllerForMainSequence:_mainSequence] animated:YES];
    }
}

- (UIViewController *)viewControllerForMainSequence:(PSMainSequence)mainSequence
{
    switch (mainSequence) {
        case PSMainSequenceIntro:
            return [[PSPlaceholderViewController alloc] initWithTitle:@"Intro Screen"];
        case PSMainSequenceWelcome:
            return [[PSPlaceholderViewController alloc] initWithTitle:@"Welcome Screen"];
        case PSMainSequenceMessages:
            return [[PSPlaceholderViewController alloc] initWithTitle:@"Messages Screen"];
    }
}

@end
