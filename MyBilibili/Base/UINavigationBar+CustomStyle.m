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
    naviBar.barTintColor = cherryPowder;
 
    switch (style)
    {
        case SCROLL_STYPLE:
        {
            [naviBar mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(kScreenW);
                make.height.mas_equalTo(@44);
            }];
            
//            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 44)];
//            [naviBar addSubview:titleLabel];
//            titleLabel.text = @"SCROLL_STYPLE";
//            titleLabel.textAlignment = NSTextAlignmentCenter;
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
                    make.height.mas_equalTo(@(20 * k5SWScale));
                }];
                
                [titleFlag mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(naviBar).offset(kScreenW * 2/9);
                    make.top.equalTo(titleBtn.mas_bottom).offset(2);
                    make.bottom.equalTo(naviBar.mas_bottom).offset(-2);
                    make.width.equalTo(titleBtn.mas_width);
                    make.height.mas_equalTo(@1);
                }];
                
                [titleBtn setTitle:titles[i] forState:UIControlStateNormal];
                titleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
                
                [titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                [titleFlag setBackgroundColor:[UIColor whiteColor]];
            }
            
        }
            break;
        case STATIC_STYPLE:
        {
            [naviBar mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(kScreenW);
                make.height.mas_equalTo(@44);
            }];
            
            UILabel *titleLabel = [[UILabel alloc] init];
            //WithFrame:CGRectMake(0, 0, kScreenW, 44)];
            [naviBar addSubview:titleLabel];
            titleLabel.text = @"分区";
            titleLabel.font = [UIFont systemFontOfSize:14];
            titleLabel.textColor = [UIColor whiteColor]; //可变更
            titleLabel.textAlignment = NSTextAlignmentCenter;
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(naviBar).offset(-5 * k5SWScale);
                make.height.mas_equalTo(@(20 * k5SWScale));
                make.width.mas_equalTo(titleLabel.mas_height).multipliedBy(2);
                make.centerX.equalTo(naviBar);
            }];
        }
            break;
        case SEARCH_STYPLE:
        {
            [naviBar mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(kScreenW);
                make.height.mas_equalTo(170);
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
        {
            [naviBar mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(kScreenW);
                make.height.mas_equalTo(130);
            }];
            
            UIImageView *settingImgView = [[UIImageView alloc] init];
            [naviBar addSubview:settingImgView];
            settingImgView.image = [UIImage imageNamed:@"mine_settings"];
            [settingImgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(naviBar.mas_top).offset(25 * k5SWScale);
                make.right.equalTo(naviBar.mas_right).offset(-5 * k5SWScale);
                make.width.height.mas_equalTo(@(20 * k5SWScale));
            }];
            
            
            UIButton *signInBtn = [[UIButton alloc]init];
            UIButton *loginBtn  = [[UIButton alloc]init];
            [naviBar addSubview:signInBtn];
            [naviBar addSubview:loginBtn];
            
            [signInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                //make.left.mas_equalTo(@(50 *k5SWScale));
                //make.centerX.mas_equalTo(naviBar).offset((signInBtn.mas_width)-10 *k5SWScale);
                make.trailing.mas_equalTo(naviBar.mas_centerX).offset(-10 *k5SWScale);
                
                make.height.mas_equalTo(@(40 *k5SWScale));
                make.centerY.equalTo(naviBar).offset(10 *k5SWScale);
                make.width.mas_equalTo(signInBtn.mas_height).multipliedBy(2);
            }];
            
            [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                //make.centerX.mas_equalTo(naviBar).offset(10 *k5SWScale);
                
                make.leading.mas_equalTo(naviBar.mas_centerX).offset(10 *k5SWScale);
                make.width.mas_equalTo(signInBtn);
                make.height.mas_equalTo(signInBtn);
                make.centerY.equalTo(signInBtn);
                //make.left.mas_equalTo(signInBtn.mas_right).offset(10 *k5SWScale);
            }];
            DrawViewBorderRadius(signInBtn, 5, 1, [UIColor clearColor]);
            DrawViewBorderRadius(loginBtn, 5, 1, [UIColor clearColor]);

            [signInBtn setTitle:@"注册" forState:UIControlStateNormal];
            [signInBtn setBackgroundColor:cherryPowder];
            [signInBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
            [loginBtn setBackgroundColor:[UIColor whiteColor]];
            [loginBtn setTitleColor:cherryPowder forState:UIControlStateNormal];
            
        }
            break;
            
        default:
            break;
    }
    
    return naviBar;
}

@end
