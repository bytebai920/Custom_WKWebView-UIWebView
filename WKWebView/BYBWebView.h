//
//  BYBWebView.h
//  WKWebView
//
//  Created by 饼饼白 on 2017/4/16.
//  Copyright © 2017年 饼饼白. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@protocol  BYBWebViewDelegate;

@interface BYBWebView : WKWebView
//@interface BYBWebView : UIWebView<UIWebViewDelegate>

@property(nonatomic, weak)id<BYBWebViewDelegate>bybWebDelegate;

- (instancetype)initBYBWebViewDelegate:(id<BYBWebViewDelegate>)delegate configuration:(WKWebViewConfiguration *)configuration;

- (void)startTestWithUrl:(NSString *)urlStr;

@end

@protocol BYBWebViewDelegate <NSObject>

@optional

- (UIView *)BYBWebViewStartLoad:(BYBWebView *)webView;

- (void)BYBWebVIewFinished:(BYBWebView *)webView;

- (void)BYBWebView:(BYBWebView *)webView progress:(float)progress title:(NSString *)title;

- (void)BYBWebView:(BYBWebView *)webView Failed:(NSError *)error;

@end
