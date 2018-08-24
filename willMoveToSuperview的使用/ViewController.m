//
//  ViewController.m
//  willMoveToSuperview的使用
//
//  Created by Qson on 2018/8/24.
//  Copyright © 2018年 Qson. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *testBtn = [[UIButton alloc] init];
    [testBtn setTitle:@"启动测试" forState:(UIControlStateNormal)];
    [testBtn setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
    [testBtn addTarget:self action:@selector(actionBtn) forControlEvents:(UIControlEventTouchUpInside)];
    testBtn.frame = CGRectMake(50, 50, 100, 50);
    [self.view addSubview:testBtn];
}

#pragma mark - action
- (void)actionBtn
{
    TestViewController *vc = [[TestViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
