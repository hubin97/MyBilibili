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
    UINavigationBar *naviBar = [[UINavigationBar alloc] init];
    
#if 0  //后续做封装

    naviBar.barTintColor = cherryPowder;
    naviBar.translucent = NO;

//    naviBar.layer.borderWidth = 2;
//    naviBar.layer.borderColor = cherryPowder.CGColor;
    
    switch (style)
    {
        case SCROLL_STYPLE:
        {
            [naviBar mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(kScreenW);
                make.height.mas_equalTo(@52);
            }];
            
            //测试
            titles = @[@"直播",@"推荐",@"番剧"];
            
            for (int i = 0; i < [titles count]; i ++)
            {
                UIButton *titleBtn = [[UIButton alloc] init];
                [naviBar addSubview:titleBtn];
                UILabel *titleFlag = [[UILabel alloc]init];
                [naviBar addSubview:titleFlag];

                [titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(@(20 *k5SWScale));
                    make.left.equalTo(naviBar).offset(kScreenW * 2/9  * (i + 1));
                    make.width.mas_equalTo(@(kScreenW *1/9));
                }];
                
                [titleFlag mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(naviBar).offset(kScreenW * 2/9);
                    make.top.equalTo(titleBtn.mas_bottom).offset(2);
                    make.bottom.equalTo(naviBar.mas_bottom).offset(-1);
                    make.width.equalTo(titleBtn.mas_width);
                    make.height.mas_equalTo(@2);
                }];
                
                [titleBtn setTitle:titles[i] forState:UIControlStateNormal];
                titleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
                
                [titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

                [titleFlag setBackgroundColor:[UIColor whiteColor]];

                
                //此处添加方法有问题???
//                titleBtn.tag = 100 + i;
//                [titleBtn addTarget:self action:@selector(changeTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
                
                
                
            }
            
        }
            break;
        case STATIC_STYPLE:
        {
            [naviBar mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(kScreenW);
                make.height.mas_equalTo(@52);
            }];
            
            UILabel *titleLabel = [[UILabel alloc] init];
            //WithFrame:CGRectMake(0, 0, kScreenW, 44)];
            [naviBar addSubview:titleLabel];
            titleLabel.text = @"分区";
            titleLabel.font = [UIFont systemFontOfSize:14];
            titleLabel.textColor = [UIColor whiteColor]; //可变更
            titleLabel.textAlignment = NSTextAlignmentCenter;
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(@(20 *k5SWScale));
                make.bottom.equalTo(naviBar).offset(-5 * k5SWScale);
                //make.height.mas_equalTo(@(20 * k5SWScale));
                make.width.mas_equalTo(titleLabel.mas_height).multipliedBy(2);
                make.centerX.equalTo(naviBar);
            }];
        }
            break;
        case SEARCH_STYPLE:
        {
            [naviBar mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(kScreenW);
                make.height.mas_equalTo(@237);
            }];
            
            UIButton *qrCodeBtn = [[UIButton alloc]init];
            [naviBar addSubview:qrCodeBtn];
            
            UITextField *searchBar  = [[UITextField alloc] init];
            UIImageView *searchIcon = [[UIImageView alloc] init];
            [naviBar addSubview:searchBar];
            [searchBar addSubview:searchIcon];
            
            [qrCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(naviBar).offset(10 *k5SWScale);
                make.top.equalTo(naviBar).offset(25 *k5SWScale);
                make.width.height.mas_equalTo(@(25 *k5SWScale));
            }];
            
            [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(qrCodeBtn.mas_right).offset(10 *k5SWScale);
                make.right.equalTo(naviBar.mas_right).offset(-10 *k5SWScale);
                make.height.mas_equalTo(qrCodeBtn.mas_height);
                make.centerY.equalTo(qrCodeBtn);
            }];
            
            [searchIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(searchBar.mas_left).offset(5 *k5SWScale);
                make.width.height.mas_equalTo(@(20 *k5SWScale));
                make.centerY.equalTo(searchBar);
            }];
            
            
            [qrCodeBtn setBackgroundImage:[UIImage imageNamed:@"search_qr"] forState:UIControlStateNormal];
            
            DrawViewBorderRadius(searchBar, 3, 1, [UIColor clearColor]);
            
            searchIcon.image = [UIImage imageNamed:@"find_search_tf_left_btn"];
            searchBar.leftViewMode = UITextFieldViewModeAlways;
            searchBar.placeholder = @"搜索视频,番剧,up主或AV号";
            searchBar.textAlignment = NSTextAlignmentCenter;
            searchBar.font = [UIFont systemFontOfSize:14];
            searchBar.backgroundColor = [UIColor whiteColor];
            
            UILabel *searchLabel = [[UILabel alloc] init];
            [naviBar addSubview:searchLabel];
            
            [searchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(qrCodeBtn);
                make.top.equalTo(qrCodeBtn.mas_bottom).offset(10 *k5SWScale);
                make.height.mas_equalTo(@(20 *k5SWScale));
            }];
            searchLabel.text = @"大家都在搜";
            searchLabel.textColor = [UIColor whiteColor];
            searchLabel.textAlignment = NSTextAlignmentLeft;
            searchLabel.font = [UIFont systemFontOfSize:14];
        }
            break;
        case SETTING_STYPLE:
        {}
            break;
            
        default:
            break;
    }
    
#endif
    return naviBar;
}


@end
