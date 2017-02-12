//
//  FollowViewController.m
//  MyBilibili
//
//  Created by Hubin_Huang on 16/9/24.
//  Copyright © 2016年 Hubin_Huang. All rights reserved.
//

#import "FollowViewController.h"

@interface FollowViewController ()

@end

@implementation FollowViewController

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
    
    //测试
    NSArray *titles = @[@"直播",@"推荐",@"番剧"];
    
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
        
        titleBtn.tag = 300 + i;
        [titleBtn addTarget:self action:@selector(changeTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
}


#pragma mark - Action
- (void)changeTitleBtn:(UIButton *)sender
{
    NSLog(@"Follow-title%@",sender.titleLabel.text);
}

@end
