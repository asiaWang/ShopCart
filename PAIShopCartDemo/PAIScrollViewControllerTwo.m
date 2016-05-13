//
//  PAIScrollViewControllerTwo.m
//  PAIShopCartDemo
//
//  Created by wyz on 16/5/13.
//  Copyright © 2016年 com.pencho.com. All rights reserved.
//

#import "PAIScrollViewControllerTwo.h"
#import <Masonry.h>

@interface PAIScrollViewControllerTwo ()<UIScrollViewDelegate>

@end

@implementation PAIScrollViewControllerTwo

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,[[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height - 64)];
        _scrollView.backgroundColor = [UIColor orangeColor];
    }
    return _scrollView;
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height - 64)];
        _webView.backgroundColor = [UIColor orangeColor];
    }
    return _webView;
    
}

- (WKWebView *)webView2 {
    if (!_webView2) {
        WKWebViewConfiguration *config = [WKWebViewConfiguration new];
        _webView2 = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height - 64) configuration:config];
        _webView2.backgroundColor = [UIColor orangeColor];
    }
    return _webView2;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;

    self.scrollView.contentSize = CGSizeMake([[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height - 64);
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.webView];
    [self.scrollView addSubview:self.webView2];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
//    [self.webView loadRequest:request];
    [self.webView2 loadRequest:request];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.scrollView.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height - 64);
//    self.webView.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    self.webView.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height - 64);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < 0) {
        NSLog(@"lashenle lashenle ");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
