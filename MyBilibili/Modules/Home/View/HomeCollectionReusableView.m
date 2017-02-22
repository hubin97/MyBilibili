//
//  HomeCollectionReusableView.m
//  MyBilibili
//
//  Created by Mac on 2017/2/21.
//  Copyright © 2017年 Hubin_Huang. All rights reserved.
//

#import "HomeCollectionReusableView.h"
#import "SDCycleScrollView.h"

static float kSectionHeaderH = 40.0f;//(40 * k5SWScale);

@interface HomeCollectionReusableView()<SDCycleScrollViewDelegate>

@end

@implementation HomeCollectionReusableView

- (void)layoutSectionViewWithModel:(HomeSectionModel *)model
{
    WS(ws);
    
    CGFloat padding = kSectionHeaderH/3;

    //判断是否有标题栏
    BOOL isHaveBanner = (model.banner)? YES : NO;
    if (isHaveBanner)
    {
        //判断是否有顶部或底部标题栏
        BOOL isHaveTopBanner = [[model.banner allKeys] containsObject:@"top"];
        BOOL isHaveBottomBanner = [[model.banner allKeys] containsObject:@"bottom"];
        
        if(isHaveTopBanner || isHaveBottomBanner)
        {
            //创建轮播
            UIView *view = [[UIView alloc]init];
            [self addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.left.right.equalTo(ws);
                make.height.mas_equalTo(100 *k5SWScale);
            }];
            
            DrawViewBorderRadius(view, 1, 1, [UIColor brownColor]);
            
            NSMutableArray *imgUrlStrings = [[NSMutableArray alloc]init];
            
            NSArray *imgInfos = [model.banner objectForKey:@"top"];
            
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

    
    //========title ==========
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
    
    DrawViewBorderRadius(logImgView, 1, 1, [UIColor greenColor]);
    //DrawViewBorderRadius(titleLabel, 1, 1, [UIColor blackColor]);
    
    titleLabel.text =  model.title;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
    //===============
    
    
    
//        }

//        if (isHaveBottomBanner)
//        {
//            //创建轮播
//            UIView *view = [[UIView alloc]init];
//            [self addSubview:view];
//            [view mas_makeConstraints:^(MASConstraintMaker *make) {
//                
//                make.top.left.right.equalTo(ws);
//                make.height.mas_equalTo(100 *k5SWScale);
//            }];
//            
//            DrawViewBorderRadius(view, 1, 1, [UIColor brownColor]);
//            
//            NSMutableArray *imgUrlStrings = [[NSMutableArray alloc]init];
//            
//            NSArray *imgInfos = [model.banner objectForKey:@"top"];
//            
//            for (NSDictionary *imgDict in imgInfos)
//            {
//                HomeBannerModel *homeBannerModel = [HomeBannerModel mj_objectWithKeyValues:imgDict];
//                //[imgUrlStrings addObject:[imgDict objectForKey:@"image"]];
//                [imgUrlStrings addObject:homeBannerModel.image];
//            }
//            
//            SDCycleScrollView *scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero imageURLStringsGroup:imgUrlStrings];
//            scrollView.delegate = self;
//            [view addSubview:scrollView];
//            
//            [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.edges.insets(UIEdgeInsetsZero);
//            }];
//            
//            scrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
//            scrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
//        }
}


- (void)prepareForReuse
{
    
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"cycleScrollView:%@---index:%ld",cycleScrollView,(long)index);
}

@end
