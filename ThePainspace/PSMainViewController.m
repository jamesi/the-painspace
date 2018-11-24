//
//  PSMainViewController.m
//  ThePainspace
//
//  Created by James Ireland on 23/11/2018.
//  Copyright © 2018 The Painspace. All rights reserved.
//

#import "PSMainViewController.h"

#import "PSWelcomeViewController.h"
#import "PSPlaceholderViewController.h"
#import "IntroViewController.h"

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
        case PSMainSequenceIntro0:
            return [[IntroViewController alloc] initWithTitle:@"Intro Screen 0" imageName:@"IntroSlide0"];
        case PSMainSequenceIntro1:
            return [[IntroViewController alloc] initWithTitle:@"Intro Screen 1" imageName:@"IntroSlide1"];
        case PSMainSequenceIntro2:
            return [[IntroViewController alloc] initWithTitle:@"Intro Screen 2" imageName:@"IntroSlide2"];
        case PSMainSequenceIntro3:
            return [[IntroViewController alloc] initWithTitle:@"Intro Screen 3" imageName:@"IntroSlide3"];
        case PSMainSequenceWelcome:
            return [PSWelcomeViewController new];
        case PSMainSequenceMessages:
            return [[PSPlaceholderViewController alloc] initWithTitle:@"Messages Screen"];
    }
}

@end
