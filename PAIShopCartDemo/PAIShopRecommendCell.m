//
//  PAIShopRecommendCell.m
//  PAIShopCartDemo
//
//  Created by wangasia on 16/5/10.
//  Copyright © 2016年 com.pencho.com. All rights reserved.
//

#import "PAIShopRecommendCell.h"

@interface PAIShopRecommendCell()

@end

@implementation PAIShopRecommendCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touche = [touches anyObject];
    CGPoint point = [touche locationInView:self];
    for (id object in self.contentView.subviews) {
        if ([object isKindOfClass:[UIImageView class]]) {
            UIImageView *imageView = (UIImageView *)object;
            if (CGRectContainsPoint(imageView.frame, point)) {
                if (imageView.hash == self.itemImageView.hash) {
                    self.firstItemClickBlock([self.itemImageView.itemId integerValue]);
                }else if (imageView.hash == self.itemImageView2.hash){
                    self.secondItemClickBlock([self.itemImageView2.itemId integerValue]);
                }
            }
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
