//
//  TransitionAnimationViewController.m
//  AnimationDemo
//
//  Created by 向海涛 on 16/4/29.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "TransitionAnimationViewController.h"
#import "UIButton+Customize.h"
#import "FrameTool.h"

@interface TransitionAnimationViewController ()

@property(nonatomic, strong) UIView *animationView;
@property(nonatomic, strong) UIButton *fadeButton;
@property(nonatomic, strong) UIButton *moveInButton;
@property(nonatomic, strong) UIButton *pushButton;
@property(nonatomic, strong) UIButton *revealButton;
@property(nonatomic, assign) NSInteger index;

@end

@implementation TransitionAnimationViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"过渡动画";
    [self initSubviews];
    [self setLayout];
    self.index = 1;
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
    [self.view addSubview:self.fadeButton];
    [self.view addSubview:self.moveInButton];
    [self.view addSubview:self.pushButton];
    [self.view addSubview:self.revealButton];
}

- (void)setLayout {
    CGFloat startOffset      = (CGFloat) (SCREEN_HEIGHT - 150.0);
    self.animationView.frame = CGRectMake(SCREEN_WIDTH/2-90, SCREEN_HEIGHT/2-200,180,260);
    self.fadeButton.frame    = [FrameTool frameForButtonAtIndex:0 startOffsetY:startOffset];
    self.pushButton.frame    = [FrameTool frameForButtonAtIndex:1 startOffsetY:startOffset];
    self.revealButton.frame  = [FrameTool frameForButtonAtIndex:2  startOffsetY:startOffset];
    self.moveInButton.frame  = [FrameTool frameForButtonAtIndex:3  startOffsetY:startOffset];

}

- (void)initEvents {
    [self.fadeButton addTarget:self
                        action:@selector(executeFadeTransition)
              forControlEvents:UIControlEventTouchUpInside];

    [self.pushButton addTarget:self
                        action:@selector(executePushTransition)
              forControlEvents:UIControlEventTouchUpInside];

    [self.revealButton addTarget:self
                          action:@selector(executeRevealTransition)
                forControlEvents:UIControlEventTouchUpInside];

    [self.moveInButton addTarget:self
                          action:@selector(executeMoveInTransition)
                forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - delegate

#pragma mark - event response

- (void)executeFadeTransition {
    [self changeAnimationView:YES];
    CATransition *animation = [CATransition animation];
//    设置动画的类型
    animation.type = kCATransitionFade;
//    设置动画开始的方向
    animation.subtype = kCATransitionFromRight;
//    设置动画所用的时间
    animation.duration = 1.0f;
//    设置动画的起点
    animation.startProgress = 0.3;
//    设置动画的终点
    animation.endProgress = 0.8;
    [self.animationView.layer addAnimation:animation forKey:@"fadeAnimation"];
}

- (void)executePushTransition {
    [self changeAnimationView:YES];
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    animation.duration = 1.0f;
    [self.animationView.layer addAnimation:animation forKey:@"pushAnimation"];
}

- (void)executeRevealTransition {
    [self changeAnimationView:YES];
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionReveal;
    animation.subtype = kCATransitionFromRight;
    animation.duration = 1.0f;
    [self.animationView.layer addAnimation:animation forKey:@"revealAnimation"];
}

- (void)executeMoveInTransition {
    [self changeAnimationView:YES];
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionMoveIn;
    animation.subtype = kCATransitionFromRight;
    animation.duration = 1.0f;
    [self.animationView.layer addAnimation:animation forKey:@"moveInAnimation"];

}

#pragma mark - private methods

- (void)changeAnimationView:(BOOL) isUp{
    if (_index > 3) {
        _index = 0;
    } else if (_index < 0) {
        _index = 3;
    }
    NSArray *colorArr = @[[UIColor redColor],
            [UIColor orangeColor],
            [UIColor magentaColor],
            [UIColor purpleColor]];
    self.animationView.backgroundColor = (UIColor *)colorArr[_index];

    if (isUp) {
        _index++;
    } else {
        _index--;
    }
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

- (UIButton *)fadeButton {
    if (_fadeButton) {
        return _fadeButton;
    }
    _fadeButton = [UIButton grayButtonWithTitle:@"fade"];
    return _fadeButton;
}

- (UIButton *)moveInButton {
    if (_moveInButton) {
        return _moveInButton;
    }
    _moveInButton = [UIButton grayButtonWithTitle:@"moveIn"];
    return _moveInButton;
}

- (UIButton *)pushButton {
    if (_pushButton) {
        return _pushButton;
    }
    _pushButton = [UIButton grayButtonWithTitle:@"push"];
    return _pushButton;
}

- (UIButton *)revealButton {
    if (_revealButton) {
        return _revealButton;
    }
    _revealButton = [UIButton grayButtonWithTitle:@"reveal"];
    return _revealButton;
}


@end
