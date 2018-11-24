//
//  UIColor+PSColor.m
//  ThePainspace
//
//  Created by James Ireland on 24/11/2018.
//  Copyright © 2018 The Painspace. All rights reserved.
//

#import "UIColor+PSColor.h"

@implementation UIColor (PSColor)

+ (UIColor *)colorWithRGB:(NSInteger)value
{
    CGFloat red = ((value & 0xff0000) >> 16) / 255.0;
    CGFloat green = ((value & 0xff00) >> 8) / 255.0;
    CGFloat blue = (value & 0xff) / 255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

@end
