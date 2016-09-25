//
//  BaseNavigationController.m
//  MyBilibili
//
//  Created by Hubin_Huang on 16/9/24.
//  Copyright © 2016年 Hubin_Huang. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    if (self = [super initWithRootViewController:rootViewController])
    {
        //self.navigationBar.translucent = NO;
        //设置navigationBar背景色
        UIColor *naviBarColor = [UIColor colorWithRed:250/255.0 green:130/255.0 blue:165/255.0 alpha:1.0];
        CGFloat systemVersion = [[UIDevice currentDevice] systemVersion].floatValue;
        
        if (systemVersion >= 7.0)
        {
            self.navigationBar.barTintColor = naviBarColor;
        }
        else
        {
            self.navigationBar.tintColor    = naviBarColor;
        }
        
        return self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//设置状态栏
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
