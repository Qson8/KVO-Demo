# KVO-Demo
通过willMoveToSuperview的来无忧的使用KVO


#### 前言
在开发中我们经常需要用到KVO，但KVO一旦使用不当，会造成致命性的问题-崩溃。

在开发中KVO尝试过很多方法来使用KVO，有init方法中添加，dealloc方法中移除，如果有问题，在搞个布尔值标记下，网上很多方法在使用中可能场景和需求不一样，效果不保险感觉。

#### 方案
今天偶尔看到MJRefresh框架在对KVO的处理，通过了解并Demo演练，发现这种方法非常不错，故此推荐给大家。

```objc
- (void)willMoveToSuperview:(UIView *)newSuperview；
```
这是系统的方法，当视图将要添加到父视图上，或将要从父视图上移除时会调用。在这个方法处理监听的添加和移除。[Demo下载]()
先上代码

```objc
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
```

####总结和注意点:
```
总结和注意点:
可在willMoveToSuperview: 添加和移除监听者
 
 1. 需要调用super willMoveToSuperview
 2. 需要先移除 监听者 removeObserver
 3. 然后在willMoveToSuperview 参数 newSuperview 有值 设置监听者 addObserver
 4. removeObserver 内如果是监听的父类，在这里必须写self.super 因为自己设置的属性指向父类，在这里属性是没值的
```



