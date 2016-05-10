//
//  PAIShopCartBottomBar.m
//  PAI2.0
//
//  Created by wyz on 16/5/4.
//  Copyright © 2016年 pencho. All rights reserved.
//

#import "PAIShopCartBottomBar.h"
#import <CoreText/CoreText.h>
@interface PAIShopCartBottomBar()

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;
@property (weak, nonatomic) IBOutlet UIButton *selecteAllButton;
@property (weak, nonatomic) IBOutlet UILabel *priceTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceDesLabel;
@property (nonatomic,assign,readwrite)PAIShopCartBottomBarState state;

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
    if (self.shopCartType == PAIShopCartBottomBarType_Nomal) {
        self.priceLabel.hidden = NO;
        self.priceDesLabel.hidden = NO;
        self.priceTitleLabel.hidden = NO;
        [self.buyButton setTitle:[NSString stringWithFormat:@"结算"] forState:UIControlStateNormal];
    }else {
        self.priceLabel.hidden = YES;
        self.priceDesLabel.hidden = YES;
        self.priceTitleLabel.hidden = YES;
        [self.buyButton setTitle:[NSString stringWithFormat:@"删除"] forState:UIControlStateNormal];
    }
}

- (void)setState:(PAIShopCartBottomBarState)state {
    _state = state;
    if (_state == PAIShopCartBottomBarState_Nomal) {
        [self.selecteAllButton setImage:[UIImage imageNamed:@"icon_unchecked_grey"] forState:UIControlStateNormal];
    }else {
        [self.selecteAllButton setImage:[UIImage imageNamed:@"icon_check_red_solid"] forState:UIControlStateNormal];
    }
}

- (void)setPrice:(NSString *)priceText {
    if (priceText.length > 0) {
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",priceText]];
        [attString addAttribute:(NSString *)kCTFontAttributeName value:(id)CFBridgingRelease(CTFontCreateWithName((CFStringRef)[UIFont  systemFontOfSize:12.f].fontName, 12, NULL)) range:NSMakeRange(0, 1)];
        self.priceLabel.attributedText = attString;
    }else {
        self.priceLabel.text = @"";
    }
}

- (void)setBuyButtonCount:(NSInteger)count {
    if (count > 0) {
        if (self.shopCartType == PAIShopCartBottomBarType_Nomal) {
            [self.buyButton setTitle:[NSString stringWithFormat:@"结算(%ld)",count] forState:UIControlStateNormal];
        }else {
            [self.buyButton setTitle:[NSString stringWithFormat:@"删除(%ld)",count] forState:UIControlStateNormal];
        }
    }else {
        if (self.shopCartType == PAIShopCartBottomBarType_Nomal) {
            [self.buyButton setTitle:[NSString stringWithFormat:@"结算"] forState:UIControlStateNormal];
        }else {
            [self.buyButton setTitle:[NSString stringWithFormat:@"删除"] forState:UIControlStateNormal];
        }
    }
}

- (IBAction)selecteAllClick:(id)sender {
    if (self.state == PAIShopCartBottomBarState_Nomal) {
        self.state = PAIShopCartBottomBarState_Selected;
    }else {
        self.state = PAIShopCartBottomBarState_Nomal;
    }
    self.selectedAllClick(self.shopCartType);
}
- (IBAction)buyAction:(id)sender {
    self.shopCartBottomBarBuyClick(self.shopCartType);
}
@end
