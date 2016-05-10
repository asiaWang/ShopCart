//
//  UIImageView+PAIShopRecommendImageView.m
//  PAIShopCartDemo
//
//  Created by wangasia on 16/5/10.
//  Copyright © 2016年 com.pencho.com. All rights reserved.
//

#import "UIImageView+PAIShopRecommendImageView.h"

static const  char itemIdKey;

@implementation UIImageView (PAIShopRecommendImageView)

- (NSString *)itemId {
    return objc_getAssociatedObject(self, &itemIdKey);
}

- (void)setItemId:(NSString *)itemId {
    objc_setAssociatedObject(self, &itemIdKey, itemId, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end
