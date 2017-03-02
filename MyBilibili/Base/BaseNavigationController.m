//
//  BaseNavigationController.m
//  MyBilibili
//
//  Created by Hubin_Huang on 16/9/24.
//  Copyright © 2016年 Hubin_Huang. All rights reserved.
//

#import "BaseNavigationController.h"
#import "UINavigationBar+CustomStyle.h"

#import "HomeViewController.h"
#import "ZoneViewController.h"
#import "FollowViewController.h"
#import "FindViewController.h"
#import "MineViewController.h"


@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (id)initWithRootViewController:(UIViewController *)rootViewController andFlagVcIndex:(NSInteger)flag
{
    if (self = [super initWithRootViewController:rootViewController])
    {
        self.navigationBar.hidden = YES;
        
//无效
//        rootViewController.view.frame = CGRectMake(0, 44, kScreenW, kScreenH -44 - 49);
        
        
//        NSLog(@"flag%ld",(long)flag);
        
        UIView *aView = nil;

        switch (flag)
        {
            case 0: case 2: //home follow
            {
               aView = [UINavigationBar initNavigationBarWithTitleArrs:nil AndStyple:SCROLL_STYPLE];
            }
                break;
            case 1: //zone
            {
               aView = [UINavigationBar initNavigationBarWithTitleArrs:nil AndStyple:STATIC_STYPLE];
            }
                break;
            case 3: //find
            {
                aView = [UINavigationBar initNavigationBarWithTitleArrs:nil AndStyple:SEARCH_STYPLE];
            }
                break;
            case 4: //mine
            {
                aView = [UINavigationBar initNavigationBarWithTitleArrs:nil AndStyple:SETTING_STYPLE];
            }
                break;
                
            default:
                break;
        }
        
        [rootViewController.view addSubview:aView];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//设置状态栏
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return self.topViewController.preferredStatusBarStyle;
}

- (BOOL)prefersStatusBarHidden
{
    return self.topViewController.prefersStatusBarHidden;
}

- (BOOL)shouldAutorotate
{
    return self.topViewController.shouldAutorotate;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return self.topViewController.preferredInterfaceOrientationForPresentation;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return self.topViewController.supportedInterfaceOrientations;
}

@end
