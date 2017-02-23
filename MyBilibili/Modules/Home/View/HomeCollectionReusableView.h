//
//  HomeCollectionReusableView.h
//  MyBilibili
//
//  Created by Mac on 2017/2/21.
//  Copyright © 2017年 Hubin_Huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeSectionModel.h"
#import "HomeBannerModel.h"

@interface HomeCollectionReusableView : UICollectionReusableView

- (void)layoutSectionHeaderViewWithModel:(HomeSectionModel *)model;

- (void)layoutSectionFooterViewWithModel:(HomeSectionModel *)model;


@end
