//
//  PSTransitioningContext.m
//  ThePainspace
//
//  Created by James Ireland on 23/11/2018.
//  Copyright © 2018 The Painspace. All rights reserved.
//

#import "PSTransitioningContext.h"

@implementation PSTransitioningContext {
    NSDictionary *_viewControllers;
    __weak UIView *_containerView;
}

- (instancetype)initWithFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController
{
    NSAssert ([fromViewController isViewLoaded] && fromViewController.view.superview, @"The fromViewController view must reside in the container view upon initializing the transition context.");
    if ((self = [super init])) {
        _containerView = fromViewController.view.superview;
        _viewControllers = @{UITransitionContextFromViewControllerKey:fromViewController, UITransitionContextToViewControllerKey:toViewController};
    }
    return self;
}

- (UIView *)containerView
{
    return _containerView;
}

- (UIModalPresentationStyle)presentationStyle
{
    return UIModalPresentationCustom;
}

- (CGRect)initialFrameForViewController:(UIViewController *)viewController
{
    return _containerView.bounds;
}

- (CGRect)finalFrameForViewController:(UIViewController *)viewController
{
    return _containerView.bounds;
}

- (UIViewController *)viewControllerForKey:(NSString *)key
{
    return _viewControllers[key];
}

- (void)completeTransition:(BOOL)didComplete
{
    if (self.completionBlock) {
        self.completionBlock (didComplete);
    }
}

- (BOOL)transitionWasCancelled
{
    return NO;
}

- (UIView *)viewForKey:(NSString *)key
{
    // Not used by our custom transitions
    return nil;
}

- (CGAffineTransform)targetTransform
{
    // Not used by our custom transitions
    return CGAffineTransformIdentity;
}

- (void)updateInteractiveTransition:(CGFloat)percentComplete
{
    // This context doesn't support interactive transitions
}

- (void)finishInteractiveTransition
{
    // This context doesn't support interactive transitions
}

- (void)cancelInteractiveTransition
{
    // This context doesn't support interactive transitions
}

- (void)pauseInteractiveTransition
{
    // This context doesn't support interactive transitions
}

@end
