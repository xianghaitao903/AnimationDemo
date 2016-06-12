//
//  ViewController.m
//  AnimationDemo
//
//  Created by 向海涛 on 16/4/26.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "ViewController.h"
#import "BaseAnimationViewController.h"
#import "KeyFrameAnimationViewController.h"
#import "GroupAnimationViewController.h"
#import "TransitionAnimationViewController.h"

@interface ViewController () <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *dataArr;

@end

@implementation ViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"动画";
    self.view = self.tableView;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableviewDataSuorce

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] init];
    }
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}

#pragma mark - tableviewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:[BaseAnimationViewController new]
                                                 animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:[KeyFrameAnimationViewController new]
                                                 animated:YES];
            break;
        case 2:
            [self.navigationController pushViewController:[GroupAnimationViewController new]
                                                 animated:YES];
            break;
        case 3:
            [self.navigationController pushViewController:[TransitionAnimationViewController new]
                                                 animated:YES];
            break;
        default:
            break;
    }

}

#pragma mark - getter and setter

- (UITableView *)tableView {
    if (_tableView) {
        return _tableView;
    }
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor whiteColor];
    tableView.tableFooterView = footerView;
    _tableView = tableView;
    return _tableView;
}

- (NSArray *)dataArr {
    if (_dataArr) {
        return _dataArr;
    }
    _dataArr = @[@"CABaseAnimation",@"CAKeyframeAnimation",@"CAAnimationGroup",@"CATransition"];
    return _dataArr;
}

@end
