//
//  WebViewController.m
//  MyBilibili
//
//  Created by Mac on 2017/2/24.
//  Copyright © 2017年 Hubin_Huang. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //WS(ws);
        
    WKWebView *wkWebView = [[WKWebView alloc]init];//WithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:wkWebView];
    
    [wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(52 *k5SWScale, 0, 0, 0));
    }];
    
    NSURL *url = [NSURL URLWithString:self.homeBannerModel.uri];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [wkWebView loadRequest:request];
    
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
