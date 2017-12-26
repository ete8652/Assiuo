//
//  BackgroundViewController.m
//  BingoLottery
//
//  Created by win on 2017/5/15.
//  Copyright © 2017年 bingo. All rights reserved.
//

#import "BackgroundViewController.h"
#import <WebKit/WebKit.h>
#import "SilverSingle.h"

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height


@interface BackgroundViewController ()<WKUIDelegate,WKNavigationDelegate,UIScrollViewDelegate>
{
    
    SilverSingle *single;
    BOOL isSelect;
}
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIView *shareView;
@property (nonatomic, strong) UIButton *topBtn;
@property (nonatomic, strong) UIButton *midBtn;
@property (nonatomic, strong) UIButton *bottomBtn;
@end

@implementation BackgroundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createWebView];
    [self createShareView];
    
    isSelect = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(screenRotate:animation:) name:@"UIWindowWillRotateNotification" object:nil];
}


-(void)createWebView{
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 20,SCREEN_WIDTH,SCREEN_HEIGHT - 20)];
    
    self.webView.UIDelegate = self;
    self.webView.allowsBackForwardNavigationGestures = YES;
    //self.webView.backgroundColor = [UIColor blackColor];
    self.webView.navigationDelegate = self;
    self.webView.scrollView.delegate = self;
    //[self.webView.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_webUrl]];
    NSLog(@"uuuu = %@",_webUrl);
    [self.webView loadRequest:request];
    //self.webView.suppressesIncrementalRendering = NO;
    [self.view addSubview:self.webView];
    

    // Do any additional setup after loading the view.
    
    //    _HUD = [[MBProgressHUD alloc] init];
    //    [_HUD hide:YES];
    //    [self.view addSubview:_HUD];
    
    single = [SilverSingle alloc];
    
    
}
-(void)dealloc{
    
    //[self.webView.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    //NSLog(@"%f", self.webView.scrollView.contentOffset.y);
}

#pragma mark - UIScrollViewDelegate
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//
//    self.shareView.hidden = YES;
//    self.webView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//}
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//
//    self.webView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49);
//}
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//
//    self.webView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49);
//}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    //    self.statusView.hidden = NO;
    //    self.webView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49);
    //    NSLog(@"2");
}


-(void)createShareView{
    
    if (!self.shareView) {
        self.shareView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-150, SCREEN_HEIGHT-49-100, 150, 100)];
        self.shareView.backgroundColor = [UIColor colorWithRed:30/255.0 green:30/255.0 blue:30/255.0 alpha:0.95];
        self.shareView.layer.cornerRadius = 5.0;
        self.shareView.layer.masksToBounds = YES;
        self.shareView.layer.borderColor = [UIColor whiteColor].CGColor;
        self.shareView.layer.borderWidth = .5;
        self.shareView.hidden = YES;
        [self.view addSubview:self.shareView];
    }
    
    
    if (isSelect) {
        self.shareView.hidden = NO;
    }else{
        self.shareView.hidden = YES;
    }
    
    //createBtn
    if (!self.topBtn) {
        self.topBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
        self.topBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        self.topBtn.layer.borderWidth = .5;
        [self.topBtn setTitle:@"分享" forState:UIControlStateNormal];
        [self.topBtn setImage:[UIImage imageNamed:@"分享"] forState:UIControlStateNormal];
        [self.topBtn setImageEdgeInsets:UIEdgeInsetsMake(15, 43, 15, 80)];
        [self.topBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -45, 0, 0)];
        [self.topBtn addTarget:self action:@selector(topBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.shareView addSubview:self.topBtn];
        
        
        self.bottomBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 150, 50)];
        self.bottomBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        self.bottomBtn.layer.borderWidth = .5;
        [self.bottomBtn setTitle:@"清除缓存" forState:UIControlStateNormal];
        [self.bottomBtn setImage:[UIImage imageNamed:@"扫把"] forState:UIControlStateNormal];
        [self.bottomBtn setImageEdgeInsets:UIEdgeInsetsMake(15, 20, 15, 100)];
        [self.bottomBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -55, 0, 0)];
        [self.bottomBtn addTarget:self action:@selector(bottomBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.shareView addSubview:self.bottomBtn];
    }
    
    
    
}

#pragma mark----wkwebviewDelegate (解决WKWebView不能跳转App Store的问题)
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    
    NSLog(@"alksjdklasjdaskldsaldsa = %@",webView.URL.absoluteString);
    
    if ([webView.URL.absoluteString hasPrefix:@"itms-appss://"]) {
        [[UIApplication sharedApplication] openURL:webView.URL];
        
    }
    
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSURL *URL = navigationAction.request.URL;
    NSString *scheme = [URL scheme];
    UIApplication *app = [UIApplication sharedApplication];
    // 打电话
    if ([scheme isEqualToString:@"tel"]) {
        if ([app canOpenURL:URL]) {
            [app openURL:URL];
            // 一定要加上这句,否则会打开新页面
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    // 打开appstore
    if ([URL.absoluteString containsString:@"itunes.apple.com"]) {
        if ([app canOpenURL:URL]) {
            [app openURL:URL];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
    
    
    //    self.statusView.hidden = NO;
    //    self.webView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49);
}


- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    
    single.is_Load = true;
    
    //    self.statusView.hidden = NO;
    //    self.webView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49);
}



- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    
    NSLog(@"error = %@",error);
    
}
- (void)screenRotate:(NSNotification *)noti animation:(BOOL)animation
{
    UIInterfaceOrientation orientation = [[noti.userInfo objectForKey:@"UIWindowNewOrientationUserInfoKey"] integerValue];
    //    if (!noti) {
    //        return;
    //    }
    //    animation = YES;
    //
    //    NSTimeInterval i = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
    //    NSTimeInterval time = 0.3 + i;
    //
    //    if (!animation) {
    //        time = 0.0;
    //    }
    switch (orientation)
    {
        case UIInterfaceOrientationPortrait:
        {
            NSLog(@"1");
            self.webView.frame = CGRectMake(0, 49, SCREEN_WIDTH, SCREEN_HEIGHT-49);
            self.webView.scrollView.delegate = self;
            
        }
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
        {
            NSLog(@"2");
        }
            break;
            
        case UIInterfaceOrientationLandscapeRight:
        {
            //            [UIView animateWithDuration:time animations:^{
            //                _userVc.view.transform = CGAffineTransformMakeRotation(M_PI_2);
            //            } completion:nil];
            //            self.webView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            //            self.webView.scrollView.delegate = nil;
            //            _statusView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 49, [UIScreen mainScreen].bounds.size.width, 49);
            NSLog(@"3");
        }
            break;
            
        case UIInterfaceOrientationLandscapeLeft:
        {
            //            [UIView animateWithDuration:time animations:^{
            //                _userVc.view.transform = CGAffineTransformMakeRotation(-M_PI_2);
            //            } completion:nil];
            
            NSLog(@"4");
            //            self.webView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            //            self.webView.scrollView.delegate = nil;
            //            _statusView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 49, [UIScreen mainScreen].bounds.size.width, 49);
        }
            break;
        default:
            break;
    }
}
- (BOOL)shouldAutorotate
{
    return YES;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end

