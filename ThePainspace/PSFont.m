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
    CGFloat size = 17.5;
    if (style == UIFontTextStyleTitle1) {
        size = 27.5;
    }
    UIFont *baseFont = [UIFont fontWithName:@"Arvo" size:size];
    return [[UIFontMetrics metricsForTextStyle:style] scaledFontForFont:baseFont];
}

+ (UIFont *)preferredFontForMessage
{
    UIFont *baseFont = [UIFont fontWithName:@"Lato" size:17.5];
    return [[UIFontMetrics metricsForTextStyle:UIFontTextStyleBody] scaledFontForFont:baseFont];
}

+ (UIFont *)preferredFontForMessageTime
{
    UIFont *baseFont = [UIFont fontWithName:@"Lato" size:15.0];
    return [[UIFontMetrics metricsForTextStyle:UIFontTextStyleBody] scaledFontForFont:baseFont];
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
