//
//  IntroViewController.m
//  ThePainspace
//
//  Created by Jin Cong & Nick Taras on 24/11/2018.
//  Copyright © 2018 The Painspace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntroViewController.h"
#import "PSDirector.h"

@interface IntroViewController ()

@property (nonatomic, readonly) UILabel *titleLabel;
@property (nonatomic, readonly) UIButton *continueButton;
@property (nonatomic) NSString *imageName;
@property (nonatomic) NSTimer *timer;

@end

@implementation IntroViewController

- (instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName
{
    self = [super init];
    if (self) {
        self.title = title;
        self.imageName = imageName;
    }
    return self;
}

- (void) viewDidAppear:(BOOL)animated
{
    [NSTimer scheduledTimerWithTimeInterval:2.0
    target:self
    selector:@selector(continueButtonSelected)
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
    _titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleTitle1];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = self.title;
    [mainView addSubview:_titleLabel];
    
    _continueButton = [UIButton new];
    [_continueButton setTitle:@"Continue" forState:UIControlStateNormal];
    [_continueButton addTarget:self action:@selector(continueButtonSelected) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:_continueButton];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_titleLabel, _continueButton);
    for (UIView *view in [views allValues]) [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_titleLabel]-|" options:0 metrics:nil views:views]];
    [mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_continueButton]-|" options:0 metrics:nil views:views]];
    [mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_titleLabel]-[_continueButton]" options:0 metrics:nil views:views]];
    
    [mainView addConstraint:[NSLayoutConstraint constraintWithItem:_continueButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:mainView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
}

- (void)continueButtonSelected
{
    [[PSDirector instance] continueAppSequence];
}

@end
