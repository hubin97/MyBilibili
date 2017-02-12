//
//  UINavigationBar+CustomStyle.h
//  MyBilibili
//
//  Created by Hubin_Huang on 16/10/22.
//  Copyright © 2016年 Hubin_Huang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    SCROLL_STYPLE   = 0, //home,follow
    STATIC_STYPLE   = 1, //zone
    SEARCH_STYPLE   = 2, //find
    SETTING_STYPLE  = 3  //mine
}MyNaviBarStyle;


@interface UINavigationBar (CustomStyle)
//tag  100~200


+ (UINavigationBar *)initNavigationBarWithTitleArrs:(NSArray *)titles AndStyple:(MyNaviBarStyle)style;


@end
