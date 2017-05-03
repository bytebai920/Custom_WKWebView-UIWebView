# Custom_WKWebView-UIWebView
custom wkwebview and uiwebview that can measure the progress of loading some site

Custom WKWebView  
      BYBWebView *bybWebView = [[BYBWebView alloc] initBYBWebViewDelegate:self configuration:nil];
      [bybWebView startTestWithUrl:@"https://www.baidu.com"];

Custom UIWebView
    BYBUIWebView *bybUIwebView = [[BYBUIWebView alloc] initWithDelegate:self];
    self.bybUIwebView = bybUIwebView;
    [bybUIwebView startTestWithUrl:@"http://www.qq.com"];

![img](https://github.com/baiyongbing/Custom_WKWebView-UIWebView/blob/master/WKWebView/kSBhB0YIP9.gif)
