//
//  PSTransitioningViewController.h
//  ThePainspace
//
//  Created by James Ireland on 23/11/2018.
//  Copyright © 2018 The Painspace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSTransitioningViewController : UIViewController

@property (nonatomic, readonly) UIViewController *childViewController;

- (void)setViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end
