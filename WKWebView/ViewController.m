//
//  ViewController.m
//  WKWebView
//
//  Created by 饼饼白 on 2017/4/16.
//  Copyright © 2017年 饼饼白. All rights reserved.
//

#import "ViewController.h"
#import "WKWebViewController.h"
#import "UIWebViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    UIButton *wkButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    wkButton.frame= CGRectMake(100, 200, 100, 40);
    wkButton.tag = 101;
    wkButton.backgroundColor = [UIColor redColor];
    [wkButton setTitle:@"WKWebView" forState:(UIControlStateNormal)];
    wkButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [wkButton addTarget:self action:@selector(wkButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:wkButton];
//
    UIButton *UIwebBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    UIwebBtn.frame= CGRectMake(100, 260, 100, 40);
    UIwebBtn.tag = 102;
    UIwebBtn.backgroundColor = [UIColor redColor];
    [UIwebBtn setTitle:@"UIWebView" forState:(UIControlStateNormal)];
    UIwebBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [UIwebBtn addTarget:self action:@selector(wkButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:UIwebBtn];

}

- (void)wkButtonClick:(UIButton *)button
{
    if (button.tag == 101) {
        WKWebViewController *wkVC = [[WKWebViewController alloc] init];
        [self.navigationController pushViewController:wkVC animated:YES];
    }else
    {
        UIWebViewController *webVC = [[UIWebViewController alloc] init];
        [self.navigationController pushViewController:webVC animated:YES];
    }
}
@end
