//
//  PSFont.h
//  ThePainspace
//
//  Created by James Ireland on 24/11/2018.
//  Copyright © 2018 The Painspace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSFont : NSObject

+ (UIFont *)preferredFontForTextStyle:(UIFontTextStyle)style;

+ (UIFont *)preferredFontForMessage;

+ (UIFont *)preferredFontForMessageTime;

+ (void)logFontNames;

@end
