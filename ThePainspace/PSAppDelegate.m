//
//  PSAppDelegate.m
//  ThePainspace
//
//  Created by James Ireland on 23/11/2018.
//  Copyright © 2018 The Painspace. All rights reserved.
//

#import "PSAppDelegate.h"

#import "PSAppearanceConfigurator.h"
#import "PSDirector.h"
#import "PSMainViewController.h"

static BOOL PSAppDelegateIsRunningTests(void)
{
    NSDictionary *environment = [[NSProcessInfo processInfo] environment];
    NSString *injectBundle = environment[@"XCInjectBundleInto"];
    return injectBundle != nil;
}

@interface PSAppDelegate ()

@property (nonatomic) PSMainViewController *mainViewController;

@end

@implementation PSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    if (PSAppDelegateIsRunningTests()) return YES;

    [PSAppearanceConfigurator configure];
    
    [[UNUserNotificationCenter currentNotificationCenter] setDelegate:self];
    
    // *center stores a local reference to the UNUserNotificationCenter
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];

    // assign alert types to options
    UNAuthorizationOptions options = UNAuthorizationOptionAlert + UNAuthorizationOptionSound + UNAuthorizationOptionBadge;
    
    // assign options to notification
    [center requestAuthorizationWithOptions:options
      completionHandler:^(BOOL granted, NSError * _Nullable error) {
          if (!granted) {
              NSLog(@"Something went wrong");
          }
      }];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SomeActionIsComplete" object:nil userInfo:nil];
    
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    content.title = @"Don't forget";
    content.body = @"Buy some milk";
    content.sound = [UNNotificationSound defaultSound];
    
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
    
    NSString *identifier = @"UYLLocalNotification";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:trigger];
    
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Something went wrong: %@",error);
        }
    }];
    
//    [[NSNotificationCenter defaultCenter] addObserverForName:@”SomeActionIsComplete” object:nil queue:nil usingBlock:^(NSNotification *note)
//    {
//        NSLog(@”The action I was waiting for is complete!!!”);
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.mainViewController = [[PSMainViewController alloc] initWithMainSequence:PSMainSequenceIntro0];
    [PSDirector instance].mainViewController = self.mainViewController;
    [self.window setRootViewController:self.mainViewController];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)userNotificationCenter:(UNUserNotificationCenter* )center willPresentNotification:(UNNotification* )notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    NSLog(@"TODO - use callback to handle update of messages.");
    completionHandler(UNNotificationPresentationOptionAlert);
}

@end
