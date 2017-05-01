//
//  BYBUIWebView.h
//  WKWebView
//
//  Created by 饼饼白 on 2017/5/1.
//  Copyright © 2017年 饼饼白. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BYBUIWebViewDelegate;

@interface BYBUIWebView : UIWebView

@property(nonatomic, weak)id<BYBUIWebViewDelegate> bybUIWebViewDelegate;

- (instancetype)initWithDelegate:(id<BYBUIWebViewDelegate>)bybUIWebdelegate;

- (void)startTestWithUrl:(NSString *)urlStr;

@end

@protocol BYBUIWebViewDelegate <NSObject>

- (UIView *)BYBUIWebViewStartLoad:(BYBUIWebView *)webView;

- (void)BYBUIWebVIewFinished:(BYBUIWebView *)webView;

- (void)BYBUIWebView:(BYBUIWebView *)webView progress:(float)progress title:(NSString *)title;

- (void)BYBUIWebView:(BYBUIWebView *)webView Failed:(NSError *)error;

@end
