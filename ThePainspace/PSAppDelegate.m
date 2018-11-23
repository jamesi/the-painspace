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
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.mainViewController = [[PSMainViewController alloc] initWithMainSequence:PSMainSequenceIntro];
    [PSDirector instance].mainViewController = self.mainViewController;
    [self.window setRootViewController:self.mainViewController];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
