//
//  ViewController.m
//  MenuButton
//
//  Created by ghy on 16/7/13.
//  Copyright © 2016年 lj. All rights reserved.
//

#import "ViewController.h"
#import "MenuButton.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor lightGrayColor];
    MenuButton *menuButton = [MenuButton creatMenuButton];
    [self.view addSubview:menuButton];
    
    menuButton.clickBlock = ^(NSInteger integer){
        NSLog(@"%zd",integer);
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
