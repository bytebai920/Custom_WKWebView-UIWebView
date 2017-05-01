//
//  UIWebViewController.m
//  WKWebView
//
//  Created by 饼饼白 on 2017/5/1.
//  Copyright © 2017年 饼饼白. All rights reserved.
//

#import "UIWebViewController.h"
#import "BYBUIWebView.h"

@interface UIWebViewController ()<BYBUIWebViewDelegate>

@property(nonatomic, strong)BYBUIWebView *bybUIwebView;

@end

@implementation UIWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    BYBUIWebView *bybUIwebView = [[BYBUIWebView alloc] initWithDelegate:self];
    self.bybUIwebView = bybUIwebView;
    [bybUIwebView startTestWithUrl:@"http://www.qq.com"];

}

- (UIView *)BYBUIWebViewStartLoad:(BYBUIWebView *)webView
{
    return self.view;
}


- (void)BYBUIWebVIewFinished:(BYBUIWebView *)webView
{
    
}

- (void)BYBUIWebView:(BYBUIWebView *)webView progress:(float)progress title:(NSString *)title;
{
    
}

- (void)BYBUIWebView:(BYBUIWebView *)webView Failed:(NSError *)error
{
    
}



@end
