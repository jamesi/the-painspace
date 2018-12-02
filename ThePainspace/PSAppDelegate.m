//
//  PSAppDelegate.m
//  ThePainspace
//
//  Created by James Ireland on 23/11/2018.
//  Copyright © 2018 The Painspace. All rights reserved.
//

#import "PSAppDelegate.h"
#import "PSDirector.h"
#import "PSMainViewController.h"
#import "PSStyle.h"
#import "PSUserDefaults.h"

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

    [PSStyle configureAppearance];
    
    // Foreground notification utility method
    [[UNUserNotificationCenter currentNotificationCenter] setDelegate:self];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    PSMainSequence initialSequence = [PSUserDefaults initialSequence];
    self.mainViewController = [[PSMainViewController alloc] initWithMainSequence:initialSequence];
    [PSDirector instance].mainViewController = self.mainViewController;
    [self.window setRootViewController:self.mainViewController];
    [self.window makeKeyAndVisible];
    
    return YES;
}

// Call back when notification is sent whilst app in foreground.
- (void)userNotificationCenter:(UNUserNotificationCenter* )center willPresentNotification:(UNNotification* )notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    NSLog(@"TODO - use callback to handle update of messages.");
    completionHandler(UNNotificationPresentationOptionAlert);

    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PSMessagesDidChangeNotification" object:nil];
}

@end
