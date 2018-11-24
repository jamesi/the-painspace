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

+ (UIColor *)lightTextColor;

+ (UIColor *)darkTextColor;

+ (UIColor *)buttonBackgroundColor;

+ (UIImage *)resizableImageOfRoundedRectWithCornerRadius:(CGFloat)cornerRadius fillColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
