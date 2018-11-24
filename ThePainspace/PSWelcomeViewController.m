//
//  PSWelcomeViewController.m
//  ThePainspace
//
//  Created by James Ireland on 24/11/2018.
//  Copyright © 2018 The Painspace. All rights reserved.
//

#import "PSWelcomeViewController.h"

#import "PSDirector.h"

@interface PSWelcomeViewController ()

@property (nonatomic, readonly) UILabel *headingLabel;
@property (nonatomic, readonly) UILabel *bodyLabel;
@property (nonatomic, readonly) UIButton *continueButton;

@end

@implementation PSWelcomeViewController

- (void)loadView
{
    UIView *mainView = [[UIView alloc] init];
    self.view = mainView;
    mainView.backgroundColor = [UIColor orangeColor];
    
    _headingLabel = [UILabel new];
    _headingLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleTitle1];
    _headingLabel.textAlignment = NSTextAlignmentCenter;
    _headingLabel.text = NSLocalizedString(@"WELCOME_HEADING", nil);
    [mainView addSubview:_headingLabel];
    
    _bodyLabel = [UILabel new];
    _bodyLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    _bodyLabel.textAlignment = NSTextAlignmentCenter;
    _bodyLabel.numberOfLines = 0;
    _bodyLabel.text = NSLocalizedString(@"WELCOME_BODY", nil);
    
    [mainView addSubview:_bodyLabel];
    
    _continueButton = [UIButton new];
    [_continueButton setTitle:@"Continue" forState:UIControlStateNormal];
    [_continueButton addTarget:self action:@selector(continueButtonSelected) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:_continueButton];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_headingLabel, _bodyLabel, _continueButton);
    for (UIView *view in [views allValues]) [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_headingLabel]-|" options:0 metrics:nil views:views]];
    [mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_bodyLabel]-|" options:0 metrics:nil views:views]];
    [mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_continueButton]-|" options:0 metrics:nil views:views]];
    [mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_headingLabel]-[_bodyLabel]-[_continueButton]" options:0 metrics:nil views:views]];
    
    [mainView addConstraint:[_headingLabel.topAnchor constraintEqualToSystemSpacingBelowAnchor:mainView.safeAreaLayoutGuide.topAnchor multiplier:1.0]];
    [mainView addConstraint:[_continueButton.bottomAnchor constraintEqualToAnchor:mainView.safeAreaLayoutGuide.bottomAnchor]];
}

- (void)continueButtonSelected
{
    [[PSDirector instance] continueAppSequence];
}

@end
