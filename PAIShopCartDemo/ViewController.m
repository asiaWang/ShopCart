//
//  ViewController.m
//  PAIShopCartDemo
//
//  Created by wyz on 16/5/9.
//  Copyright © 2016年 com.pencho.com. All rights reserved.
//

#import "ViewController.h"
#import "PAIShopCartViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"购物车";
}
- (IBAction)pushToShopCartView:(id)sender {
    PAIShopCartViewController *shopCartViewController = [[PAIShopCartViewController alloc] init];
    [self.navigationController pushViewController:shopCartViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
