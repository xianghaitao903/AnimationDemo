//
//  GroupAnimationViewController.m
//  AnimationDemo
//
//  Created by 向海涛 on 16/4/28.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "GroupAnimationViewController.h"
#import "FrameTool.h"
#import "UIButton+Customize.h"

@interface GroupAnimationViewController ()

@property (strong, nonatomic) UIView *animationView;
@property (strong, nonatomic) UIButton *asyncAnimationButton;
@property (strong, nonatomic) UIButton *syncAnimationButton;
@property (strong, nonatomic) CAKeyframeAnimation *keyframeAnimation;
@property (strong, nonatomic) CABasicAnimation *scaleAnimation;
@property (strong, nonatomic) CABasicAnimation *revolveAnimation;



@end

@implementation GroupAnimationViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"动画组";
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
    [self.view addSubview:self.asyncAnimationButton];
    [self.view addSubview:self.syncAnimationButton];
}

- (void)setLayout {
    CGFloat startOffset             = (CGFloat) (SCREEN_HEIGHT - 150.0);
    self.animationView.frame        = CGRectMake(10.0,180.0,50.0,50.0);
    self.asyncAnimationButton.frame = [FrameTool frameForButtonAtIndex:0 startOffsetY:startOffset];
    self.syncAnimationButton.frame  = [FrameTool frameForButtonAtIndex:1 startOffsetY:startOffset];
}

- (void)initEvents {
    [self.asyncAnimationButton addTarget:self
                                     action:@selector(executeAsyncAnimation)
                           forControlEvents:UIControlEventTouchUpInside];

    [self.syncAnimationButton addTarget:self
                                 action:@selector(executeSyncAnimation)
                       forControlEvents:UIControlEventTouchUpInside];

}

#pragma mark - delegate

#pragma mark - event response
- (void)executeAsyncAnimation {
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[self.keyframeAnimation, self.scaleAnimation, self.revolveAnimation];
    groupAnimation.duration = 4.0f;
    [self.animationView.layer addAnimation:groupAnimation forKey:@"asyncGrounAnimation"];
}

- (void)executeSyncAnimation {
    CFTimeInterval currentTime = CACurrentMediaTime();
    [self addAnimation:self.keyframeAnimation
                toView:self.animationView
              beginTime:currentTime
         animationName:@"keyframeAnimation"];

    [self addAnimation:self.scaleAnimation
                toView:self.animationView
              beginTime:(currentTime + 1.0)
         animationName:@"scaleAnimation"];

    [self addAnimation:self.revolveAnimation
                toView:self.animationView
              beginTime:(currentTime + 2.0)
         animationName:@"revolveAnimation"];

}

#pragma mark - private methods
- (void)addAnimation:(CAAnimation *)animation 
              toView:(UIView *)view
            beginTime:(CFTimeInterval) beginTime
       animationName:(NSString *)animationName{
    animation.beginTime = beginTime;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.duration = 1.0f;
    [view.layer addAnimation:animation forKey:animationName];
}

#pragma mark - getter and setter
- (UIButton *)asyncAnimationButton {
    if (_asyncAnimationButton) {
        return _asyncAnimationButton;
    }
    _asyncAnimationButton = [UIButton grayButtonWithTitle:@"同时"];
    return _asyncAnimationButton;
}

- (UIView *)animationView {
    if (_animationView) {
        return _animationView;
    }
    _animationView = [[UIView alloc] init];
    _animationView.backgroundColor = [UIColor redColor];
    return _animationView;
}

- (UIButton *)syncAnimationButton {
    if (_syncAnimationButton) {
        return _syncAnimationButton;
    }
    _syncAnimationButton = [UIButton grayButtonWithTitle:@"连续"];
    return _syncAnimationButton;
}

- (CAKeyframeAnimation *)keyframeAnimation {
    _keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *value01 = [NSValue valueWithCGPoint:CGPointMake(0,SCREEN_HEIGHT/2 - 50)];
    NSValue *value02 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3,SCREEN_HEIGHT/2 - 50)];
    NSValue *value03 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3,SCREEN_HEIGHT/2 + 50)];
    NSValue *value04 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3,SCREEN_HEIGHT/2 + 50)];
    NSValue *value05 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3,SCREEN_HEIGHT/2 - 50)];
    NSValue *value06 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH,SCREEN_HEIGHT/2 - 50)];
    _keyframeAnimation.values = @[value01, value02, value03, value04, value05, value06];
    return _keyframeAnimation;
}

- (CABasicAnimation *)scaleAnimation {
    _scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    _scaleAnimation.fromValue = @1.0;
    _scaleAnimation.toValue = @2.0;
    return _scaleAnimation;
}

- (CABasicAnimation *)revolveAnimation {
    _revolveAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    _revolveAnimation.toValue = @(M_PI*4);
    return _revolveAnimation;
}

@end
