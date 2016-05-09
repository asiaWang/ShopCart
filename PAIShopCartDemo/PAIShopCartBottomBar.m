//
//  PAIShopCartBottomBar.m
//  PAI2.0
//
//  Created by wyz on 16/5/4.
//  Copyright © 2016年 pencho. All rights reserved.
//

#import "PAIShopCartBottomBar.h"

@interface PAIShopCartBottomBar()

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;
@property (weak, nonatomic) IBOutlet UIButton *selecteAllButton;
@property (weak, nonatomic) IBOutlet UILabel *priceTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceDesLabel;
@end

@implementation PAIShopCartBottomBar


- (void)awakeFromNib {
    [super awakeFromNib];
    self.shopCartType = PAIShopCartBottomBarType_Nomal;
    
    self.layer.shadowColor = [UIColor grayColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, -0.1);
    self.layer.shadowOpacity = 0.5;
}

- (void)setShopCartType:(PAIShopCartBottomBarType)shopCartType {
    _shopCartType = shopCartType;
//    if (self.shopCartType == PAIShopCartBottomBarType_Nomal) {
//        self.priceLabel.hidden = NO;
//        self.priceDesLabel.hidden = NO;
//        self.priceTitleLabel.hidden = NO;
//        self.selecteAllButton.imageEdgeInsets = UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
//        self.selecteAllButton.imageEdgeInsets = UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
//    }else {
//        self.priceLabel.hidden = YES;
//        self.priceDesLabel.hidden = YES;
//        self.priceTitleLabel.hidden = YES;
//
//        self.selecteAllButton.imageEdgeInsets = UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
//        self.selecteAllButton.imageEdgeInsets = UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
//
//    }
}

- (void)setPrice:(NSString *)priceText {
    if (priceText.length > 0) {
        self.priceLabel.text = [NSString stringWithFormat:@"¥%@",priceText];
    }else {
        self.priceLabel.text = @"";
    }
}

- (void)setBuyButtonCount:(NSInteger)count {
    if (count > 0) {
        [self.buyButton setTitle:[NSString stringWithFormat:@"结算(%ld)",count] forState:UIControlStateNormal];
    }else {
        [self.buyButton setTitle:[NSString stringWithFormat:@"结算"] forState:UIControlStateNormal];
    }
}

- (IBAction)selecteAllClick:(id)sender {
    self.selectedAllClick(self.shopCartType);
}
- (IBAction)buyAction:(id)sender {
    self.shopCartBottomBarBuyClick(self.shopCartType);
}
@end
