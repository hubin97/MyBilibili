//
//  HomeViewController.m
//  MyBilibili
//
//  Created by Hubin_Huang on 16/9/24.
//  Copyright © 2016年 Hubin_Huang. All rights reserved.
//

#import "HomeViewController.h"
#import "TitleView.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

#pragma mark - Live life
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //DrawViewBorderRadius(self.view, 0, 2, [UIColor redColor]);
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
        make.height.mas_equalTo(@(52 *k5SWScale));
    }];
    
    TitleView *titleView = [[TitleView alloc]initWithFrame:CGRectMake(kScreenW * 2/9, 20 *k5SWScale, kScreenW * 5/9, 32 * k5SWScale) andTitles:@[@"直播",@"推荐",@"番剧"]];
    [naviBar addSubview:titleView];
    titleView.backgroundColor = [UIColor clearColor];
    
    titleView.titleBtnBlock = ^(NSInteger index, NSString *title){
    
        NSLog(@"Vc-- index:%ld, title:%@", (long)index,title);

    };
    

#if 0
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
            make.left.equalTo(naviBar).offset(kScreenW * 2/9 * (i + 1));
            make.top.equalTo(titleBtn.mas_bottom).offset(2);
            make.bottom.equalTo(naviBar.mas_bottom).offset(-1);
            make.width.equalTo(titleBtn.mas_width);
            make.height.mas_equalTo(@2);
        }];
        
        [titleBtn setTitle:titles[i] forState:UIControlStateNormal];
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       
        //默认选择第一个
        [titleFlag setBackgroundColor:((i == 1)?[UIColor whiteColor] : [UIColor clearColor])];
        
        titleBtn.tag  = 100 + i;
        titleFlag.tag = 110 + i;
        [titleBtn addTarget:self action:@selector(changeTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
#endif
    
}


#pragma mark - Action
//- (void)changeTitleBtn:(UIButton *)sender
//{
//    NSLog(@"Home-title%@",sender.titleLabel.text);
//    
//    for (int i = 110 ; i < 113; i ++)
//    {
//        UILabel *titleFlag = [self.view viewWithTag:i];
//        //NSLog(@"titleFlag:%@",titleFlag);
//        [titleFlag setBackgroundColor:((i == (sender.tag + 10))?[UIColor whiteColor] : [UIColor clearColor])];
//    }
//}

@end
