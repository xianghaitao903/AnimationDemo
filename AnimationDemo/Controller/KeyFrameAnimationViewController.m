//
//  KeyFrameAnimationViewController.m
//  AnimationDemo
//
//  Created by 向海涛 on 16/4/28.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "KeyFrameAnimationViewController.h"
#import "UIButton+Customize.h"
#import "FrameTool.h"

@interface KeyFrameAnimationViewController ()

@property (strong, nonatomic) UIView *animationView;
@property (strong, nonatomic) UIButton *keyFrameAnimationButton;
@property (strong, nonatomic) UIButton *pathAnimationButton;
@property (strong, nonatomic) UIButton *shakeAnimationButton;

@end

@implementation KeyFrameAnimationViewController


#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关键帧";
    [self initSubviews];
    [self setLayout];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self initEvents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initSubviews {
    [self.view addSubview:self.animationView];
    [self.view addSubview:self.keyFrameAnimationButton];
    [self.view addSubview:self.pathAnimationButton];
    [self.view addSubview:self.shakeAnimationButton];
}

- (void)setLayout {
    CGFloat startOffset                = (CGFloat) (SCREEN_HEIGHT - 150.0);
    self.animationView.frame           = CGRectMake(10.0,180.0,50.0,50.0);
    self.keyFrameAnimationButton.frame = [FrameTool frameForButtonAtIndex:0 startOffsetY:startOffset];
    self.pathAnimationButton.frame     = [FrameTool frameForButtonAtIndex:1 startOffsetY:startOffset];
    self.shakeAnimationButton.frame    = [FrameTool frameForButtonAtIndex:2  startOffsetY:startOffset];
}

- (void)initEvents {
    [self.keyFrameAnimationButton addTarget:self
                                     action:@selector(executeKeyFrameAnimation)
                           forControlEvents:UIControlEventTouchUpInside];
    
    [self.pathAnimationButton addTarget:self
                                action:@selector(executePathAnimation)
                      forControlEvents:UIControlEventTouchUpInside];
    
    [self.shakeAnimationButton addTarget:self
                                  action:@selector(executeShakeAnimation)
                        forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - delegate
#pragma mark CAKeyFrameAnimationDelegate
- (void)animationDidStart:(CAAnimation *)anim {
    NSLog(@"animation start");
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"animation end");
}

#pragma mark - event response
- (void)executeKeyFrameAnimation {
    CAKeyframeAnimation *animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *value01 = [NSValue valueWithCGPoint:CGPointMake(0,SCREEN_HEIGHT/2 - 50)];
    NSValue *value02 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3,SCREEN_HEIGHT/2 - 50)];
    NSValue *value03 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3,SCREEN_HEIGHT/2 + 50)];
    NSValue *value04 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3,SCREEN_HEIGHT/2 + 50)];
    NSValue *value05 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3,SCREEN_HEIGHT/2 - 50)];
    NSValue *value06 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH,SCREEN_HEIGHT/2 - 50)];
    animation.values = @[value01, value02, value03, value04, value05, value06];
    animation.duration = 2.0f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.delegate = self;
    [self.animationView.layer addAnimation:animation forKey:@"keyFrameAnimation"];
}

- (void)executePathAnimation {
    CAKeyframeAnimation *animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    UIBezierPath *path;
    path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(SCREEN_WIDTH/2 - 100, SCREEN_HEIGHT/2 - 150, 200, 200)];
    animation.path = path.CGPath;
    animation.duration = 2.0f;
    [self.animationView.layer addAnimation:animation forKey:@"pathAnimation"];
}

- (void)executeShakeAnimation {
    CAKeyframeAnimation *animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    NSValue *value01 = @(-M_PI/180*4);
    NSValue *value02 = @(M_PI/180*4);
    NSValue *value03 = @(-M_PI/180*4);
    animation.values = @[value01, value02, value03];
    animation.repeatCount = 4;
    [self.animationView.layer addAnimation:animation forKey:@"shakeAnimation"];
}

#pragma mark - getter and setter
- (UIView *)animationView {
    if (_animationView) {
        return _animationView;
    }
    _animationView = [[UIView alloc] init];
    _animationView.backgroundColor = [UIColor redColor];
    return _animationView;
}

- (UIButton *)keyFrameAnimationButton {
    if (_keyFrameAnimationButton) {
        return _keyFrameAnimationButton;
    }
    _keyFrameAnimationButton = [UIButton grayButtonWithTitle:@"关键帧"];
    return _keyFrameAnimationButton;
}

- (UIButton *)pathAnimationButton {
    if (_pathAnimationButton) {
        return _pathAnimationButton;
    }
    _pathAnimationButton = [UIButton grayButtonWithTitle:@"路径"];
    return _pathAnimationButton;
}

- (UIButton *)shakeAnimationButton {
    if (_shakeAnimationButton) {
        return _shakeAnimationButton;
    }
    _shakeAnimationButton = [UIButton grayButtonWithTitle:@"抖动"];
    return _shakeAnimationButton;
}

@end
