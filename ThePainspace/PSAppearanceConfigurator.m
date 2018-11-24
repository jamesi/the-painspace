//
//  PSAppearanceConfigurator.m
//  ThePainspace
//
//  Created by James Ireland on 23/11/2018.
//  Copyright © 2018 The Painspace. All rights reserved.
//

#import "PSAppearanceConfigurator.h"

#import "PSFont.h"
#import "PSStyle.h"

@implementation PSAppearanceConfigurator

+ (void)configure
{    
    UIImage *buttonBackgroundImage = [PSStyle resizableImageOfRoundedRectWithCornerRadius:12.0 fillColor:[PSStyle buttonBackgroundColor]];
    
    [[UIButton appearance] setBackgroundImage:buttonBackgroundImage forState:UIControlStateNormal];
    [[UIButton appearance] setTitleColor:[PSStyle lightTextColor] forState:UIControlStateNormal];
    [[UIButton appearance] setContentEdgeInsets:UIEdgeInsetsMake(12.0, 12.0, 12.0, 12.0)];

    [[UILabel appearance] setFont:[PSFont preferredFontForTextStyle:UIFontTextStyleBody]];
}

@end
