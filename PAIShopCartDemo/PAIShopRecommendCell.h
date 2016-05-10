//
//  PAIShopRecommendCell.h
//  PAIShopCartDemo
//
//  Created by wangasia on 16/5/10.
//  Copyright © 2016年 com.pencho.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+PAIShopRecommendImageView.h"

@interface PAIShopRecommendCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
@property (weak, nonatomic) IBOutlet UIImageView *itemImageView2;
@property (nonatomic,copy)void (^firstItemClickBlock)(NSInteger itemId);
@property (nonatomic,copy)void (^secondItemClickBlock)(NSInteger);
@end
