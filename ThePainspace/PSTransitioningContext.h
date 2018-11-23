//
//  PSTransitioningContext.h
//  ThePainspace
//
//  Created by James Ireland on 23/11/2018.
//  Copyright © 2018 The Painspace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSTransitioningContext : NSObject <UIViewControllerContextTransitioning>

@property (nonatomic, assign, getter = isAnimated) BOOL animated;
@property (nonatomic, assign, getter = isInteractive) BOOL interactive;
@property (nonatomic, copy) void (^completionBlock)(BOOL didComplete);

- (instancetype)initWithFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController;

@end
