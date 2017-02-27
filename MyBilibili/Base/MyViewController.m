//
//  MyViewController.m
//  MyBilibili
//
//  Created by Mac on 2017/2/24.
//  Copyright © 2017年 Hubin_Huang. All rights reserved.
//

#import "MyViewController.h"
#import "TitleView.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNaviWithTitles:_titles];
}

- (void)initNaviWithTitles:(NSArray *)titles
{
    //WS(ws);
    
    UIView *naviBar = [[UIView alloc] init];
    [self.view addSubview:naviBar];
    
    naviBar.backgroundColor = cherryPowder;
    
    [naviBar mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.top.left.equalTo(ws);
        make.width.mas_equalTo(kScreenW);
        make.height.mas_equalTo(@(52 *k5SWScale));
    }];
    
    if (titles.count > 0)
    {
        TitleView *titleView = [[TitleView alloc]initWithFrame:CGRectMake(kScreenW * 2/9, 20 *k5SWScale, kScreenW * 5/9, 32 * k5SWScale) andTitles:titles];
        [naviBar addSubview:titleView];
        titleView.backgroundColor = [UIColor clearColor];
    }
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.edges.insets(UIEdgeInsetsMake(20 *k5SWScale, 0, 5 *k5SWScale, 0));
        make.left.equalTo(naviBar).offset(10 *k5SWScale);
        make.top.equalTo(naviBar.mas_top).offset(20 *k5SWScale);
        make.bottom.equalTo(naviBar.mas_bottom).offset(- 5 *k5SWScale);
        make.width.mas_equalTo(40 *k5SWScale);
    }];
    
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    //DrawViewBorderRadius(backBtn, 1, 1, [UIColor whiteColor]);
}


- (void)backBtnClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
