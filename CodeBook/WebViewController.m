//
//  WebViewController.m
//  CodeBook
//
//  Created by Merlin on 2018/3/18.
//  Copyright © 2018年 lq. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>
#import "CodeBookHeader.h"

@interface WebViewController ()

@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation WebViewController

- (instancetype)initWithUrl:(NSString *)url
{
    self = [super init];
    if (self) {
        self = [[WebViewController alloc] init];
        self.url = url;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    
    BOOL isURL = [_url isURL];
    if (isURL) {
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    } else {
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
    }
}

- (WKWebView *)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _webView;
}

@end
