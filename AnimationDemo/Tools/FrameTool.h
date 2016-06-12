//
//  FrameTool.h
//  AnimationDemo
//
//  Created by 向海涛 on 16/4/28.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
@interface FrameTool : NSObject

+ (CGRect)frameForButtonAtIndex:(NSInteger )index startOffsetY:(CGFloat )offsetY;

@end
