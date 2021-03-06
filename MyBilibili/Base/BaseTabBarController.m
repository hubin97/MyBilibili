//
//  BaseTabBarController.m
//  MyBilibili
//
//  Created by Hubin_Huang on 16/9/24.
//  Copyright © 2016年 Hubin_Huang. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"

#import "HomeViewController.h"
#import "ZoneViewController.h"
#import "FollowViewController.h"
#import "FindViewController.h"
#import "MineViewController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController


- (id)init
{
    if(self = [super init])
    {
        HomeViewController   *homeVc   = [[HomeViewController alloc]init];
        ZoneViewController   *zoneVc   = [[ZoneViewController alloc]init];
        FollowViewController *followVc = [[FollowViewController alloc]init];
        FindViewController   *findVc   = [[FindViewController alloc]init];
        MineViewController   *mineVc   = [[MineViewController alloc]init];
        
        
        homeVc.tabBarItem   = [[UITabBarItem alloc]initWithTitle:nil image:[self returnImgwithNstr:@"home_home_tab"]  selectedImage:[self returnImgwithNstr:@"home_home_tab_s"]];
        zoneVc.tabBarItem   = [[UITabBarItem alloc]initWithTitle:nil image:[self returnImgwithNstr:@"home_category_tab"] selectedImage:[self returnImgwithNstr:@"home_category_tab_s"]];
        followVc.tabBarItem = [[UITabBarItem alloc]initWithTitle:nil image:[self returnImgwithNstr:@"home_attention_tab"] selectedImage:[self returnImgwithNstr:@"home_attention_tab_s"]];
        findVc.tabBarItem   = [[UITabBarItem alloc]initWithTitle:nil image:[self returnImgwithNstr:@"home_discovery_tab"] selectedImage:[self returnImgwithNstr:@"home_discovery_tab_s"]];
        mineVc.tabBarItem   = [[UITabBarItem alloc]initWithTitle:nil image:[self returnImgwithNstr:@"home_mine_tab"] selectedImage:[self returnImgwithNstr:@"home_mine_tab_s"]];
        
        BaseNavigationController *homeNavic   = [[BaseNavigationController alloc] initWithRootViewController:homeVc]; //WithRootViewController:homeVc andFlagVcIndex:0];
        BaseNavigationController *zoneNavic   = [[BaseNavigationController alloc]initWithRootViewController:zoneVc]; //WithRootViewController:zoneVc andFlagVcIndex:1];
        BaseNavigationController *followNavic = [[BaseNavigationController alloc]initWithRootViewController:followVc];//WithRootViewController:followVc andFlagVcIndex:2];
        BaseNavigationController *findNavic   = [[BaseNavigationController alloc]initWithRootViewController:findVc]; //WithRootViewController:findVc andFlagVcIndex:3];
        BaseNavigationController *mineNavic   = [[BaseNavigationController alloc]initWithRootViewController:mineVc];
        
        homeNavic.navigationBar.hidden   = YES;
        zoneNavic.navigationBar.hidden   = YES;
        followNavic.navigationBar.hidden = YES;
        findNavic.navigationBar.hidden   = YES;
        mineNavic.navigationBar.hidden   = YES;

//        BaseNavigationController *homeNavic   = [[BaseNavigationController alloc] initWithRootViewController:homeVc andFlagVcIndex:0];
//        BaseNavigationController *zoneNavic   = [[BaseNavigationController alloc]initWithRootViewController:zoneVc andFlagVcIndex:1];
//        BaseNavigationController *followNavic = [[BaseNavigationController alloc]initWithRootViewController:followVc andFlagVcIndex:2];
//        BaseNavigationController *findNavic   = [[BaseNavigationController alloc]initWithRootViewController:findVc andFlagVcIndex:3];
//        BaseNavigationController *mineNavic   = [[BaseNavigationController alloc]initWithRootViewController:mineVc andFlagVcIndex:4];
        
        self.viewControllers = @[homeNavic,zoneNavic,followNavic,findNavic,mineNavic];
        self.toolbarItems    = @[homeVc.tabBarItem,zoneVc.tabBarItem,followVc.tabBarItem,findVc.tabBarItem,mineVc.tabBarItem];
        
        //设置tabBarItem位置偏移
        homeVc.tabBarItem.imageInsets   = UIEdgeInsetsMake(5, 0, -5, 0);
        zoneVc.tabBarItem.imageInsets   = UIEdgeInsetsMake(5, 0, -5, 0);
        followVc.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
        findVc.tabBarItem.imageInsets   = UIEdgeInsetsMake(5, 0, -5, 0);
        mineVc.tabBarItem.imageInsets   = UIEdgeInsetsMake(5, 0, -5, 0);
        
        
        return self;
    }
    return self;
}

- (UIImage *)returnImgwithNstr:(NSString *)imgName
{
    //去除渲染,使用默认图片
    return [[UIImage imageNamed:imgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//设置强制竖屏
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return self.selectedViewController.preferredStatusBarStyle;
}

- (BOOL)prefersStatusBarHidden
{
    return self.selectedViewController.prefersStatusBarHidden;
}

- (BOOL)shouldAutorotate
{
    return self.selectedViewController.shouldAutorotate;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return self.selectedViewController.preferredInterfaceOrientationForPresentation;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return self.selectedViewController.supportedInterfaceOrientations;
}

@end
