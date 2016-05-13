//
//  PAIScrollViewViewControllerOne.m
//  PAIShopCartDemo
//
//  Created by wyz on 16/5/13.
//  Copyright © 2016年 com.pencho.com. All rights reserved.
//

#import "PAIScrollViewViewControllerOne.h"
#import "PAIScrollViewControllerTwo.h"
#import "UIScrollView+JYPaging.h"
#import <Masonry.h>

@interface PAIScrollViewViewControllerOne ()<UIWebViewDelegate>
@property (strong, nonatomic)  UIScrollView *scrollView;

@end

@implementation PAIScrollViewViewControllerOne


- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,[[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height - 64)];
        _scrollView.backgroundColor = [UIColor greenColor];

    }
    return _scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.edgesForExtendedLayout = UIRectEdgeNone;

    self.scrollView.contentSize = CGSizeMake([[UIScreen mainScreen]bounds].size.width, self.view.frame.size.height + 104);

    UILabel *label = [UILabel new];
    label.frame = CGRectMake(0, self.scrollView.frame.size.height - 44, [[UIScreen mainScreen]bounds].size.width, 44);
    label.text = @"第一页";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor redColor];
    
    [self.view addSubview:self.scrollView];
    [self.view addSubview:label];

//    PAIScrollViewControllerTwo *scrollViewTwo = [[PAIScrollViewControllerTwo alloc] initWithNibName:@"PAIScrollViewControllerTwo" bundle:[NSBundle mainBundle]];
    PAIScrollViewControllerTwo *scrollViewTwo = [[PAIScrollViewControllerTwo alloc] init];

    [self addChildViewController:scrollViewTwo];
    if (scrollViewTwo.view) {
        self.scrollView.secondScrollView = scrollViewTwo.scrollView;
//        self.scrollView.secondScrollView = scrollViewTwo.webView2.scrollView;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height + 84);

}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
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
