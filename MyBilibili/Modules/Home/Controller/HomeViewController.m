//
//  HomeViewController.m
//  MyBilibili
//
//  Created by Hubin_Huang on 16/9/24.
//  Copyright © 2016年 Hubin_Huang. All rights reserved.
//

#import "HomeViewController.h"
#import "TitleView.h"
#import "SDCycleScrollView.h"

#import "HomeSectionModel.h"
#import "HomeBannerModel.h"
#import "HomeCellModel.h"

#define kSectionHeaderH (40 * k5SWScale)

@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,SDCycleScrollViewDelegate>
{
    TitleView *_titleView;
    
    UICollectionView *_homeCollectionView;
    
    NSMutableArray *_dataArray;
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
    _dataArray = [[NSMutableArray alloc]init];
    
    [self sendRequest];
    

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

    
    _homeCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    _homeCollectionView.backgroundColor = [UIColor whiteColor];
    _homeCollectionView.showsHorizontalScrollIndicator = NO;
    _homeCollectionView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:_homeCollectionView];

    _homeCollectionView.dataSource = self;
    _homeCollectionView.delegate = self;
    
  
    [_homeCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets = UIEdgeInsetsMake(52 *k5SWScale, 0, 49, 0);
    }];
    
    //注册cell
    [_homeCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"HomeCell"];
    
    //注册段头
    [_homeCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeSectionHeader"];
    
    [_homeCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"HomeSectionFooter"];

    
    //DrawViewBorderRadius(collectionView, 1, 1, [UIColor brownColor]);
    
}

#pragma mark - Private
- (void)sendRequest
{
    NSString *homeUrlString = @"http://app.bilibili.com/x/v2/show?access_key=f5bd4e793b82fba5aaf5b91fb549910a&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3470&channel=appstore&device=phone&mobi_app=iphone&plat=1&platform=ios&sign=1c8f22ff72d7cab05a94eb8b12a4c4cc&ts=1469603875&warm=1";
    
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    
    [manage GET:homeUrlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSLog(@"responseObject:%@",responseObject);
        
        NSArray *tmpDataArr = [responseObject objectForKey:@"data"];
        
        for (NSDictionary *tempDict in tmpDataArr)
        {
            HomeSectionModel *homeSectionModel = [HomeSectionModel mj_objectWithKeyValues:tempDict];
            [_dataArray addObject:homeSectionModel];
        }
        
        [_homeCollectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
    }];
}

#pragma mark - Action


#pragma mark - coll
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [_dataArray count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    HomeSectionModel *homeSectionModel = [_dataArray objectAtIndex:section];
    return [homeSectionModel.body count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdent = @"HomeCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdent forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    //测试数据
    UIImageView *imageView = [[UIImageView alloc]init];
    [cell addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    
    HomeSectionModel *homeSectionModel = [_dataArray objectAtIndex:indexPath.section];
    HomeCellModel *homeCellModel =  [HomeCellModel mj_objectWithKeyValues:[homeSectionModel.body objectAtIndex:indexPath.row]];
    
    //NSLog(@"urlString:%@",homeCellModel.cover);
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:homeCellModel.cover] placeholderImage:nil];
    
    DrawViewBorderRadius(cell, 1, 1, [UIColor redColor]);
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *sectionHeader = @"HomeSectionHeader";
    static NSString *sectionFooter = @"HomeSectionFooter";

    UICollectionReusableView *reusableView = nil;
    
    //注意此处作对比的是kind和UICollectionElementKindSectionHeader/UICollectionElementKindSectionFooter
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        //NSLog(@"Home Section");
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:sectionHeader forIndexPath:indexPath];
        
        reusableView.backgroundColor = [UIColor whiteColor];
        
        CGFloat padding = kSectionHeaderH/3;

        
#warning reusableView后续封装
        if (reusableView)
        {
            //判断是否有标题栏
            //BOOL isHaveBanner = [[[_dataArray objectAtIndex:indexPath.section] allKeys] containsObject:@"banner"];
            
            HomeSectionModel *homeSectionModel = [_dataArray objectAtIndex:indexPath.section];
            
            BOOL isHaveBanner = (homeSectionModel.banner)? YES : NO;

            if (isHaveBanner)
            {
                //判断是否有顶部标题栏
                //BOOL isHaveTopBanner = [[[[_dataArray objectAtIndex:indexPath.section] objectForKey:@"banner"] allKeys] containsObject:@"top"];

                BOOL isHaveTopBanner = [[homeSectionModel.banner allKeys] containsObject:@"top"];

                if(isHaveTopBanner)
                {
                    //创建轮播
                    UIView *view = [[UIView alloc]init];
                    [reusableView addSubview:view];
                    [view mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.top.left.right.equalTo(reusableView);
                        make.height.mas_equalTo(100 *k5SWScale);
                    }];
                    
                    DrawViewBorderRadius(view, 1, 1, [UIColor brownColor]);
                    
                    NSMutableArray *imgUrlStrings = [[NSMutableArray alloc]init];
                    
                    NSArray *imgInfos = [homeSectionModel.banner objectForKey:@"top"];
                    
                    for (NSDictionary *imgDict in imgInfos)
                    {
                        HomeBannerModel *homeBannerModel = [HomeBannerModel mj_objectWithKeyValues:imgDict];
                        //[imgUrlStrings addObject:[imgDict objectForKey:@"image"]];
                        [imgUrlStrings addObject:homeBannerModel.image];
                    }
                    
                    SDCycleScrollView *scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero imageURLStringsGroup:imgUrlStrings];
                    scrollView.delegate = self;
                    [view addSubview:scrollView];
                    
                    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.edges.insets(UIEdgeInsetsZero);
                    }];
                    
                    scrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
                    scrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
                }
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
            //DrawViewBorderRadius(titleLabel, 1, 1, [UIColor blackColor]);
            
            titleLabel.text =  homeSectionModel.title;
            titleLabel.textAlignment = NSTextAlignmentLeft;
            titleLabel.textColor = [UIColor blackColor];
            titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
        }
        DrawViewBorderRadius(reusableView, 1, 1, [UIColor blueColor]);
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter])
    {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:sectionFooter forIndexPath:indexPath];
        reusableView.backgroundColor = [UIColor whiteColor];
        
        DrawViewBorderRadius(reusableView, 1, 1, [UIColor greenColor]);
    }
    
    return reusableView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    //判断是否有标题栏
    HomeSectionModel *homeSectionModel = [_dataArray objectAtIndex:section];
    
    BOOL isHaveBanner = (homeSectionModel.banner)? YES : NO;

    if (isHaveBanner)
    {
        //判断是否有顶部标题栏
        BOOL isHaveTopBanner = [[homeSectionModel.banner allKeys] containsObject:@"top"];

        if(isHaveTopBanner) NSLog(@"section:%ld--isHaveTopBanner",section);
        
        return CGSizeMake(kScreenW, (isHaveTopBanner)? (100 *k5SWScale + kSectionHeaderH):kSectionHeaderH);
    }
    return CGSizeMake(kScreenW, kSectionHeaderH);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    //判断是否有标题栏
    //BOOL isHaveBanner = [[[_dataArray objectAtIndex:section] allKeys] containsObject:@"banner"];
    
    HomeSectionModel *homeSectionModel = [_dataArray objectAtIndex:section];
    
    BOOL isHaveBanner = (homeSectionModel.banner)? YES : NO;
    
    if (isHaveBanner)
    {
//        BOOL isHaveBottomBanner = [[[[_dataArray objectAtIndex:section] objectForKey:@"banner"] allKeys] containsObject:@"bottom"];

        BOOL isHaveBottomBanner = [[homeSectionModel.banner allKeys] containsObject:@"bottom"];

        if(isHaveBottomBanner)
        {
            NSLog(@"section:%ld--isHaveBottomBanner",section);
            return CGSizeMake(kScreenW, 100 *k5SWScale);
        }
        
        return CGSizeZero;
    }
    return CGSizeZero;
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"cycleScrollView:%@---index:%ld",cycleScrollView,(long)index);
}

@end
