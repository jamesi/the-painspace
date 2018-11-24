//
//  PSFont.m
//  ThePainspace
//
//  Created by James Ireland on 24/11/2018.
//  Copyright © 2018 The Painspace. All rights reserved.
//

#import "PSFont.h"

@implementation PSFont

+ (UIFont *)preferredFontForTextStyle:(UIFontTextStyle)style
{
    // arvo (27.5px?)
    UIFont *baseFont = [UIFont fontWithName:@"35mm" size:36.0];
    return [[UIFontMetrics metricsForTextStyle:style] scaledFontForFont:baseFont];
}

+ (UIFont *)preferredFontForMessage
{
    // lato regular 15px
    return [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}

+ (void)logFontNames
{
    for (NSString *family in [UIFont familyNames]){
        NSLog(@"familyName: %@", family);
        for (NSString *fontName in [UIFont fontNamesForFamilyName:family]) {
            NSLog(@" ; fontName: %@", fontName);
        }
    }
}

@end
