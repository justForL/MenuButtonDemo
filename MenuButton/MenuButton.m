//
//  MenuButton.m
//  MenuButton
//
//  Created by ghy on 16/7/13.
//  Copyright © 2016年 lj. All rights reserved.
//

#import "MenuButton.h"
#define kScreen [UIScreen mainScreen].bounds

@interface MenuButton ()
@property (nonatomic, strong) NSMutableArray *buttonArray;

@end

@implementation MenuButton
#pragma mark - 初始化
- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor redColor];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panActionWithGesture:)];
        self.frame = CGRectMake(kScreen.size.width - 100, kScreen.size.height-100, 50, 50);
        self.layer.cornerRadius = 25;
        self.layer.masksToBounds = YES;
        [self addGestureRecognizer:pan];
        [self addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
#pragma mark - 创建内部button
- (void)setupButtons {
    for (int i = 0; i<4; i++) {
        UIButton *button = [[UIButton alloc]init];
        button.tag = i;
        button.frame = self.frame;
        button.hidden = YES;
        button.alpha = 0;
        button.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
        
        button.layer.cornerRadius = 25;
        button.layer.masksToBounds = YES;
        [self.superview addSubview:button];
        [button addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonArray addObject:button];
    }
    [self.superview bringSubviewToFront:self];
}
#pragma mark - 暴露在外的初始化类方法
+ (instancetype)creatMenuButton {
    return [[self alloc]init];
}
#pragma mark - 圆形按钮已经显示到父视图调用的方法
- (void)didMoveToSuperview {
    [self setupButtons];
}
#pragma mark - 拖拽按钮的事件
- (void)panActionWithGesture:(UIPanGestureRecognizer *)recognizer{
   CGPoint point = [recognizer locationInView:self.superview];
    NSLog(@"%@",NSStringFromCGPoint(point));
        self.center = point;
        for (UIButton *button in self.buttonArray) {
                button.frame = self.frame;
                button.alpha = 0;
                button.hidden = YES;
        }
}
#pragma mark - 前置红色按钮点击事件
- (void)buttonClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self openButtonState];
    }else {
        [self closeButonOpenState];
    }
    
}
#pragma mark - 后置按钮的打开状态
- (void)openButtonState {
    CGFloat margin = 70;
    for (int i = 0; i< self.buttonArray.count; i++) {
        UIButton *button = self.buttonArray[i];
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            button.hidden = NO;
            button.alpha = 1;
            if (i == 0) {
                button.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y - margin, button.frame.size.width, button.frame.size.height);
            }else {
                UIButton *prebutton = self.buttonArray[i-1];
                button.frame = CGRectMake(button.frame.origin.x, prebutton.frame.origin.y - margin, button.frame.size.width, button.frame.size.height);
            }
        } completion:^(BOOL finished) {
            
        }];
    }
}
#pragma mark - 后置按钮的关闭状态
- (void)closeButonOpenState {
    [UIView animateWithDuration:0.25 animations:^{
        for (UIButton *button in self.buttonArray) {
            
            button.frame = self.frame;
        }
    } completion:^(BOOL finished) {
        for (UIButton *button in self.buttonArray) {
            button.hidden = YES;
            button.alpha = 0;
        }
    }];
}
#pragma mark - 后置按钮的点击事件
- (void)backButtonClick:(UIButton *)sender {
    if (self.clickBlock) {
        self.clickBlock(sender.tag);
        [self closeButonOpenState];
    }
}
#pragma mark - lazyLoad用于缓存所有后置按钮
- (NSMutableArray *)buttonArray {
    if (_buttonArray == nil) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}
@end
