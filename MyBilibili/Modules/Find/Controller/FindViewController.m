//
//  FindViewController.m
//  MyBilibili
//
//  Created by Hubin_Huang on 16/9/24.
//  Copyright © 2016年 Hubin_Huang. All rights reserved.
//

#import "FindViewController.h"

@interface FindViewController ()

@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    [self initNavi];
}

#pragma mark - Setup
- (void)initNavi
{
    UIView *naviBar = [[UIView alloc] init];
    [self.view addSubview:naviBar];
    
    naviBar.backgroundColor = cherryPowder;
    
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

@end
