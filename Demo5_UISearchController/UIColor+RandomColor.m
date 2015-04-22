//
//  UIColor+RandomColor.m
//  Demo5_UISearchController
//
//  Created by tarena on 15-1-28.
//  Copyright (c) 2015年 Tarena. All rights reserved.
//

#import "UIColor+RandomColor.h"

@implementation UIColor (RandomColor)
+ (UIColor *)randomColor
{
    return [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1.0];
}
@end
