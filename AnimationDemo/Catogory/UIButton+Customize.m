//
//  UIButton+Customize.m
//  AnimationDemo
//
//  Created by 向海涛 on 16/4/26.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "UIButton+Customize.h"

@implementation UIButton (Customize)

+ (UIButton *)grayButtonWithTitle:(NSString *)title {
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14.0];
    button.backgroundColor = [UIColor grayColor];
    return button;
}


@end
