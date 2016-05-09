//
//  PAICustormDisplayLabel.m
//  PAIShopCartDemo
//
//  Created by wyz on 16/5/9.
//  Copyright © 2016年 com.pencho.com. All rights reserved.
//

#import "PAICustormDisplayLabel.h"

@implementation PAICustormDisplayLabel


- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    [super textRectForBounds:self.bounds limitedToNumberOfLines:numberOfLines];
    return self.bounds;
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
