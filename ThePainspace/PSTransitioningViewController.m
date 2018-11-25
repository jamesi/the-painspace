//
//  PSTransitioningViewController.m
//  ThePainspace
//
//  Created by James Ireland on 23/11/2018.
//  Copyright © 2018 The Painspace. All rights reserved.
//

#import "PSTransitioningViewController.h"

#import "PSTransitioningContext.h"
#import "PSFadeTransition.h"

@interface PSTransitioningViewController ()

@property (nonatomic) BOOL transitioning;
@property (nonatomic, readwrite) UIViewController *childViewController;

@end

@implementation PSTransitioningViewController

- (void)setViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self transitionToViewControllerIfNeeded:viewController animated:animated];
}

- (void)transitionToViewControllerIfNeeded:(UIViewController *)viewController animated:(BOOL)animated
{
    if (!_transitioning && _childViewController != viewController) {
        _transitioning = YES;
        UIViewController *prevChildViewController = _childViewController;
        _childViewController = viewController;
        
        if (_childViewController != prevChildViewController) {
            
            // Prepare view controllers
            UIView *childView = _childViewController.view;
            [childView setTranslatesAutoresizingMaskIntoConstraints:YES];
            childView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            childView.frame = self.view.bounds;
            [prevChildViewController willMoveToParentViewController:nil];
            [self addChildViewController:_childViewController];
            
            // Add child view controller without transition if no previous view controller
            if (!prevChildViewController) {
                [self.view addSubview:childView];
                [_childViewController didMoveToParentViewController:self];
                [self setNeedsStatusBarAppearanceUpdate];
                _transitioning = NO;
                return;
            }
            
            // Set up the transition
            id <UIViewControllerAnimatedTransitioning> animator = [PSFadeTransition new];
            PSTransitioningContext *transitionContext = [[PSTransitioningContext alloc] initWithFromViewController:prevChildViewController toViewController:_childViewController];
            transitionContext.animated = animated;
            transitionContext.interactive = NO;
            __weak typeof(self) weakSelf = self;
            transitionContext.completionBlock = ^(BOOL didComplete) {
                [[prevChildViewController view] removeFromSuperview];
                [prevChildViewController removeFromParentViewController];
                [weakSelf.childViewController didMoveToParentViewController:weakSelf];
                if ([animator respondsToSelector:@selector(animationEnded:)]) {
                    [animator animationEnded:didComplete];
                }
                [weakSelf setNeedsStatusBarAppearanceUpdate];
                weakSelf.transitioning = NO;
            };
            
            // Perform the transition
            [animator animateTransition:transitionContext];
        } else {
            _transitioning = NO;
        }
    }
}

@end
