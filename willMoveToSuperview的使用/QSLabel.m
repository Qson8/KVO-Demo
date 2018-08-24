//
//  QSLabel.m
//  willMoveToSuperview的使用
//
//  Created by Qson on 2018/8/24.
//  Copyright © 2018年 Qson. All rights reserved.
//

#import "QSLabel.h"
#import "ObserverView.h"

@interface QSLabel ()
@property (nonatomic, weak) UILabel *textlabel;
@property (nonatomic, weak, readonly) ObserverView *obView;
@end


/**
 总结: 可在willMoveToSuperview: 设置
 
 1. 需要调用super willMoveToSuperview
 2. 需要先移除 监听者 removeObserver
 3. 然后在willMoveToSuperview 参数 newSuperview 有值 设置监听者 addObserver
 4. removeObserver 内如果是监听的父类，在这里必须写self.super 因为自己设置的属性指向父类，在这里属性是没值的
 
 */

@implementation QSLabel

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textlabel.frame = self.bounds;
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    NSLog(@"%s",__func__);
    
    [self removeObserver];
    
    if(newSuperview) {
        if([newSuperview isKindOfClass:[ObserverView class]]) {
            _obView = (ObserverView *)newSuperview;
            
            [self addObserver];
        }
    }
}

- (void)addObserver
{
    NSLog(@"%s",__func__);
    
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew;
    [self.obView addObserver:self forKeyPath:@"clickCount" options:(options) context:nil];
}

- (void)removeObserver
{
    NSLog(@"%s",__func__);
    
    NSLog(@"%@  --  %@",self.obView,self.superview);
    
    /**
     ！ 切记 这里必须用self.superview
     self.obView 在这个时候已经是nill
     */
//    [self.obView removeObserver:self forKeyPath:@"clickCount"];
    [self.superview removeObserver:self forKeyPath:@"clickCount"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if([keyPath isEqualToString:@"clickCount"]) {
        self.textlabel.text = [NSString stringWithFormat:@"%ld",self.obView.clickCount];
        
    }
}

- (UILabel *)textlabel
{
    if(_textlabel == nil) {
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.textColor = [UIColor blueColor];
        [self addSubview:textLabel];
        _textlabel = textLabel;
    }
    return _textlabel;
}
@end
