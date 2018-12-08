//
//  PSStyle.h
//  ThePainspace
//
//  Created by James Ireland on 24/11/2018.
//  Copyright © 2018 The Painspace. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PSStyle : NSObject

+ (void)configureAppearance;

@end

@interface PSStyle (Color)

+ (UIColor *)lightTextColor;

+ (UIColor *)darkTextColor;

+ (UIColor *)messageBodyTextColor;

+ (UIColor *)messageMetadataTextColor;

+ (UIColor *)messageBulletColor;

+ (UIColor *)messageBackgroundColor;

+ (UIColor *)buttonBackgroundColor;

+ (UIColor *)navigationBarBackgroundColor;

+ (UIColor *)colorWithRGB:(NSInteger)value;

@end

@interface PSStyle (Font)

+ (UIFont *)preferredFontForTextStyle:(UIFontTextStyle)style;

+ (UIFont *)preferredFontForMessage;

+ (UIFont *)preferredFontForMessageTime;

+ (void)logFontNames;

@end

@interface PSStyle (Image)

+ (UIImage *)resizableImageOfRoundedRectWithCornerRadius:(CGFloat)cornerRadius fillColor:(UIColor *)color;

+ (UIImage *)scaledImage:(UIImage *)image toWidth:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
