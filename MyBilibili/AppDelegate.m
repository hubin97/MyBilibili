//
//  AppDelegate.m
//  MyBilibili
//
//  Created by Hubin_Huang on 16/9/15.
//  Copyright © 2016年 Hubin_Huang. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabBarController.h"
#import "BaseNavigationController.h"

#import "HomeViewController.h"
#import "ZoneViewController.h"
#import "FollowViewController.h"
#import "FindViewController.h"
#import "MineViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (UIImage *)returnImgwithNstr:(NSString *)imgName
{
    //去除渲染,使用默认图片
    return [[UIImage imageNamed:imgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self.window makeKeyAndVisible];
    
    BaseTabBarController *baseTabBc = [[BaseTabBarController alloc]init];
    //baseTabBc.tabBar.tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_home_tab_s"]];

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

    baseTabBc.viewControllers = @[homeNavic,zoneNavic,followNavic,findNavic,mineNavic];
    baseTabBc.toolbarItems = @[homeVc.tabBarItem,zoneVc.tabBarItem,followVc.tabBarItem,findVc.tabBarItem,mineVc.tabBarItem];
    self.window.rootViewController = baseTabBc;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
