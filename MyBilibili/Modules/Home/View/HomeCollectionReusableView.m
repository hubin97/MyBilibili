//
//  HomeCollectionReusableView.m
//  MyBilibili
//
//  Created by Mac on 2017/2/21.
//  Copyright © 2017年 Hubin_Huang. All rights reserved.
//

#import "HomeCollectionReusableView.h"
#import "SDCycleScrollView.h"

//static float kSectionHeaderH = 40.0f;//(40 * k5SWScale);
#define kSectionHeaderH (40 * k5SWScale)

@interface HomeCollectionReusableView()<SDCycleScrollViewDelegate>
{
    BOOL isHaveTopBanner;
    BOOL isHaveBottomBanner;
    NSMutableArray *_bannerDatas;
}
@end

@implementation HomeCollectionReusableView

- (void)layoutSectionHeaderViewWithModel:(HomeSectionModel *)model
{
    WS(ws);
    
    //解析model再布局
    [self analyzeIsHaveBannerWithModel:model];
    
    CGFloat padding = kSectionHeaderH/3;
    //消除复用
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if (self)
    {
        UIImageView *logImgView = [[UIImageView alloc]init];
        [self addSubview:logImgView];
        
        UILabel *titleLabel = [[UILabel alloc]init];
        [self addSubview:titleLabel];
        
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
        
        //DrawViewBorderRadius(logImgView, 1, 1, [UIColor greenColor]);
        //DrawViewBorderRadius(titleLabel, 1, 1, [UIColor blackColor]);
        
        if ([model.type isEqualToString:@"recommend"]) {
            logImgView.image = [UIImage imageNamed:@"hd_home_recommend"];
        }
        else if ([model.type isEqualToString:@"live"]) {
            logImgView.image = [UIImage imageNamed:@"hd_home_subregion_live"];
        }
        else if ([model.type isEqualToString:@"bangumi"]) {
            logImgView.image = [UIImage imageNamed:@"hd_home_subregion_live"];
        }
        else if ([model.type isEqualToString:@"region"]) {
            logImgView.image = [UIImage imageNamed: [NSString stringWithFormat:@"home_region_icon_%@", model.param]];
        }
        else if ([model.type isEqualToString:@"activity"]) {
            logImgView.image = [UIImage imageNamed:@"hd_home_subregion_live"];
        }
        else {
            logImgView.image = [UIImage imageNamed:@"hd_home_recommend"];
        }
        
        titleLabel.text =  model.title;
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
        
        
        if(isHaveTopBanner)
        {
            //创建轮播
            UIView *view = [[UIView alloc]init];
            [self addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.right.equalTo(ws);
                make.bottom.mas_equalTo(- kSectionHeaderH);
                make.height.mas_equalTo(100 *k5SWScale);
            }];
            
            //DrawViewBorderRadius(view, 1, 1, [UIColor brownColor]);
            
            _bannerDatas = [[NSMutableArray alloc]init];
            NSMutableArray *bannerImages = [[NSMutableArray alloc]init];

            NSArray *imgInfos = [model.banner objectForKey:@"top"];
            
            for (NSDictionary *imgDict in imgInfos)
            {
                HomeBannerModel *homeBannerModel = [HomeBannerModel mj_objectWithKeyValues:imgDict];
                [_bannerDatas addObject:homeBannerModel];
                [bannerImages addObject:homeBannerModel.image];
            }
            
            SDCycleScrollView *scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero imageURLStringsGroup:bannerImages];
            scrollView.delegate = self;
            [view addSubview:scrollView];
            
            [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.insets(UIEdgeInsetsZero);
            }];
            
            scrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
            scrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        }
    }
    //DrawViewBorderRadius(self, 1, 1, [UIColor blueColor]);
}

- (void)layoutSectionFooterViewWithModel:(HomeSectionModel *)model
{
    WS(ws);
    
    //[self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    BOOL isHaveBanner = (model.banner)? YES : NO;
    if(!isHaveBanner) return;
    
    //解析model再布局
    [self analyzeIsHaveBannerWithModel:model];
    
    //[self layoutTopOrBottomBannerWithModel:model];
    
    if(isHaveBottomBanner)
    {
        //创建轮播
        UIView *view = [[UIView alloc]init];
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.left.bottom.right.equalTo(ws);
        }];
        
        
        DrawViewBorderRadius(view, 1, 1, [UIColor brownColor]);
        
        _bannerDatas = [[NSMutableArray alloc]init];
        NSMutableArray *bannerImages = [[NSMutableArray alloc]init];
        NSArray *imgInfos = [model.banner objectForKey:@"bottom"];
        
        for (NSDictionary *imgDict in imgInfos)
        {
            HomeBannerModel *homeBannerModel = [HomeBannerModel mj_objectWithKeyValues:imgDict];
            [_bannerDatas addObject:homeBannerModel];
            [bannerImages addObject:homeBannerModel.image];
        }
        
        SDCycleScrollView *scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero imageURLStringsGroup:bannerImages];
        scrollView.delegate = self;
        [view addSubview:scrollView];
        
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsZero);
        }];
        
        scrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
        scrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    }
    
    //DrawViewBorderRadius(self, 1, 1, [UIColor greenColor]);
}


//获取是否有包含标题轮播栏(顶部还是底部)
- (void)analyzeIsHaveBannerWithModel:(HomeSectionModel *)model
{
    //是否存在Banner栏
    BOOL isHaveBanner = (model.banner)? YES : NO;
    
    //在顶部还是底部
    isHaveTopBanner = (isHaveBanner)?[[model.banner allKeys] containsObject:@"top"] : NO;
    isHaveBottomBanner = (isHaveBanner)?[[model.banner allKeys] containsObject:@"bottom"] : NO;
}

- (void)prepareForReuse
{
    
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"cycleScrollView:%@---index:%ld",cycleScrollView,(long)index);
    HomeBannerModel *homeBannerModel = [_bannerDatas objectAtIndex:index];
    
    self.pushBannerUrlBlock(homeBannerModel);
}

@end
