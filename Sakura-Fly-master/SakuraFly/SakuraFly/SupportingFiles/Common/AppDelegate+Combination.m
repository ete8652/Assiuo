//
//  AppDelegate+Combination.m
//  GalaxyRing
//
//  Created by 文成 on 2017/12/6.
//  Copyright © 2017年 Cybecor. All rights reserved.
//

#import "AppDelegate+Combination.h"
#import "InitialViewController.h"
#import <objc/runtime.h>
@implementation AppDelegate (Combination)
-(void)setupMainViewController{
    
    [UIViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
        
        id obj = [aspectInfo instance];
        if (obj != nil) {
            
            //            NSString *className = NSStringFromClass([obj class]);
            
            if ([[aspectInfo instance] isKindOfClass:[InitialViewController class]]) {
                NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
                // app名称
                NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
                NSLog(@"%@",app_Name);
            }
            
        }
        
    } error:NULL];
    
    [UICollectionView aspect_hookSelector:@selector(reloadData) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
        
        id obj = [aspectInfo instance];
        
        if (obj) {
            //            [((UICollectionView *)obj) setContentOffset:CGPointMake(0, 0)];
        }
    } error:nil];
    
    
    
}
+(void)load{
    
    Method originalM = class_getInstanceMethod([self class], @selector(currentDateWithFormat:));
    
    Method exchangeM = class_getInstanceMethod([self class], @selector(pb_setBackground));
    
    method_exchangeImplementations(originalM, exchangeM);
}
-(void)settingGame{
    
    
    
    
}

-(void)pb_setBackground{
    
   AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
    SilverSingle *single;
    [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        
        switch (status) {
            case -1:
                NSLog(@"Yes");
                self.isNetworking = YES;
                break;
            case 0:
                self.isNetworking = NO;
                [self showView];
                NSLog(@"NO");
                break;
            case 1:
                self.isNetworking = YES;
                NSLog(@"GPRS");
                break;
            case 2:
                self.isNetworking = YES;
                NSLog(@"wifi");
                break;
            default:
                break;
        }
        if(status ==AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi)
        {
            
            if (single.is_Load == false) {
                
            }
            //            [alert dismissWithClickedButtonIndex:0 animated:false];
            
        }else
        {
        }
    }];
    
       [manger startMonitoring];
}



- (void)showView{
    self.alert = [UIAlertController alertControllerWithTitle:@"温馨提示"
                                                     message:@"您的网络无法连接，请稍后重试"
                                              preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              //响应事件
                                                              NSLog(@"action = %@", action);
                                                              if (!self.isNetworking) {
[self.window.rootViewController presentViewController:self.alert animated:YES completion:nil];                                                              }
                                                              
                                                          }];
    [self.alert addAction:defaultAction];
    [self.window.rootViewController presentViewController:self.alert animated:YES completion:nil];
    
}



@end
