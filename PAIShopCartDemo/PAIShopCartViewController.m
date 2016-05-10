//
//  PAIShopCartViewController.m
//  PAIShopCartDemo
//
//  Created by wyz on 16/5/9.
//  Copyright © 2016年 com.pencho.com. All rights reserved.
//

#import "PAIShopCartViewController.h"
#import "PAIShopCartBottomBar.h"
#import "PAIShopCartCell.h"
#import "PAIShopCartHeadView.h"
#import "PAIShopRecommendView.h"
#import "PAIShopRecommendCell.h"

typedef NS_ENUM(NSInteger,PAIShopCartViewControllerType) {
    PAIShopCartViewControllerType_Namal,
    PAIShopCartViewControllerType_Edit,
};

@interface PAIShopCartViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIButton *editButton;
@property (nonatomic,strong)PAIShopCartBottomBar *bottomBar;
@property (nonatomic,assign)PAIShopCartViewControllerType type;

@property (nonatomic,strong)NSMutableArray *data;
@property (nonatomic,strong)NSMutableSet *selectedSectionSet;
@property (nonatomic,strong)NSMutableSet *selectedRowSet;

@end

@implementation PAIShopCartViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (PAIShopCartBottomBar *)bottomBar {
    if (!_bottomBar) {
        _bottomBar = [[[NSBundle mainBundle]loadNibNamed:@"PAIShopCartBottomBar" owner:nil options:nil]lastObject];
    }
    return _bottomBar;
}

- (NSMutableSet *)selectedSectionSet {
    if (!_selectedSectionSet) {
        _selectedSectionSet = [NSMutableSet set];
    }
    return _selectedSectionSet;
}

- (NSMutableSet *)selectedRowSet {
    if (!_selectedRowSet) {
        _selectedRowSet = [NSMutableSet set];
    }
    return _selectedRowSet;
}

- (NSMutableArray *)data {
    if (!_data) {
        _data = [NSMutableArray array];
    }
    return _data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"购物车";
//    self.automaticallyAdjustsScrollViewInsets = YES;
    self.type = PAIShopCartViewControllerType_Namal;
    [self addRightEditButton];
    [self addTableView];
    [self addBottmBar];
    
    [self prepareData];
    
}

- (void)prepareData {
    for (int i = 0; i < 5; i++) {
        NSMutableArray *array = [NSMutableArray array];
        for (int j = 0; j < 5; j++) {
            [array addObject:[NSString stringWithFormat:@"number%d",j]];
        }
        [self.data addObject:array];
    }
    [self.tableView reloadData];
}

- (void)addRightEditButton {
    self.editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.editButton setTitleColor:[UIColor colorWithRed:155.f / 255.f green:155.f / 255.f blue:155.f / 255.f alpha:1] forState:UIControlStateNormal];
    [self.editButton setTitle:@"编辑" forState:UIControlStateNormal];
    self.editButton.frame = CGRectMake(0, 0, 44, 44);
    [self.editButton addTarget:self action:@selector(editClickAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.editButton];
}

- (void)addTableView {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.view.mas_top);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-49.f);
//        make.height.mas_equalTo(self.view.frame.size.height + 64);
    }];
    
}

- (void)addBottmBar {
    [self.view addSubview:self.bottomBar];
    [self.bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(49.f);
    }];

    self.bottomBar.shopCartBottomBarBuyClick = ^ (PAIShopCartBottomBarType type) {
        if (type == PAIShopCartBottomBarType_Nomal) {
            // buy
        }else {
            // 删除
        }
    };
    
    self.bottomBar.selectedAllClick = ^ (PAIShopCartBottomBarType type) {
        if (type == PAIShopCartBottomBarType_Nomal) {
            // 全选计算所有费用
        }else {
            // 全选删除
        }
    };
}

- (void)editClickAction:(UIButton *)sender {
    if (self.type == PAIShopCartViewControllerType_Namal) {
        self.type = PAIShopCartViewControllerType_Edit;
        self.bottomBar.shopCartType = PAIShopCartBottomBarType_Edit;
        [self.editButton setTitle:@"完成" forState:UIControlStateNormal];
    }else {
        self.type = PAIShopCartViewControllerType_Namal;
        self.bottomBar.shopCartType = PAIShopCartBottomBarType_Nomal;
        [self.editButton setTitle:@"编辑" forState:UIControlStateNormal];
    }
    [self.tableView reloadData];
}

#pragma mark - table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = self.data[section];
    if (section == self.data.count - 1) {
        return array.count / 2;
    }
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentify = @"cellIndetify";
    static NSString *cellRecommendIndentify = @"cellRecommendIndentify";
    UITableViewCell *cell;
    if (indexPath.section < self.data.count - 1) {
        PAIShopCartCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentify];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"PAIShopCartCell" owner:nil options:nil]lastObject];
        }
        
        if (self.type == PAIShopCartViewControllerType_Namal) {
            cell.cellType = PAIShopCartCellType_Nomal;
        }else {
            cell.cellType = PAIShopCartCellType_Edit;
        }
        cell.selectedButtonBlock = ^(NSInteger index){
            // 选中或者取消
        };
        
        cell.selecteSizeBlock = ^(NSInteger index) {
            // 选择size
        };
        return cell;
    }else {
        PAIShopRecommendCell *cellRecommend = [tableView dequeueReusableCellWithIdentifier:cellRecommendIndentify];
        if (!cellRecommend) {
            cellRecommend = [[[NSBundle mainBundle]loadNibNamed:@"PAIShopRecommendCell" owner:nil options:nil]lastObject];
        }
        cellRecommend.itemImageView.itemId = [NSString stringWithFormat:@"%ld",indexPath.row];
        cellRecommend.itemImageView2.itemId = [NSString stringWithFormat:@"%ld",indexPath.row];
        cellRecommend.firstItemClickBlock = ^ (NSInteger itemId) {
            NSLog(@"first image view click");
        };
        cellRecommend.secondItemClickBlock = ^ (NSInteger itemId) {
            NSLog(@"second image view click");
        };
        return cellRecommend;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *headIndentify = @"headerIndentify";
    PAIShopCartHeadView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headIndentify];
    if (!headerView) {
        headerView = [[[NSBundle mainBundle]loadNibNamed:@"PAIShopCartHeadView" owner:nil options:nil]lastObject];
    }
    
    headerView.selectedAllButtonBlock = ^(NSInteger section){
        // 全选
    };
    headerView.selectedBlock = ^(NSInteger section) {
        // link 官网
    };
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == self.data.count - 1) {
        return 44.f;
    }
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 115.f;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < self.data.count - 1) {
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleNone;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
//        [self.tableView reloadData];
    }else {
        // do nothing
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
