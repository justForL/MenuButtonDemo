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

- (void)setupButtons {
    for (int i = 0; i<4; i++) {
        UIButton *button = [[UIButton alloc]init];
        button.tag = i;
        button.frame = self.frame;
//        button.hidden = YES;
//        button.alpha = 0;
        button.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
        
        button.layer.cornerRadius = 25;
        button.layer.masksToBounds = YES;
        [self.superview addSubview:button];
        [button addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonArray addObject:button];
    }
    [self.superview bringSubviewToFront:self];
}
+ (instancetype)creatMenuButton {
    return [[self alloc]init];
}

- (void)didMoveToSuperview {
    [self setupButtons];
}
- (void)panActionWithGesture:(UIPanGestureRecognizer *)recognizer{
   CGPoint point = [recognizer locationInView:self.superview];
    self.center = point;
    NSLog(@"%@",NSStringFromCGPoint(point));
    for (UIButton *button in self.buttonArray) {
        button.frame = self.frame;
    }
    
    
}

- (void)buttonClick:(UIButton *)sender {
    NSLog(@"%s",__func__);
    CGFloat margin = 70;
    for (int i = 0; i< self.buttonArray.count; i++) {
        UIButton *button = self.buttonArray[i];
        if (i == 0) {
            button.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y - margin, button.frame.size.width, button.frame.size.height);
        }else {
            UIButton *prebutton = self.buttonArray[i-1];
            button.frame = CGRectMake(button.frame.origin.x, prebutton.frame.origin.y - margin, button.frame.size.width, button.frame.size.height);
        }
    }
}
- (void)backButtonClick:(UIButton *)sender {
    if (self.clickBlock) {
        self.clickBlock(sender.tag);
    }
}

- (NSMutableArray *)buttonArray {
    if (_buttonArray == nil) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}
@end
