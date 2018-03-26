//
//  ViewController.m
//  CodeBook
//
//  Created by Merlin on 2018/3/17.
//  Copyright © 2018年 lq. All rights reserved.
//

#import <LocalAuthentication/LocalAuthentication.h>
#import "CodeBookHeader.h"
#import "ViewController.h"
#import "MainViewController.h"

@interface ViewController ()<CALayerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addHeaderLayer];
    [self addfingerPrintImageView];
    [self addTipLabel];
    [self verifyPsw];
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    CGContextSaveGState(ctx);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -100);
    
    UIImage *image = [UIImage imageNamed:@"header.jpeg"];
    CGContextDrawImage(ctx, CGRectMake(0, 0, 100, 100), image.CGImage);
    CGContextRestoreGState(ctx);
}

- (void)touchuIDVerfiy
{
    LAContext *context = [[LAContext alloc] init];
    //这个设置的使用密码的字体，当为@“”时，按钮将要被隐藏
    context.localizedFallbackTitle = @"";
    context.localizedCancelTitle = @"取消";

    NSError *error = nil;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"请验证您的指纹" reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {//验证成功
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self toMainPage];
                });
            }
        }];
    } else if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error]) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:@"请输入密码" reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self toMainPage];
                });
            }
        }];
    }
}

- (void)toMainPage
{
    MainViewController *mainVc = [[MainViewController alloc] init];
    UINavigationController *mainNav = [[UINavigationController alloc] initWithRootViewController:mainVc];
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    window.rootViewController = mainNav;
}

- (void)addHeaderLayer
{
    CALayer *headerLayer = [CALayer layer];
    headerLayer.position = CGPointMake(kScreen_w/2.0, kScreen_h/2.0 - 200.0);
    headerLayer.bounds = CGRectMake(0, 0, 100, 100);
    headerLayer.cornerRadius = 50;
    headerLayer.masksToBounds = YES;
    headerLayer.delegate = self;
    [self.view.layer addSublayer:headerLayer];
    [headerLayer setNeedsDisplay];
}

- (void)addfingerPrintImageView
{
    UIImageView *fingerPrintImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fingerprint.jpeg"]];
    fingerPrintImageView.frame = CGRectMake(kScreen_w/2.0-40, kScreen_h/2.0-40, 80, 80);
    fingerPrintImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(verifyPsw)];
    [fingerPrintImageView addGestureRecognizer:tapGesture];
    [self.view addSubview:fingerPrintImageView];
}

- (void)verifyPsw
{
    if ([UIDevice currentDevice].systemVersion.floatValue > 8.0) {//支持touchID
        [self touchuIDVerfiy];
    } else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self toMainPage];
        });
    }
}

- (void)addTipLabel
{
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kScreen_h/2.0+50, kScreen_w, 40)];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.textColor = [UIColor blueColor];
    tipLabel.text = @"点击进行指纹解锁";
    tipLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:tipLabel];
}

@end
