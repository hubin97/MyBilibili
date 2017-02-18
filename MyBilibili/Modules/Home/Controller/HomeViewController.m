//
//  HomeViewController.m
//  MyBilibili
//
//  Created by Hubin_Huang on 16/9/24.
//  Copyright © 2016年 Hubin_Huang. All rights reserved.
//

#import "HomeViewController.h"
#import "TitleView.h"

#define kSectionHeaderH (40 * k5SWScale)

@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    TitleView *_titleView;
}
@end

@implementation HomeViewController

#pragma mark - Live life
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //DrawViewBorderRadius(self.view, 0, 2, [UIColor redColor]);
    [self initNavi];
    
    [self initCollection];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_titleView updataIndexLabelUIWithNum:1];
    //刷新推荐页
}


#pragma mark - Setup
- (void)initNavi
{
    UIView *naviBar = [[UIView alloc] init];
    [self.view addSubview:naviBar];
    
    naviBar.backgroundColor = cherryPowder;

    [naviBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenW);
        make.height.mas_equalTo(@(52 *k5SWScale));
    }];
    
    _titleView = [[TitleView alloc]initWithFrame:CGRectMake(kScreenW * 2/9, 20 *k5SWScale, kScreenW * 5/9, 32 * k5SWScale) andTitles:@[@"直播",@"推荐",@"番剧"]];
    [naviBar addSubview:_titleView];
    _titleView.backgroundColor = [UIColor clearColor];
    
    _titleView.titleBtnBlock = ^(NSInteger index, NSString *title){
    
        NSLog(@"HomeVc-- index:%ld, title:%@", (long)index,title);

    };
    
}

- (void)initCollection
{
//    UIView *bgView = [[UIView alloc]init];
//    [self.view addSubview:bgView];
//    [bgView setBackgroundColor:cherryPowder];
//    DrawViewBorderRadius(bgView, 1, 1, [UIColor blueColor]);
//    
//    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.insets = UIEdgeInsetsMake(52 *k5SWScale, 0, 49, 0);
//    }];
    
    
    int col = 2; //列
    CGFloat padding = 10 * k5SWScale;
    CGFloat itemW = (kScreenW - (col + 1)*padding)/col;
    CGFloat itemH = itemW *3 / 4;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //4 : 3
    layout.itemSize = CGSizeMake(itemW, itemH);
    
    layout.minimumLineSpacing = padding;
    layout.minimumInteritemSpacing = padding;
    layout.sectionInset = UIEdgeInsetsMake(0, padding, 0, padding);
    
    //[layout setHeaderReferenceSize:CGSizeMake(kScreenW, 40)]; //设置headview 的大小

    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = cherryPowder;//[UIColor whiteColor];
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:collectionView];

    collectionView.dataSource = self;
    collectionView.delegate = self;
    
  
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets = UIEdgeInsetsMake(52 *k5SWScale, 0, 49, 0);
    }];
    
//    collectionView.bouncesZoom = NO;
//    collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    collectionView.contentOffset = CGPointMake(0, 0);

    //注册cell
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"HomeCell"];
    
    //注册段头
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeSectionHeader"];
    
    //DrawViewBorderRadius(collectionView, 1, 1, [UIColor brownColor]);
    
}



#pragma mark - Action


#pragma mark - coll
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 5;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdent = @"HomeCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdent forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    DrawViewBorderRadius(cell, 1, 1, [UIColor redColor]);
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *sectionHeader = @"HomeSectionHeader";
    
    UICollectionReusableView *reusableView = nil;
    
    //注意此处作对比的是kind和UICollectionElementKindSectionHeader/UICollectionElementKindSectionFooter
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        //NSLog(@"Home Section");
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:sectionHeader forIndexPath:indexPath];
        
        reusableView.backgroundColor = [UIColor whiteColor];
        
        CGFloat padding = kSectionHeaderH/3;

        if (reusableView)
        {
            if (indexPath.section == 0)
            {
                //创建轮播
                UIView *view = [[UIView alloc]init];
                [reusableView addSubview:view];
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                
                    make.top.left.right.equalTo(reusableView);
                    make.height.mas_equalTo(100 *k5SWScale);
                }];
                
                DrawViewBorderRadius(view, 1, 1, [UIColor brownColor]);
            }
            UIImageView *logImgView = [[UIImageView alloc]init];
            [reusableView addSubview:logImgView];
            
            UILabel *titleLabel = [[UILabel alloc]init];
            [reusableView addSubview:titleLabel];
            
            [logImgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(padding);
                make.bottom.mas_equalTo(- padding);
                make.width.height.mas_equalTo(padding);
            }];
            
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.mas_equalTo(logImgView.mas_top);
                make.left.mas_equalTo(logImgView.mas_right).offset(padding/2);
                make.bottom.right.mas_equalTo(- padding);
            }];
            
            DrawViewBorderRadius(logImgView, 1, 1, [UIColor greenColor]);

            DrawViewBorderRadius(titleLabel, 1, 1, [UIColor blackColor]);
        }
    }
    
    
    DrawViewBorderRadius(reusableView, 1, 1, [UIColor blueColor]);
    
    return reusableView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(kScreenW, (section == 0)? (100 *k5SWScale + kSectionHeaderH):kSectionHeaderH);
}

//表头 100

@end
