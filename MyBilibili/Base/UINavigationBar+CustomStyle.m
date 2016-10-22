//
//  UINavigationBar+CustomStyle.m
//  MyBilibili
//
//  Created by Hubin_Huang on 16/10/22.
//  Copyright © 2016年 Hubin_Huang. All rights reserved.
//

#import "UINavigationBar+CustomStyle.h"

@implementation UINavigationBar (CustomStyle)

+ (UINavigationBar *)initNavigationBarWithTitleArrs:(NSArray *)titles AndStyple:(MyNaviBarStyle)style
{
    WS(ws);
    
    UINavigationBar *naviBar = [[UINavigationBar alloc] init];
    
    [naviBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenW);
        make.height.mas_equalTo(@44);
    }];
    naviBar.barTintColor = cherryPowder;
    
    
//    UILabel *titleLabel = [[UILabel alloc] init];//WithFrame:CGRectMake(0, 0, kScreenW, 44)];
//    [naviBar addSubview:titleLabel];
//    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.top.equalTo(ws).offset(25);
////        //make.left.right.equalTo(ws);
////        make.bottom.equalTo(ws).offset(-5);
////        make.width.equalTo(ws).multipliedBy(3/5);
//        
//        make.edges.equalTo(ws).insets(UIEdgeInsetsMake(25, kScreenW * 1/5, -5, -(kScreenW * 1/5)));
//        make.center.equalTo(ws);
//        //                make.top.left.bottom.right.equalTo(ws);
//    }];
//    titleLabel.text = @"HOME";
//    
    
    switch (style)
    {
        case SCROLL_STYPLE:
        {
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 44)];
            [naviBar addSubview:titleLabel];
            titleLabel.text = @"SCROLL_STYPLE";
            titleLabel.textAlignment = NSTextAlignmentCenter;
        }
            break;
        case STATIC_STYPLE:
        {
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 44)];
            [naviBar addSubview:titleLabel];
            titleLabel.text = @"STATIC_STYPLE";
            titleLabel.textAlignment = NSTextAlignmentCenter;
        }
            break;
        case SEARCH_STYPLE:
        {
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 44)];
            [naviBar addSubview:titleLabel];
            titleLabel.text = @"SEARCH_STYPLE";
            titleLabel.textAlignment = NSTextAlignmentCenter;

        }
            break;
        case SETTING_STYPLE:
        {
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 44)];
            [naviBar addSubview:titleLabel];
            titleLabel.text = @"SETTING_STYPLE";
            titleLabel.textAlignment = NSTextAlignmentCenter;
        }
            break;
            
        default:
            break;
    }
    
    return naviBar;
}

@end
