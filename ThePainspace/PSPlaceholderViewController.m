//
//  PSPlaceholderViewController.m
//  ThePainspace
//
//  Created by James Ireland on 23/11/2018.
//  Copyright © 2018 The Painspace. All rights reserved.
//

#import "PSPlaceholderViewController.h"

#import "PSDirector.h"

@interface PSPlaceholderViewController ()

@property (nonatomic, readonly) UILabel *titleLabel;
@property (nonatomic, readonly) UIButton *continueButton;

@end

@implementation PSPlaceholderViewController

- (instancetype)initWithTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        self.title = title;
    }
    return self;
}

- (void)loadView
{
    UIView *mainView = [[UIView alloc] init];
    self.view = mainView;
    mainView.backgroundColor = [UIColor orangeColor];
    
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
