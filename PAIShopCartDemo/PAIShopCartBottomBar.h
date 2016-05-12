//
//  PAIShopCartBottomBar.h
//  PAI2.0
//
//  Created by wyz on 16/5/4.
//  Copyright © 2016年 pencho. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,PAIShopCartBottomBarType) {
    PAIShopCartBottomBarType_Nomal, // 正常结算状态
    PAIShopCartBottomBarType_Edit, // 编辑
};

typedef NS_ENUM(NSInteger,PAIShopCartBottomBarState) {
    PAIShopCartBottomBarState_Nomal,
    PAIShopCartBottomBarState_Selected,
};

@interface PAIShopCartBottomBar : UIView
@property (nonatomic,assign)PAIShopCartBottomBarType shopCartType;
@property (nonatomic,assign)PAIShopCartBottomBarState state;
@property (nonatomic,copy)void (^shopCartBottomBarBuyClick)(PAIShopCartBottomBarType);
@property (nonatomic,copy)void (^selectedAllClick)(PAIShopCartBottomBarType);

- (void)setPrice:(NSString *)priceText;
- (void)setBuyButtonCount:(NSInteger)count;
@end
