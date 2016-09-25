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
        
        BaseNavigationController *homeNavic   = [[BaseNavigationController alloc]initWithRootViewController:homeVc];
        BaseNavigationController *zoneNavic   = [[BaseNavigationController alloc]initWithRootViewController:zoneVc];
        BaseNavigationController *followNavic = [[BaseNavigationController alloc]initWithRootViewController:followVc];
        BaseNavigationController *findNavic   = [[BaseNavigationController alloc]initWithRootViewController:findVc];
        BaseNavigationController *mineNavic   = [[BaseNavigationController alloc]initWithRootViewController:mineVc];
        
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

//设置强制横屏
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return toInterfaceOrientation == UIInterfaceOrientationPortrait;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
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
