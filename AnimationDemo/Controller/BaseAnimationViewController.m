//
// Created by 向海涛 on 16/4/26.
// Copyright (c) 2016 xiang. All rights reserved.
//

#import "BaseAnimationViewController.h"
#import "UIButton+Customize.h"

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
@interface BaseAnimationViewController()

@property (strong, nonatomic) UIView *animationView;
@property (strong, nonatomic) UIButton *moveAnimationButton;
@property (strong, nonatomic) UIButton *alphaAnimationButton;
@property (strong, nonatomic) UIButton *scaleAnimationButton;
@property (strong, nonatomic) UIButton *revolveAnimationButton;
@property (strong, nonatomic) UIButton *colorAnimationButton;

@end

@implementation BaseAnimationViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"基础动画";
    [self initSubviews];
    [self setLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self initEvent];
}

#pragma mark - initialize event
- (void)initSubviews {
    [self.view addSubview:self.animationView];
    [self.view addSubview:self.moveAnimationButton];
    [self.view addSubview:self.alphaAnimationButton];
    [self.view addSubview:self.scaleAnimationButton];
    [self.view addSubview:self.revolveAnimationButton];
    [self.view addSubview:self.colorAnimationButton];
}

- (void)setLayout {
    self.animationView.frame          = CGRectMake(10.0,180.0,50.0,50.0);
    self.moveAnimationButton.frame    = [self frameForButtonAtIndex:0];
    self.alphaAnimationButton.frame   = [self frameForButtonAtIndex:1];
    self.scaleAnimationButton.frame   = [self frameForButtonAtIndex:2];
    self.revolveAnimationButton.frame = [self frameForButtonAtIndex:3];
    self.colorAnimationButton.frame   = [self frameForButtonAtIndex:4];
}

- (void)initEvent {
    [self.moveAnimationButton addTarget:self
                                 action:@selector(executeMoveAnimation)
                       forControlEvents:UIControlEventTouchUpInside];
    
    [self.alphaAnimationButton addTarget:self
                                  action:@selector(executeAlphaAnimation)
                        forControlEvents:UIControlEventTouchUpInside];
    
    [self.scaleAnimationButton addTarget:self
                                  action:@selector(executeScaleAnimation)
                        forControlEvents:UIControlEventTouchUpInside];
    
    [self.revolveAnimationButton addTarget:self
                                    action:@selector(executeRevolveAnimation)
                          forControlEvents:UIControlEventTouchUpInside];
    
    [self.colorAnimationButton addTarget:self
                                  action:@selector(executeColorAnimation)
                        forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - event response
- (void)executeMoveAnimation {
    self.animationView.frame = CGRectMake(10,180,50,50);
    [UIView animateWithDuration:1.0f animations:^{
         self.animationView.frame = CGRectMake((CGFloat) (SCREEN_WIDTH - 50.0),180.0,50.0,50.0);
    } completion:^(BOOL finished) {
        self.animationView.frame = CGRectMake((CGFloat) (SCREEN_WIDTH/2 - 25.0),180.0,50.0,50.0);
    }];
}

- (void)executeAlphaAnimation {
    self.animationView.alpha = 1.0f;
    [UIView beginAnimations:@"alphaAnimation" context:nil];
    [UIView setAnimationDuration:1.0f];
    self.animationView.alpha = 0.5f;
    [UIView commitAnimations];
}

- (void)executeScaleAnimation {
    CABasicAnimation *animation;
    animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.toValue = @2.0f;
    animation.duration = 1.0f;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [self.animationView.layer addAnimation:animation forKey:@"scaleAnimation"];
}

- (void)executeRevolveAnimation {
    CABasicAnimation *animation;
    animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.toValue = @(M_PI * 3);
    animation.duration = 2.0f;
    [self.animationView.layer addAnimation:animation forKey:@"revolveAnimation"];

}

- (void)executeColorAnimation {
    self.animationView.alpha = 1.0f;
    CABasicAnimation *animation;
    animation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    animation.toValue = (id) [UIColor blueColor].CGColor;
    animation.duration = 1.0f;
    [self.animationView.layer addAnimation:animation forKey:@"colorAnimation"];

}

#pragma mark - private methods
- (CGRect)frameForButtonAtIndex:(NSInteger )index {
    CGFloat offsetY = (CGFloat) (SCREEN_HEIGHT - 150.0);
    CGFloat width = 50.0f;
    CGFloat height = 44.0f;
    NSInteger totalButtonAtLine = (NSInteger) (SCREEN_WIDTH/(width + 10));
    CGFloat offsetX = 10 + (10 + width) * (index%totalButtonAtLine);
    offsetY += 10 + height * (index/totalButtonAtLine);
    return CGRectMake(offsetX,offsetY,width,height);
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

- (UIButton *)moveAnimationButton {
    if (_moveAnimationButton) {
        return _moveAnimationButton;
    }
    _moveAnimationButton = [UIButton grayButtonWithTitle:@"位移"];
    return _moveAnimationButton;
}

- (UIButton *)alphaAnimationButton {
    if (_alphaAnimationButton) {
        return _alphaAnimationButton;
    }
    _alphaAnimationButton = [UIButton grayButtonWithTitle:@"透明度"];
    return _alphaAnimationButton;
}

- (UIButton *)scaleAnimationButton {
    if (_scaleAnimationButton) {
        return _scaleAnimationButton;
    }
    _scaleAnimationButton =  [UIButton grayButtonWithTitle:@"放缩"];
    return _scaleAnimationButton;
}

- (UIButton *)revolveAnimationButton {
    if (_revolveAnimationButton) {
        return _revolveAnimationButton;
    }
    _revolveAnimationButton = [UIButton grayButtonWithTitle:@"旋转"];
    return _revolveAnimationButton;
}

- (UIButton *)colorAnimationButton {
    if (_colorAnimationButton) {
        return _colorAnimationButton;
    }
    _colorAnimationButton = [UIButton grayButtonWithTitle:@"颜色"];
    return _colorAnimationButton;
}


@end