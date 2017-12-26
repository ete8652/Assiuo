//
//  AppDelegate.m
//  SakuraFly
//
//  Created by Chenglin on 15-10-1.
//  Copyright (c) 2015年 Chenglin. All rights reserved.
//

#import "AppDelegate.h"
#import "InitialViewController.h"
#import <AVFoundation/AVFoundation.h>
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    InitialViewController *mainViewCon = [[InitialViewController alloc] init];
    self.window.rootViewController = mainViewCon;
    [self.window makeKeyAndVisible];
    [self currentDateWithFormat:[NSString stringWithFormat:@"%@",[NSDate date]]];
//    CGFloat data =[self diskOfAllSizeMBytes];
//    NSLog(@"%f",data);
    
    return YES;
}
//format: @"yyyy-MM-dd HH:mm:ss"
- (void)currentDateWithFormat:(NSString *)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
}
- (CGFloat)diskOfAllSizeMBytes{
    CGFloat size = 0.0;
    NSError *error;
    NSDictionary *dic = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) {
#ifdef DEBUG
        NSLog(@"error: %@", error.localizedDescription);
#endif
    }else{
        NSNumber *number = [dic objectForKey:NSFileSystemSize];
        size = [number floatValue]/1024/1024;
    }
    return size;
}

- (void)fileSizeAtPath:(NSString *)filePath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePath]) return;
    [[fileManager attributesOfItemAtPath:filePath error:nil] fileSize];
}

- (UIVisualEffectView *)effectViewWithFrame:(CGRect)frame{
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = frame;
    return effectView;
}

- (UIView *)createDashedLineWithFrame:(CGRect)lineFrame
                           lineLength:(int)length
                          lineSpacing:(int)spacing
                            lineColor:(UIColor *)color{
    UIView *dashedLine = [[UIView alloc] initWithFrame:lineFrame];
    dashedLine.backgroundColor = [UIColor clearColor];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:dashedLine.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(dashedLine.frame) / 2, CGRectGetHeight(dashedLine.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    [shapeLayer setStrokeColor:color.CGColor];
    [shapeLayer setLineWidth:CGRectGetHeight(dashedLine.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:length], [NSNumber numberWithInt:spacing], nil]];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(dashedLine.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    [dashedLine.layer addSublayer:shapeLayer];
    return dashedLine;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    NSURLCache * cache = [NSURLCache sharedURLCache];
    
    [cache removeAllCachedResponses];
    
    [cache setDiskCapacity:0];
    
    [cache setMemoryCapacity:0];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
