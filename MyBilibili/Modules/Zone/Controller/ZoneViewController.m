//
//  ZoneViewController.m
//  MyBilibili
//
//  Created by Hubin_Huang on 16/9/24.
//  Copyright © 2016年 Hubin_Huang. All rights reserved.
//

#import "ZoneViewController.h"
#import "TitleView.h"

@interface ZoneViewController ()

@end

@implementation ZoneViewController

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
        make.height.mas_equalTo(@52);
    }];
    
    TitleView *titleView = [[TitleView alloc]initWithFrame:CGRectMake(kScreenW * 2/9, 20 *k5SWScale, kScreenW * 5/9, 32 * k5SWScale) andTitles:@[@"分区"]];
    [naviBar addSubview:titleView];
    titleView.backgroundColor = [UIColor clearColor];
    
    
//    UILabel *titleLabel = [[UILabel alloc] init];
//    //WithFrame:CGRectMake(0, 0, kScreenW, 44)];
//    [naviBar addSubview:titleLabel];
//    titleLabel.text = @"分区";
//    titleLabel.font = [UIFont systemFontOfSize:14];
//    titleLabel.textColor = [UIColor whiteColor]; //可变更
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(@(20 *k5SWScale));
//        make.bottom.equalTo(naviBar).offset(-5 * k5SWScale);
//        //make.height.mas_equalTo(@(20 * k5SWScale));
//        make.width.mas_equalTo(titleLabel.mas_height).multipliedBy(2);
//        make.centerX.equalTo(naviBar);
//    }];
}

@end
