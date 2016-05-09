//
//  PAIChopCartCell.m
//  PAIShopCartDemo
//
//  Created by wyz on 16/5/9.
//  Copyright © 2016年 com.pencho.com. All rights reserved.
//

#import "PAIShopCartCell.h"
#import <CoreText/CoreText.h>

@interface PAIShopCartCell()
@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
@property (weak, nonatomic) IBOutlet UIButton *itemSelecteButton;
@property (weak, nonatomic) IBOutlet PAICustormDisplayLabel *itemNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemSelecteLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *reduceButton;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UILabel *editCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *editSelecteSizeLabel;
@property (weak, nonatomic) IBOutlet UIButton *editSelecteSizeButton;
@property (nonatomic,assign,readwrite)PAIShopCartCellState state;

@end

@implementation PAIShopCartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.limitedMaxCounts = -1;
    self.cellType = PAIShopCartCellType_Nomal;
    self.itemImageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)setCellType:(PAIShopCartCellType)cellType {
    _cellType = cellType;
    if (_cellType == PAIShopCartCellType_Nomal) {
        self.itemNameLabel.hidden = NO;
        self.itemSelecteLabel.hidden = NO;
        self.itemPriceLabel.hidden = NO;
        self.itemCountLabel.hidden = NO;
        self.reduceButton.hidden = YES;
        self.editCountLabel.hidden = YES;
        self.addButton.hidden = YES;
        self.editSelecteSizeLabel.hidden = YES;
        self.editSelecteSizeButton.hidden = YES;
    }else {
        self.itemNameLabel.hidden = YES;
        self.itemSelecteLabel.hidden = YES;
        self.itemPriceLabel.hidden = YES;
        self.itemCountLabel.hidden = YES;
        self.reduceButton.hidden = NO;
        self.editCountLabel.hidden = NO;
        self.addButton.hidden = NO;
        self.editSelecteSizeLabel.hidden = NO;
        self.editSelecteSizeButton.hidden = NO;
    }
}

- (void)setItemPrice:(CGFloat)itemPrice {
    _itemPrice = itemPrice;
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%f",_itemPrice]];
    [attString addAttribute:(NSString *)kCTFontAttributeName value:(id)CFBridgingRelease(CTFontCreateWithName((CFStringRef)[UIFont  systemFontOfSize:12.f].fontName, 12, NULL)) range:NSMakeRange(0, 1)];
    self.itemPriceLabel.attributedText = attString;

}

- (void)setItemImageUrl:(NSString *)itemImageUrl {
    if (_itemImageUrl != nil) {
        _itemImageUrl = [itemImageUrl copy];
    }
//    [self.itemImageView ]
}

- (void)setItemSizeStr:(NSString *)itemSizeStr {
    if (_itemSizeStr != nil) {
        _itemSizeStr = nil;
    }
    _itemSizeStr = [itemSizeStr copy];
    self.itemSelecteLabel.text = [NSString stringWithFormat:@"尺码: %@",_itemSizeStr];
    self.editSelecteSizeLabel.text = [NSString stringWithFormat:@"尺码: %@",_itemSizeStr];
}

- (void)setItemCounts:(NSInteger)itemCounts {
    self.itemCounts = itemCounts;
    self.itemCountLabel.text = [NSString stringWithFormat:@"%ld",self.itemCounts];
}

- (void)setItemName:(NSString *)itemName {
    if (_itemName != nil) {
        _itemName = nil;
    }
    _itemName = [itemName copy];
    
    CGSize size = CGSizeMake([[UIScreen mainScreen]bounds].size.width - self.itemNameLabel.frame.origin.x - 10, 42);
    
    CGRect rect = [_itemName boundingRectWithSize:size options:NSStringDrawingUsesFontLeading attributes:@{NSAttachmentAttributeName:[UIFont fontWithName:self.itemNameLabel.font.fontName size:self.itemNameLabel.font.pointSize]} context:nil];
    CGSize newSize;
    if (rect.size.height < 21) {
        newSize = CGSizeMake(rect.size.width, 21.f);
    }else {
        if (rect.size.height > 42.f) {
            newSize = CGSizeMake(rect.size.width, 42.f);
        }else {
            newSize = CGSizeMake(rect.size.width, rect.size.height);
        }
    }
    
    [self.itemNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.itemImageView.frame.origin.x + self.itemImageView.frame.size.width +  5);
        make.top.mas_equalTo(self.mas_top);
        make.size.mas_equalTo(newSize);
    }];
    self.itemNameLabel.text = _itemName;
    [self setNeedsUpdateConstraints];
}

- (IBAction)selectedAction:(id)sender {
    self.selectedButtonBlock(self.index);
}

- (IBAction)reduceCountAction:(id)sender {
    if (self.itemCounts > 1) {
        self.itemCounts -= 1;
    }
    self.editCountLabel.text = [NSString stringWithFormat:@"%ld",self.itemCounts];
}
- (IBAction)addCountAction:(id)sender {
    if (self.limitedMaxCounts > 0) {
        if (self.itemCounts < self.itemMaxCounts && self.itemCounts < self.limitedMaxCounts) {
            self.itemCounts += 1;
        }
    }else {
        if (self.itemCounts < self.itemMaxCounts) {
            self.itemCounts += 1;
        }
    }
    self.editCountLabel.text = [NSString stringWithFormat:@"%ld",self.itemCounts];
}

- (IBAction)editSelectedSizeAction:(id)sender {
    self.selecteSizeBlock(self.index);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
