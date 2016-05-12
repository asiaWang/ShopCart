//
//  PAIShopCartSectionHeader.h
//  PAIShopCartDemo
//
//  Created by wyz on 16/5/9.
//  Copyright © 2016年 com.pencho.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,PAIShopCartSectionHeaderState) {
    PAIShopCartSectionHeaderState_Nomal,
    PAIShopCartSectionHeaderState_Selected,
};

@interface PAIShopCartHeadView : UITableViewHeaderFooterView

@property (nonatomic,copy)NSString *itemNameStr;
@property (nonatomic,copy)NSString *itemImageUrl;
@property (nonatomic,assign)NSInteger section;

@property (nonatomic,assign)PAIShopCartSectionHeaderState state;
// click all button
@property (nonatomic,copy)void (^selectedAllButtonBlock)(NSInteger);
// click本身
@property (nonatomic,copy)void (^selectedBlock)(NSInteger);
@end
