//
//  IntroViewController.m
//  ThePainspace
//
//  Created by Jin Cong & Nick Taras on 24/11/2018.
//  Copyright © 2018 The Painspace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntroViewController.h"
#import "PSStyle.h"

@interface IntroViewController ()

@property (nonatomic, readonly) UILabel *titleLabel;
@property (nonatomic, readonly) UIButton *continueButton;
@property (nonatomic) NSString *imageName;
@property (nonatomic) UIColor *textColor;
@property (nonatomic) NSTimer *timer;

@end

@implementation IntroViewController

- (instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName textColor:(UIColor *)textColor
{
    self = [super init];
    if (self) {
        self.title = title;
        self.imageName = imageName;
        self.textColor = textColor;
    }
    return self;
}

- (void) viewDidAppear:(BOOL)animated
{
    [NSTimer scheduledTimerWithTimeInterval:4
    target:self
    selector:@selector(continueSlideSequence)
    userInfo:nil
    repeats:NO];
}

- (void)loadView
{
    UIView *mainView = [[UIView alloc] init];
    self.view = mainView;
    
    // Define image
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.imageName]];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview: imageView];
    
    mainView.backgroundColor = [UIColor blueColor];
    
    _titleLabel = [UILabel new];
    _titleLabel.font = [PSStyle preferredFontForTextStyle:UIFontTextStyleTitle1];
    _titleLabel.textColor = self.textColor;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _titleLabel.numberOfLines = 0;
    _titleLabel.text = self.title;
    
    [mainView addSubview:_titleLabel];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_titleLabel);
    for (UIView *view in [views allValues]) [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_titleLabel]-|" options:0 metrics:nil views:views]];
    [mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_titleLabel]" options:0 metrics:nil views:views]];
    
    [mainView addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:mainView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
}

- (void)continueSlideSequence
{
    [self.delegate introViewControllerDidFinish];
}

@end
