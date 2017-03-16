//
//  StyleButtom.h
//  MyStyleBtnDemo
//
//  Created by Hubin_Huang on 2017/3/16.
//  Copyright © 2017年 Hubin_Huang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface StyleButton : UIButton

/**
 按钮图文显示风格

 - UIButtonLeftRightStyle: 图左文右
 - UIButtonTopBottomStyle: 图上文下
 - UIButtonRightLeftStyle: 图右文左
 - UIButtonBottomTopStyle: 图下文上
 */
typedef NS_ENUM(NSInteger, UIButtonStyle)
{
    UIButtonLeftRightStyle = 0,
    UIButtonTopBottomStyle = 1,
    UIButtonRightLeftStyle = 2,
    UIButtonBottomTopStyle = 3,
};


@property (nonatomic,readwrite) UIButtonStyle myStyle;  //图文样式
@property (nonatomic,readwrite) CGFloat ratio;  //设置图片的相对切分比例 0~1

@end
