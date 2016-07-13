//
//  MenuButton.h
//  MenuButton
//
//  Created by ghy on 16/7/13.
//  Copyright © 2016年 lj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuButton : UIButton
@property (nonatomic, copy) void (^clickBlock)(NSInteger integer);
@property (nonatomic, strong) NSArray<UIImage *> *imageArray;

+ (instancetype)creatMenuButton;
@end
