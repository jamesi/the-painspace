//
//  PSMainViewController.m
//  ThePainspace
//
//  Created by James Ireland on 23/11/2018.
//  Copyright © 2018 The Painspace. All rights reserved.
//

#import "PSMainViewController.h"

#import "PSWelcomeViewController.h"
#import "PSMessageScheduler.h"
#import "PSPlaceholderViewController.h"
#import "IntroViewController.h"
#import "ThePainspace-Swift.h"
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
    switch (mainSequence) {
        case PSMainSequenceIntro0:
            return [[IntroViewController alloc] initWithTitle:(NSLocalizedString(@"SLIDE0", nil)) imageName:@"cloud1" textColor:[PSStyle darkTextColor]];
        case PSMainSequenceIntro1:
            return [[IntroViewController alloc] initWithTitle:(NSLocalizedString(@"SLIDE1", nil)) imageName:@"cloud2" textColor:[PSStyle darkTextColor]];
        case PSMainSequenceIntro2:
            return [[IntroViewController alloc] initWithTitle:(NSLocalizedString(@"SLIDE2", nil)) imageName:@"cloud3" textColor:[PSStyle darkTextColor]];
        case PSMainSequenceIntro3:
            return [[IntroViewController alloc] initWithTitle:(NSLocalizedString(@"SLIDE3", nil)) imageName:@"cloud4" textColor:[PSStyle darkTextColor]];
        case PSMainSequenceIntro4:
            return [[IntroViewController alloc] initWithTitle:(NSLocalizedString(@"SLIDE4", nil)) imageName:@"cloud5" textColor:[PSStyle darkTextColor]];
        case PSMainSequenceIntro5:
            return [[IntroViewController alloc] initWithTitle:(NSLocalizedString(@"SLIDE5", nil)) imageName:@"cloud6" textColor:[PSStyle darkTextColor]];
        case PSMainSequenceIntro6:
            return [[IntroViewController alloc] initWithTitle:(NSLocalizedString(@"SLIDE6", nil)) imageName:@"cloud7" textColor:[PSStyle darkTextColor]];
        case PSMainSequenceIntro7:
            return [[IntroViewController alloc] initWithTitle:(NSLocalizedString(@"SLIDE7", nil)) imageName:@"cloud8" textColor:[PSStyle darkTextColor]];
        case PSMainSequenceIntro8:
            return [[IntroViewController alloc] initWithTitle:(NSLocalizedString(@"SLIDE8", nil)) imageName:@"cloud9" textColor:[PSStyle darkTextColor]];
        case PSMainSequenceWelcome:
            return [PSWelcomeViewController new];
        case PSMainSequenceMessages: {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName: @"Messages" bundle: nil];
            MessagesViewController *messagesViewController = (MessagesViewController *)[storyboard instantiateViewControllerWithIdentifier: @"MessagesViewController"];
            
            // Setup the messages view controller
            NSArray *messages = [self.messageScheduler historicalMessagesRelativeToTimepoint:[NSDate date]];
            messagesViewController.messages = messages;

            return messagesViewController;
        }
    }
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

@end
