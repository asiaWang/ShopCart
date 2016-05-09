//
//  PAIShopCartSectionHeader.m
//  PAIShopCartDemo
//
//  Created by wyz on 16/5/9.
//  Copyright © 2016年 com.pencho.com. All rights reserved.
//

#import "PAIShopCartSectionHeader.h"

@interface PAIShopCartSectionHeader()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *stateButton;
@property (nonatomic,assign,readwrite)PAIShopCartSectionHeaderState state;

@end

@implementation PAIShopCartSectionHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib {
    [super awakeFromNib];
    self.state = PAIShopCartSectionHeaderState_Nomal;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [self.itemNameLabel addGestureRecognizer:tap];
}

- (void)setState:(PAIShopCartSectionHeaderState)state {
    _state = state;
    if (_state == PAIShopCartSectionHeaderState_Nomal) {
        [self.stateButton setImage:[UIImage imageNamed:@"icon_unchecked_grey"] forState:UIControlStateNormal];
    }else {
        [self.stateButton setImage:[UIImage imageNamed:@"icon_check_red_solid"] forState:UIControlStateNormal];
    }
}

- (IBAction)selectedAllAction:(id)sender {
    if (self.state == PAIShopCartSectionHeaderState_Nomal) {
        self.state = PAIShopCartSectionHeaderState_Selected;
    }else {
        self.state = PAIShopCartSectionHeaderState_Nomal;
    }
    self.selectedAllButtonBlock(self.section);
}

- (void)tapClick:(UITapGestureRecognizer *)sender {
    self.selectedBlock(self.section);
}

@end
