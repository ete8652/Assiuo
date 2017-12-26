//
//  PushViewController.m
//  Sakura Fly
//
//  Created by 文成 on 2017/12/19.
//  Copyright © 2017年 Chenglin. All rights reserved.
//

#import "PushViewController.h"

@interface PushViewController ()

@end

@implementation PushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-show
-(void)showCome {
    self.view.frame = [UIScreen mainScreen].bounds;
    [[UIApplication sharedApplication].keyWindow.rootViewController addChildViewController:self];
    [[UIApplication sharedApplication].keyWindow addSubview:self.view];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    });
    
}

@end
