//
//  WKWebViewController.m
//  WKWebView
//
//  Created by 饼饼白 on 2017/5/1.
//  Copyright © 2017年 饼饼白. All rights reserved.
//

#import "WKWebViewController.h"
#import "BYBWebView.h"

@interface WKWebViewController ()<BYBWebViewDelegate>

@property(nonatomic,strong)BYBWebView *bybWebView;

@end

@implementation WKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    BYBWebView *bybWebView = [[BYBWebView alloc] initBYBWebViewDelegate:self configuration:nil];
    [bybWebView startTestWithUrl:@"https://www.baidu.com"];
    
}

- (UIView *)BYBWebViewStartLoad:(BYBWebView *)webView
{
    return self.view;
}

- (void)BYBWebVIewFinished:(BYBWebView *)webView
{
    
}

- (void)BYBWebView:(BYBWebView *)webView progress:(float)progress title:(NSString *)title
{
    NSLog(@"progress == %f title == %@", progress, title);
}

- (void)BYBWebView:(BYBWebView *)webView Failed:(NSError *)error
{
    
}

@end
