//
//  PSMainViewController.m
//  ThePainspace
//
//  Created by James Ireland on 23/11/2018.
//  Copyright © 2018 The Painspace. All rights reserved.
//

#import "PSMainViewController.h"

#import "PSMessageScheduler.h"
#import "IntroViewController.h"
#import "PSNotificationScheduler.h"
#import "PSUserDefaults.h"
#import "PSStyle.h"

@interface PSMainViewController ()

@property (nonatomic, readonly) NSMutableArray *observers;

@end

@implementation PSMainViewController

@synthesize messageScheduler = _messageScheduler;

- (instancetype)initWithMainSequence:(PSMainSequence)mainSequence
{
    self = [super init];
    if (self) {
        _mainSequence = mainSequence;
        [self mainSequenceDidChangeTo:_mainSequence];
        [self setViewController:[self viewControllerForMainSequence:_mainSequence] animated:NO];
        
        _observers = [NSMutableArray new];
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        NSOperationQueue *queue = [NSOperationQueue mainQueue];
        __weak __typeof(self) weakSelf = self;
        [_observers addObject:[center addObserverForName:@"PSMessagesDidChangeNotification" object:nil queue:queue usingBlock:^(NSNotification *note) {
            [weakSelf messagesDidChange];
        }]];
    }
    return self;
}

- (void)setMainSequence:(PSMainSequence)mainSequence
{
    if (mainSequence != _mainSequence) {
        _mainSequence = mainSequence;
        [self mainSequenceDidChangeTo:_mainSequence];
        [self setViewController:[self viewControllerForMainSequence:_mainSequence] animated:YES];
    }
}

- (UIViewController *)viewControllerForMainSequence:(PSMainSequence)mainSequence
{
    UIViewController *viewController;
    switch (mainSequence) {
        case PSMainSequenceIntro0:
        case PSMainSequenceIntro1:
        case PSMainSequenceIntro2:
        case PSMainSequenceIntro3:
        case PSMainSequenceIntro4:
        case PSMainSequenceIntro5:
        case PSMainSequenceIntro6:
        case PSMainSequenceIntro7:
        case PSMainSequenceIntro8: {
            NSString *titleKey = [NSString stringWithFormat:@"SLIDE%ld", mainSequence];
            NSString *imageName = [NSString stringWithFormat:@"cloud%ld", mainSequence + 1];
            IntroViewController *introViewController = [[IntroViewController alloc] initWithTitle:(NSLocalizedString(titleKey, nil)) imageName:imageName textColor:[PSStyle darkTextColor]];
            introViewController.delegate = self;
            viewController = introViewController;
            break;
        }
        case PSMainSequenceWelcome: {
            WelcomeViewController *welcomeViewController = [WelcomeViewController new];
            welcomeViewController.delegate = self;
            viewController = welcomeViewController;
            break;
        }
        case PSMainSequenceMessages: {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName: @"Messages" bundle: nil];
            MessagesViewController *messagesViewController = (MessagesViewController *)[storyboard instantiateViewControllerWithIdentifier: @"MessagesViewController"];
            NSArray *messages = [self.messageScheduler historicalMessagesRelativeToTimepoint:[NSDate date]];
            messagesViewController.messages = messages;
            viewController = messagesViewController;
            break;
        }
    }
    return viewController;
}

- (void)mainSequenceDidChangeTo:(PSMainSequence)toMainSequence
{
    switch (toMainSequence) {
        case PSMainSequenceWelcome: {
            [PSUserDefaults setInitialSequence:PSMainSequenceWelcome];
            break;
        }
        case PSMainSequenceMessages: {
            [PSUserDefaults setInitialSequence:PSMainSequenceMessages];
            NSArray *futureMessages = [self.messageScheduler futureMessagesRelativeToTimepoint:[NSDate date]];
            [PSNotificationScheduler addNotificationRequestsForMessages:futureMessages];
            break;
        }
        default:
            break;
    }
}

- (void)messagesDidChange
{
    if ([self.childViewController isKindOfClass:[MessagesViewController class]]) {
        NSLog(@"**Messages changed");
        NSArray *messages = [self.messageScheduler historicalMessagesRelativeToTimepoint:[NSDate date]];
        NSLog(@"** New messages count: %lu", (unsigned long)[messages count]);
        ((MessagesViewController *)self.childViewController).messages = messages;
    }
}

- (PSMessageScheduler *)messageScheduler
{
    if (!_messageScheduler) {
        
        // Parse the sample messages
        MessageDefParser *messageDefParser = [MessageDefParser alloc];
        NSArray *messageDefs = [messageDefParser getSampleMessages];

        NSDate *scheduleEpoch = [PSUserDefaults messagesScheduleEpoch];
        _messageScheduler = [[PSMessageScheduler alloc] initWithMessageDefs:messageDefs scheduleEpoch:scheduleEpoch];
    }
    return _messageScheduler;
}

- (void)continueMainSequence
{
    PSMainSequence sequence = self.mainSequence;
    if (sequence < PSMainSequenceMessages) {
        sequence++;
    }
    self.mainSequence = sequence;
}

#pragma mark <IntroViewControllerDelegate>

- (void)introViewControllerDidFinish
{
    [self continueMainSequence];
}

#pragma mark <WelcomeViewControllerDelegate>

- (void)welcomeViewControllerDidSelectContinue
{
    [PSUserDefaults setMessagesScheduleEpoch:[NSDate new]];
    [PSNotificationScheduler requestAuthorization];
    [self continueMainSequence];
}

@end
