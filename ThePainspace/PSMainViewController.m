//
//  PSMainViewController.m
//  ThePainspace
//
//  Created by James Ireland on 23/11/2018.
//  Copyright © 2018 The Painspace. All rights reserved.
//

#import "PSMainViewController.h"

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
            return [[IntroViewController alloc] initWithTitle:@"Created for the sufferer by the sufferer" imageName:@"IntroSlide0"];
        case PSMainSequenceIntro1:
            return [[IntroViewController alloc] initWithTitle:@"You are not alone in persistant pain" imageName:@"IntroSlide1"];
        case PSMainSequenceIntro2:
            return [[IntroViewController alloc] initWithTitle:@"Healing starts at home" imageName:@"IntroSlide2"];
        case PSMainSequenceIntro3:
            return [[IntroViewController alloc] initWithTitle:@"It starts with you\n home is inside you" imageName:@"IntroSlide3"];
        case PSMainSequenceIntro4:
            return [[IntroViewController alloc] initWithTitle:@"You are precious\n we are going to help" imageName:@"IntroSlide4"];
        case PSMainSequenceIntro5:
            return [[IntroViewController alloc] initWithTitle:@"We are going to do this\n one text at a time" imageName:@"IntroSlide5"];
        case PSMainSequenceIntro6:
            return [[IntroViewController alloc] initWithTitle:@"The texts can build on each other\n to make a bridge" imageName:@"IntroSlide6"];
        case PSMainSequenceIntro7:
            return [[IntroViewController alloc] initWithTitle:@"That leads you back to focus on life" imageName:@"IntroSlide7"];
        case PSMainSequenceIntro8:
            return [[IntroViewController alloc] initWithTitle:@"All you have to do is try\n something new" imageName:@"IntroSlide8"];
        case PSMainSequenceWelcome:
            return [[PSPlaceholderViewController alloc] initWithTitle:@"Welcome Screen"];
        case PSMainSequenceMessages:
            return [[PSPlaceholderViewController alloc] initWithTitle:@"Messages Screen"];
    }
}

@end
