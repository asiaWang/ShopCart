//
//  PAIChopCartCell.h
//  PAIShopCartDemo
//
//  Created by wyz on 16/5/9.
//  Copyright © 2016年 com.pencho.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PAICustormDisplayLabel.h"
#import <Masonry.h>

typedef NS_ENUM(NSInteger,PAIShopCartCellType) {
    PAIShopCartCellType_Nomal,
    PAIShopCartCellType_Edit,
};

typedef NS_ENUM(NSInteger,PAIShopCartCellState) {
    PAIShopCartCellState_Nomal,
    PAIShopCartCellState_selected,
};

@interface PAIShopCartCell : UITableViewCell
@property (nonatomic,assign)PAIShopCartCellType cellType;
@property (nonatomic,copy)NSString *itemName;
@property (nonatomic,copy)NSString *itemImageUrl;
@property (nonatomic,copy)NSString *itemSizeStr;
@property (nonatomic,assign)CGFloat itemPrice;
@property (nonatomic,assign)NSInteger itemCounts;
@property (nonatomic,assign)NSInteger itemMaxCounts;
@property (nonatomic,assign,readonly)PAIShopCartCellState state;
// 限购 默认不限购(limitedMaxCounts = -1);
@property (nonatomic,assign)NSInteger limitedMaxCounts;
@property (nonatomic,assign)NSInteger index;

@property (nonatomic,copy)void (^selectedButtonBlock)(NSInteger index);
@property (nonatomic,copy)void (^selecteSizeBlock)(NSInteger index);
@end
