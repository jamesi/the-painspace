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
#import "ThePainspace-Swift.h"

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
            return [[IntroViewController alloc] initWithTitle:(NSLocalizedString(@"SLIDE0", nil)) imageName:@"IntroSlide0"];
        case PSMainSequenceIntro1:
            return [[IntroViewController alloc] initWithTitle:(NSLocalizedString(@"SLIDE1", nil)) imageName:@"IntroSlide1"];
        case PSMainSequenceIntro2:
            return [[IntroViewController alloc] initWithTitle:(NSLocalizedString(@"SLIDE2", nil)) imageName:@"IntroSlide2"];
        case PSMainSequenceIntro3:
            return [[IntroViewController alloc] initWithTitle:(NSLocalizedString(@"SLIDE3", nil)) imageName:@"IntroSlide3"];
        case PSMainSequenceIntro4:
            return [[IntroViewController alloc] initWithTitle:(NSLocalizedString(@"SLIDE4", nil)) imageName:@"IntroSlide4"];
        case PSMainSequenceIntro5:
            return [[IntroViewController alloc] initWithTitle:(NSLocalizedString(@"SLIDE5", nil)) imageName:@"IntroSlide5"];
        case PSMainSequenceIntro6:
            return [[IntroViewController alloc] initWithTitle:(NSLocalizedString(@"SLIDE6", nil)) imageName:@"IntroSlide6"];
        case PSMainSequenceIntro7:
            return [[IntroViewController alloc] initWithTitle:(NSLocalizedString(@"SLIDE7", nil)) imageName:@"IntroSlide7"];
        case PSMainSequenceIntro8:
            return [[IntroViewController alloc] initWithTitle:(NSLocalizedString(@"SLIDE8", nil)) imageName:@"IntroSlide8"];
        case PSMainSequenceWelcome:
            return [PSWelcomeViewController new];
        case PSMainSequenceMessages: {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName: @"Messages" bundle: nil];
            MessagesViewController *messagesViewController = (MessagesViewController *)[storyboard instantiateViewControllerWithIdentifier: @"MessagesViewController"];
            
            // Setup the messages view controller
            NSArray *messages;
            Message *firstMessage = [[Message alloc] initWithText: @"Sample message 1" timestamp: [NSDate date]];
            Message *secondMessage = [[Message alloc] initWithText: @"This is a very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very long message" timestamp: [NSDate date]];
            messages = [NSArray arrayWithObjects: firstMessage, secondMessage, nil];
            messagesViewController.messages = messages;
            return messagesViewController;
        }
    }
}

@end
