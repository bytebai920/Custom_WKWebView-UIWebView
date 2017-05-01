//
//  BYBUIWebView.m
//  WKWebView
//
//  Created by 饼饼白 on 2017/5/1.
//  Copyright © 2017年 饼饼白. All rights reserved.
//

#import "BYBUIWebView.h"

@interface UIWebView ()

- (id)webView:(id)webView identifierForInitialRequest:(id)initialRequest fromDataSource:(id)dataSource;
- (void)webView:(id)webView resource:(id)resource didFinishLoadingFromDataSource:(id)dataSource;

@end


@interface BYBUIWebView ()<UIWebViewDelegate>

@property (nonatomic, strong)NSTimer *webViewTimer;

@property(nonatomic, strong)UIProgressView *progressView;

@property(nonatomic, assign)float progress;

@end

@implementation BYBUIWebView
{
    int totalCount;    ///< 总连接数
    int receivedCount; ///< 已完成连接数

}

- (instancetype)initWithDelegate:(id<BYBUIWebViewDelegate>)bybUIWebdelegate
{
    self = [super init];
    if (self) {
        [self initData];
        [self initUI];
        self.bybUIWebViewDelegate = bybUIWebdelegate;
        self.delegate = self;
    }
    
    return self;
}

- (void)initData
{
    totalCount = 0;
    receivedCount = 0;
    self.progress = 0.0;
}

- (void)initUI
{
    UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:(UIProgressViewStyleDefault)];
    self.progressView = progressView;
    progressView.trackTintColor = [UIColor whiteColor];
    progressView.progressTintColor = [UIColor cyanColor];
    
}

- (void)startTImer
{
    self.webViewTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateStatus) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.webViewTimer forMode:NSRunLoopCommonModes];
    if (![NSThread isMainThread]) {
        [[NSRunLoop currentRunLoop] run];
    }
    [self.webViewTimer fire];
}

- (void)updateStatus
{
//    self.progress = receivedCount/totalCount;
//    NSLog(@"totolCount == %d, reciedCount == %d,progress == %f", totalCount, receivedCount,self.progress);
//    
//    [self.bybUIWebViewDelegate BYBUIWebView:self progress:_progress title:@""];
}

- (void)stopTimer
{
    if ([self.webViewTimer isValid]) {
        [self.webViewTimer invalidate];
    }
}

- (void)startTestWithUrl:(NSString *)urlStr
{

    NSURL *URL = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    [self loadRequest:request];
    [self startTImer];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    if (navigationType == UIWebViewNavigationTypeOther) {
        return YES;
    }
    
    return NO;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    if (self.bybUIWebViewDelegate && [self.bybUIWebViewDelegate respondsToSelector:@selector(BYBUIWebViewStartLoad:)]) {
       UIView *view = [self.bybUIWebViewDelegate BYBUIWebViewStartLoad:self];
        self.frame = CGRectMake(0, 65, view.frame.size.width, view.frame.size.height - 65);
        [view addSubview:self];
        
        self.progressView.frame = CGRectMake(0, 64, view.frame.size.width, 1);
        [view addSubview:self.progressView];

    }
}
- (void)webViewDidFinishLoad:(UIWebView *)webView;
{
    if (totalCount > 1) {
        self.progress = 1.0;
        [self.progressView setProgress:self.progress];
        [self.bybUIWebViewDelegate BYBUIWebView:self progress:self.progress title:@""];
    }

    if (self.bybUIWebViewDelegate && [self.bybUIWebViewDelegate respondsToSelector:@selector(BYBUIWebVIewFinished:)]) {
        [self.bybUIWebViewDelegate BYBUIWebVIewFinished:self];
    }
    [self stopTimer];

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;
{
    if (self.bybUIWebViewDelegate  && [self.bybUIWebViewDelegate respondsToSelector:@selector(BYBUIWebView:Failed:)]) {
        [self.bybUIWebViewDelegate BYBUIWebView:self Failed:error];
    }
    [self stopTimer];

}

- (id)webView:(id)webView identifierForInitialRequest:(id)initialRequest fromDataSource:(id)dataSource
{
    totalCount ++;
    

    return  [NSNumber numberWithInt:totalCount];
}

- (void)webView:(id)webView resource:(id)resource didFinishLoadingFromDataSource:(id)dataSource
{
    receivedCount ++;
    
    self.progress = receivedCount/(float)totalCount;
    NSLog(@"totolCount == %d, reciedCount == %d,progress == %lf", totalCount, receivedCount, self.progress);
    [self.progressView setProgress:self.progress];
    [self.bybUIWebViewDelegate BYBUIWebView:self progress:_progress title:@""];
   
    
}



@end

