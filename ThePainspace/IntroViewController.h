//
//  IntroViewController.h
//  ThePainspace
//
//  Created by Jin Cong & Nick Taras on 24/11/2018.
//  Copyright © 2018 The Painspace. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IntroViewControllerDelegate <NSObject>

- (void)introViewControllerDidFinish;

@end

@interface IntroViewController : UIViewController

@property (nonatomic, weak) id <IntroViewControllerDelegate> delegate;

- (instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName textColor:(UIColor *)textColor;

@end
