//
//  FrameTool.m
//  AnimationDemo
//
//  Created by 向海涛 on 16/4/28.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "FrameTool.h"

@implementation FrameTool

+ (CGRect)frameForButtonAtIndex:(NSInteger )index startOffsetY:(CGFloat )offsetY{
    CGFloat width = 50.0f;
    CGFloat height = 44.0f;
    NSInteger totalButtonAtLine = (NSInteger) (SCREEN_WIDTH/(width + 10));
    CGFloat offsetX = 10 + (10 + width) * (index%totalButtonAtLine);
    offsetY += 10 + height * (index/totalButtonAtLine);
    return CGRectMake(offsetX,offsetY,width,height);
}

@end
