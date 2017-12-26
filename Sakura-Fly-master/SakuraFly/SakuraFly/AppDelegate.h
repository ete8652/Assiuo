//
//  AppDelegate.h
//  SakuraFly
//
//  Created by Chenglin on 15-10-1.
//  Copyright (c) 2015年 Chenglin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong)UIAlertController  *alert;

@property (nonatomic,assign)BOOL isNetworking;

- (void)currentDateWithFormat:(NSString *)format;

- (CGFloat)diskOfAllSizeMBytes;

@end
