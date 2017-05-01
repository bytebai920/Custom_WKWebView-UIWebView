//
//  BYBWebView.m
//  WKWebView
//
//  Created by 饼饼白 on 2017/4/16.
//  Copyright © 2017年 饼饼白. All rights reserved.
//

#import "BYBWebView.h"

@interface BYBWebView ()<WKNavigationDelegate,NSURLConnectionDelegate>

@property(nonatomic, strong)UIProgressView *progressView;

@property(nonatomic, strong)NSTimer *wkWebTimer;

@property(nonatomic, assign)double webProgress;
//
@property(nonatomic, strong)NSString *webTitle;
//
//@property(nonatomic, strong)

@end

@implementation BYBWebView


- (instancetype)initBYBWebViewDelegate:(id<BYBWebViewDelegate>)delegate configuration:(WKWebViewConfiguration *)configuration
{
    if (configuration == nil) {
        configuration = [[WKWebViewConfiguration alloc] init];
    }
    configuration.preferences.minimumFontSize = 10;
    configuration.preferences.javaScriptEnabled = YES;
    configuration.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    
    self = [super initWithFrame:CGRectZero configuration:configuration];
    if (self) {
        
        [self initialParame];
        [self initUI];
        self.bybWebDelegate = delegate;
        self.navigationDelegate = self;
    }
    return self;
}

- (void)initialParame
{
    self.webTitle = @"";
    self.webProgress = 0.0;
}

- (void)initUI
{
    UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:(UIProgressViewStyleDefault)];
    self.progressView = progressView;
    progressView.trackTintColor = [UIColor whiteColor];
    progressView.progressTintColor = [UIColor cyanColor];
    
}

- (void)startTestWithUrl:(NSString *)urlStr
{
    
    [self WKWebViewaddObserver];
    
//    urlStr = @"https://www.baidu.com";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    [self loadRequest: request];
    
    [self startTimer];
}

- (void)WKWebViewaddObserver
{
    [self addObserver:self forKeyPath:@"loading" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"loading"]) {
        NSLog(@"isLoading");
    }else if ([keyPath isEqualToString:@"title"])
    {
        self.webTitle = self.title;
        NSLog(@"webviewTitle == %@", self.title);
    }else if ([keyPath isEqualToString:@"estimatedProgress"])
    {
        self.webProgress = self.estimatedProgress;
        NSLog(@"progress == %f", self.estimatedProgress);
    }
    
    [self.progressView setProgress:self.webProgress];
    if ([self.bybWebDelegate respondsToSelector:@selector(BYBWebView:progress:title:)]) {
        [self.bybWebDelegate BYBWebView:self progress:self.webProgress title:self.webTitle];
    }

}


- (void)startTimer
{
    _wkWebTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(wkWebUpdateStatus) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_wkWebTimer forMode:NSRunLoopCommonModes];
    if (![NSThread isMainThread]) {
        [[NSRunLoop currentRunLoop] run];
    }
    [_wkWebTimer fire];
}

- (void)wkWebUpdateStatus
{
    [self.progressView setProgress:self.webProgress];
    if ([self.bybWebDelegate respondsToSelector:@selector(BYBWebView:progress:title:)]) {
        [self.bybWebDelegate BYBWebView:self progress:self.webProgress title:self.webTitle];
    }
}

- (void)stopTimer
{
    if ([self.wkWebTimer isValid] && self.wkWebTimer != nil) {
        [self.wkWebTimer invalidate];
    }
}



#pragma mark WKNavigationDelegate&UIDelegate

// 决定导航的动作，通常用于处理跨域的链接能否导航。WebKit对跨域进行了安全检查限制，不允许跨域，因此我们要对不能跨域的链接
// 单独处理。但是，对于Safari是允许跨域的，不用这么处理。
// 这个是决定是否Request
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    decisionHandler(WKNavigationActionPolicyAllow);
}

// 决定是否接收响应
// 这个是决定是否接收response
// 要获取response，通过WKNavigationResponse对象获取
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    decisionHandler(WKNavigationResponsePolicyAllow);
}

// 当main frame的导航开始请求时，会调用此方法
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    if ([self.bybWebDelegate respondsToSelector:@selector(BYBWebViewStartLoad:)]) {
        UIView *view = [self.bybWebDelegate BYBWebViewStartLoad:self];
        self.frame = CGRectMake(0, 65, view.frame.size.width, view.frame.size.height - 65);
        [view addSubview:self];
        
        self.progressView.frame = CGRectMake(0, 64, view.frame.size.width, 1);
        [view addSubview:self.progressView];
        
    }
    NSLog(@"startLoad");
}

// 当main frame接收到服务重定向时，会回调此方法
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    NSLog(@"ServerRedirect");
}

// 当main frame开始加载数据失败时，会回调
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"load failed");
}

// 当main frame的web内容开始到达时，会回调
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation
{
    
}

// 当main frame导航完成时，会回调
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    if ([self.bybWebDelegate respondsToSelector:@selector(BYBWebVIewFinished:)]) {
        [self.bybWebDelegate BYBWebVIewFinished:self];
    }
    
    [self removeObserver];
    [self stopTimer];
    NSLog(@"loadFinish");
}

// 当main frame最后下载数据失败时，会回调
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    [self stopTimer];
    if ([self.bybWebDelegate respondsToSelector:@selector(BYBWebView:Failed:)]) {
        [self.bybWebDelegate BYBWebView:self Failed:error];
    }
}

// 这与用于授权验证的API，与AFN、UIWebView的授权验证API是一样的
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *__nullable credential))completionHandler
{
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        if ([challenge previousFailureCount] == 0) {
            NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
        }else
        {
            completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
        }
    }else
    {
        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
    }
}

// 当web content处理完成时，会回调
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView NS_AVAILABLE(10_11, 9_0)
{
    
}

- (void)removeObserver
{
    [self removeObserver:self forKeyPath:@"loading"];
    [self removeObserver:self forKeyPath:@"title"];
    [self removeObserver:self forKeyPath:@"estimatedProgress"];

}


@end
