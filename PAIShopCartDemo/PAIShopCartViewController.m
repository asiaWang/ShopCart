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
#import "PAIShopRecommendCell.h"
#import "PAIShopCartRecommendHeadView.h"

typedef NS_ENUM(NSInteger,PAIShopCartViewControllerType) {
    PAIShopCartViewControllerType_Namal,
    PAIShopCartViewControllerType_Edit,
};

@interface PAIShopCartViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIButton *editButton;
@property (nonatomic,strong)PAIShopCartBottomBar *bottomBar;
@property (nonatomic,assign)PAIShopCartViewControllerType type;

@property (nonatomic,strong)__block NSMutableArray *data;
@property (nonatomic,strong)__block NSMutableSet *selectedSectionSet;
@property (nonatomic,strong)__block NSMutableSet *selectedRowSet;

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
    self.type = PAIShopCartViewControllerType_Namal;
    [self addRightEditButton];
    [self addTableView];
    [self addBottmBar];
    
    [self prepareData];
    
}

- (void)prepareData {
    NSInteger space = 0;
    for (int i = 0; i < 5; i++) {
        NSMutableArray *array = [NSMutableArray array];
        for (int j = 0; j < 5; j++) {
            space++;
            [array addObject:[NSString stringWithFormat:@"%ld",space]];
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
    
    __weak __typeof(self.bottomBar)weakBottomBar = self.bottomBar;
    __weak __typeof(self)weakSelf = self;
    self.bottomBar.selectedAllClick = ^ (PAIShopCartBottomBarType type) {
        __strong __typeof(weakBottomBar)strongBottomBar = weakBottomBar;
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (strongBottomBar.state == PAIShopCartBottomBarState_Nomal) {
            [strongSelf.selectedSectionSet removeAllObjects];
            [strongSelf.selectedRowSet removeAllObjects];
        }else {
            for (int i = 0 ; i < self.data.count - 1; i++) {
                [strongSelf.selectedSectionSet addObject:[NSString stringWithFormat:@"%d",i]];
                NSArray *array = strongSelf.data[i];
                [strongSelf.selectedRowSet addObjectsFromArray:array];
            }
            // 全选计算所有费用
        }
        [strongSelf setBottomBarCountAndPrice];
        [strongSelf.tableView reloadData];
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

- (void)setBottomBarCountAndPrice {
    NSInteger dataCount = 0;
    for (int i = 0; i < self.data.count - 1; i++) {
        NSArray *array = self.data[i];
        dataCount += array.count;
    }
    
    [self.bottomBar setBuyButtonCount:self.selectedRowSet.count];
    [self.bottomBar setPrice:@"123123123"];
    // 判断购物车是否是全选

    if (dataCount == self.selectedRowSet.count) {
        self.bottomBar.state = PAIShopCartBottomBarState_Selected;
    }else {
        self.bottomBar.state = PAIShopCartBottomBarState_Nomal;
    }
}

#pragma mark - table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = self.data[section];
    if (section == self.data.count - 1) {
        if (array.count % 2 == 0) {
            return array.count / 2;
        }else {
            return array.count / 2 + 1;
        }
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
        NSArray *array = self.data[indexPath.section];
        cell.cellSection = indexPath.section;
        cell.index = indexPath.row;
        cell.itemId = array[indexPath.row];
        
        if (self.type == PAIShopCartViewControllerType_Namal) {
            cell.cellType = PAIShopCartCellType_Nomal;
        }else {
            cell.cellType = PAIShopCartCellType_Edit;
        }
        
        if ([self.selectedRowSet containsObject:cell.itemId]) {
            cell.state = PAIShopCartCellState_selected;
        }else {
            cell.state = PAIShopCartCellState_Nomal;
        }
        
        __weak __typeof(cell)weakCell = cell;
        __weak __typeof(self)weakSelf = self;
        cell.selectedButtonBlock = ^(NSInteger index){
            // 选中或者取消
            __strong __typeof(weakCell)strongCell = weakCell;
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            NSArray *array = strongSelf.data[strongCell.cellSection];
            if (strongCell.state == PAIShopCartCellState_Nomal) {
                if ([strongSelf.selectedRowSet containsObject:strongCell.itemId]) {
                    [strongSelf.selectedRowSet removeObject:strongCell.itemId];
                }
                // 查询section是否是全选
                if ([strongSelf.selectedSectionSet containsObject:[NSString stringWithFormat:@"%ld",strongCell.cellSection]]) {
                    [strongSelf.selectedSectionSet removeObject:[NSString stringWithFormat:@"%ld",strongCell.cellSection]];
                }
            }else {
                [strongSelf.selectedRowSet addObject:array[index]];
                
                // 判断每个section是否被全选
                BOOL containAll = YES;
                for (int i = 0; i < array.count; i++) {
                    NSString *str = array[i];
                    if (![strongSelf.selectedRowSet containsObject:str]) {
                        containAll = NO;
                        break;
                    }
                }
                if (containAll) {
                    [strongSelf.selectedSectionSet addObject:[NSString stringWithFormat:@"%ld",strongCell.cellSection]];
                }
            }
            [strongSelf.tableView reloadData];
            [strongSelf setBottomBarCountAndPrice];
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
    if (section < self.data.count - 1) {
        PAIShopCartHeadView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headIndentify];
        if (!headerView) {
            headerView = [[[NSBundle mainBundle]loadNibNamed:@"PAIShopCartHeadView" owner:nil options:nil]lastObject];
        }
        headerView.section = section;
        __weak __typeof(headerView)weakHead = headerView;
        __weak __typeof(self)weakSelf = self;
        
        if (self.selectedSectionSet.count > 0) {
            NSString *sectionStr = [NSString stringWithFormat:@"%ld",section];
            if ([self.selectedSectionSet containsObject:sectionStr]) {
                headerView.state = PAIShopCartSectionHeaderState_Selected;
            }
        }else {
            headerView.state = PAIShopCartSectionHeaderState_Nomal;
        }
        
        headerView.selectedAllButtonBlock = ^(NSInteger headsection){
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            // 全选
            if (weakHead.state == PAIShopCartSectionHeaderState_Selected) {
                [strongSelf.selectedSectionSet addObject:[NSString stringWithFormat:@"%ld",headsection]];
                // 添加数据
                NSArray *array = weakSelf.data[headsection];
                [strongSelf.selectedRowSet addObjectsFromArray:array];
            }else {
                [strongSelf.selectedSectionSet removeObject:[NSString stringWithFormat:@"%ld",headsection]];
                 // 删除 row数据
                NSArray *array = strongSelf.data[headsection];
                for (int i = 0; i < array.count; i++) {
                    [strongSelf.selectedRowSet removeObject:array[i]];
                }
            }
            [strongSelf setBottomBarCountAndPrice];
            [strongSelf.tableView reloadData];
        };
        headerView.selectedBlock = ^(NSInteger section) {
            // link 官网
        };
        return headerView;
    }else {
        PAIShopCartRecommendHeadView *headView1 = [[[NSBundle mainBundle]loadNibNamed:@"PAIShopCartRecommendHeadView" owner:nil options:nil]lastObject];
        return headView1;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
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
    if (indexPath.section < self.data.count - 1) {
        // 跳转到单品
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
