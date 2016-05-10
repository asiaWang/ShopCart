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
#import "PAIShopCartSectionHeader.h"
#import "PAIShopRecommendView.h"

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

@property (nonatomic,strong)UICollectionView *recommendView;
@property (nonatomic,assign)CGFloat originContentSetY;
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

- (UICollectionView *)recommendView {
    if (!_recommendView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _recommendView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
        _recommendView.delegate = self;
        _recommendView.dataSource = self;
        _recommendView.backgroundColor = [UIColor whiteColor];
        [_recommendView registerNib:[UINib nibWithNibName:@"PAIShopRecommendView" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"CollectionCellIndentify"];
    }
    return _recommendView;
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
    self.originContentSetY = self.tableView.contentOffset.y;
    
}

- (void)prepareData {
    for (int i = 0; i < 1; i++) {
        NSMutableArray *array = [NSMutableArray array];
        for (int j = 0; j < 5; j++) {
            [array addObject:[NSString stringWithFormat:@"number%d",j]];
        }
        [self.data addObject:array];
    }
    [self.tableView reloadData];
    [self.recommendView reloadData];
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
//        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-49.f);
        make.height.mas_equalTo(self.view.frame.size.height + 64);
    }];
    
    self.tableView.tableFooterView = self.recommendView;
    [self.recommendView reloadData];
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
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentify = @"cellIndetify";
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
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *headIndentify = @"headerIndentify";
    PAIShopCartSectionHeader *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headIndentify];
    if (!headerView) {
        headerView = [[[NSBundle mainBundle]loadNibNamed:@"PAIShopCartSectionHeader" owner:nil options:nil]lastObject];
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
//    if (section == self.data.count - 1) {
//        return 44.f;
//    }
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 115.f;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
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

#pragma mark - collection view delegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return CGSizeMake((collectionView.frame.size.width - 30) / 2  , (collectionView.frame.size.width - 30) / 2);
    return CGSizeMake(150  ,150);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *array = self.data[0];
    return array.count * 5;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PAIShopRecommendView *cell = (PAIShopRecommendView *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCellIndentify" forIndexPath:indexPath];
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10.f;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(1, 1, 1, 1);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isKindOfClass:[UICollectionView class]]) {
        NSLog(@"collectionview contentset y = %f",self.recommendView.contentOffset.y);

        if (self.recommendView.contentOffset.y <= 0) {
            CGFloat newY = self.tableView.contentOffset.y - fabs(self.recommendView.contentOffset.y);
            if (newY < self.originContentSetY) {
                self.tableView.contentOffset = CGPointMake(self.tableView.contentOffset.x, self.originContentSetY);
            }else {
                self.tableView.contentOffset = CGPointMake(self.tableView.contentOffset.x, newY);
            }
        }else {
//            self.recommendView.contentOffset = scrollView.contentOffset;
        }
    }
    if ([scrollView isKindOfClass:[UITableView class]]) {
        if (self.tableView.contentOffset.y > self.tableView.contentSize.height - self.tableView.frame.size.height) {
            self.recommendView.contentOffset = CGPointMake(self.recommendView.contentOffset.x,fabs(self.tableView.contentOffset.y - self.tableView.frame.size.height));
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
