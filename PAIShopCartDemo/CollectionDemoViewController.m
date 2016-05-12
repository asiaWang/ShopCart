//
//  CollectionDemoViewController.m
//  PAIShopCartDemo
//
//  Created by wyz on 16/5/10.
//  Copyright © 2016年 com.pencho.com. All rights reserved.
//

#import "CollectionDemoViewController.h"
//#import "PAIShopRecommendView.h"

@interface CollectionDemoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)UICollectionView *recommendView;

@end

@implementation CollectionDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.recommendView];
    [self.recommendView reloadData];
}
- (UICollectionView *)recommendView {
    if (!_recommendView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _recommendView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
        _recommendView.delegate = self;
        _recommendView.dataSource = self;
        _recommendView.backgroundColor = [UIColor whiteColor];
//        [_recommendView registerNib:[UINib nibWithNibName:@"PAIShopRecommendView" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"CollectionCellIndentify"];
    }
    return _recommendView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - collection view delegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //    return CGSizeMake((collectionView.frame.size.width - 30) / 2  , (collectionView.frame.size.width - 30) / 2);
    return CGSizeMake(130  ,130);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell;
//    PAIShopRecommendView *cell = (PAIShopRecommendView *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCellIndentify" forIndexPath:indexPath];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
