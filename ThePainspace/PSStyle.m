//
//  PSStyle.m
//  ThePainspace
//
//  Created by James Ireland on 24/11/2018.
//  Copyright © 2018 The Painspace. All rights reserved.
//

#import "PSStyle.h"

@implementation PSStyle

+ (void)configureAppearance
{
    UIImage *buttonBackgroundImage = [PSStyle resizableImageOfRoundedRectWithCornerRadius:8.0 fillColor:[PSStyle buttonBackgroundColor]];
    [[UIButton appearance] setBackgroundImage:buttonBackgroundImage forState:UIControlStateNormal];
    [[UIButton appearance] setTitleColor:[PSStyle lightTextColor] forState:UIControlStateNormal];
    [[UIButton appearance] setContentEdgeInsets:UIEdgeInsetsMake(12.0, 12.0, 12.0, 12.0)];
    [[UILabel appearance] setFont:[self preferredFontForTextStyle:UIFontTextStyleBody]];

}

@end

@implementation PSStyle (Font)

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

@implementation PSStyle (Color)

+ (UIColor *)lightTextColor
{
    return [self colorWithRGB:0xfbfbfb];
}

+ (UIColor *)darkTextColor
{
    return [self colorWithRGB:0x5a6978];
}

+ (UIColor *)messageBodyTextColor
{
    return [self colorWithRGB:0x47525E];
}

+ (UIColor *)messageMetadataTextColor
{
    return [self colorWithRGB:0x4d5662];
}

+ (UIColor *)messageBulletColor
{
    return [self colorWithRGB:0x8190a5];
}

+ (UIColor *)messageBackgroundColor
{
    return [self colorWithRGB:0xe5e9f2];
}

+ (UIColor *)buttonBackgroundColor
{
    return [self colorWithRGB:0x47525e];
}

+ (UIColor *)colorWithRGB:(NSInteger)value
{
    CGFloat red = ((value & 0xff0000) >> 16) / 255.0;
    CGFloat green = ((value & 0xff00) >> 8) / 255.0;
    CGFloat blue = (value & 0xff) / 255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

@end

@implementation PSStyle (Image)

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
