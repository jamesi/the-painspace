//
//  PSStyle.m
//  ThePainspace
//
//  Created by James Ireland on 24/11/2018.
//  Copyright © 2018 The Painspace. All rights reserved.
//

#import "PSStyle.h"

#import "UIColor+PSColor.h"

@implementation PSStyle

+ (UIColor *)lightTextColor
{
    return [UIColor whiteColor]; // todo: should not be pure white
}

+ (UIColor *)darkTextColor
{
    return [UIColor colorWithRGB:0x5a6978];
}

+ (UIColor *)buttonBackgroundColor
{
    return [UIColor colorWithRGB:0x47525e];
}

+ (UIImage *)resizableImageOfRoundedRectWithCornerRadius:(CGFloat)cornerRadius fillColor:(UIColor *)fillColor
{
    CGFloat dimension = cornerRadius * 2.0 + 1.0;
    CGRect imageRect = CGRectMake(0.0f, 0.0f, dimension, dimension);
    CGSize imageSize = CGSizeMake(dimension, dimension);
    
    CGSize cornerRadii = CGSizeMake(cornerRadius, cornerRadius);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:imageRect byRoundingCorners:UIRectCornerAllCorners cornerRadii:cornerRadii];
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [fillColor CGColor]);
    [path fill];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGFloat insetSize = cornerRadius; // to leave one stretchable point
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(insetSize, insetSize, insetSize, insetSize)];
}

@end
