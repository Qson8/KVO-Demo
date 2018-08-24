//
//  TestViewController.m
//  willMoveToSuperview的使用
//
//  Created by Qson on 2018/8/24.
//  Copyright © 2018年 Qson. All rights reserved.
//

#import "TestViewController.h"
#import "ObserverView.h"

@interface TestViewController ()

@end

// 理解iOS中willMoveToSuperview:方法调用逻辑和时机

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor lightTextColor];
    
    ObserverView *view = [[ObserverView alloc] init];
    view.frame = CGRectMake(50, 100, [UIScreen mainScreen].bounds.size.width - 2 * 50, 100);
    [self.view addSubview:view];
    
    UIButton *testBtn = [[UIButton alloc] init];
    [testBtn setTitle:@"关闭测试" forState:(UIControlStateNormal)];
    [testBtn setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
    [testBtn addTarget:self action:@selector(closeBtn) forControlEvents:(UIControlEventTouchUpInside)];
    testBtn.frame = CGRectMake(50, 50, 100, 50);
    [self.view addSubview:testBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)closeBtn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
