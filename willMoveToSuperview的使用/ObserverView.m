//
//  ObserverView.m
//  willMoveToSuperview的使用
//
//  Created by Qson on 2018/8/24.
//  Copyright © 2018年 Qson. All rights reserved.
//

#import "ObserverView.h"
#import "QSLabel.h"

@interface ObserverView ()
@property (nonatomic, weak) QSLabel *label;
@property (nonatomic, weak) UIButton *button;
@end

@implementation ObserverView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self label];
        [self button];
        _clickCount = 0;
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    self.label.frame = CGRectMake(0, 0, 50, 50);
    self.button.frame = CGRectMake(60, 0, 50, 50);
}

- (void)buttonDidClick
{
    self.clickCount = self.clickCount + 1;
}

- (QSLabel *)label
{
    if(_label == nil) {
        QSLabel *label = [[QSLabel alloc] init];
        label.backgroundColor = [UIColor orangeColor];
        [self addSubview:label];
        _label = label;
    }
    return _label;
}

- (UIButton *)button
{
    if(_button == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [button addTarget:self action:@selector(buttonDidClick) forControlEvents:(UIControlEventTouchUpInside)];
        button.backgroundColor = [UIColor blueColor];
        [self addSubview:button];
        _button = button;
    }
    return _button;
}

@end
