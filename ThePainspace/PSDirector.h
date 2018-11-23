//
//  PSDirector.h
//  ThePainspace
//
//  Created by James Ireland on 23/11/2018.
//  Copyright © 2018 The Painspace. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PSMainViewController.h"

@interface PSDirector : NSObject

@property (nonatomic) PSMainViewController *mainViewController;

+ (instancetype)instance;

- (void)continueAppSequence;
- (void)presentTerms;
- (void)presentPrivacyPolicy;

@end
