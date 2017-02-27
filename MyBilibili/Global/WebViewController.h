//
//  WebViewController.h
//  MyBilibili
//
//  Created by Mac on 2017/2/24.
//  Copyright © 2017年 Hubin_Huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyViewController.h"

#import "HomeBannerModel.h"

@interface WebViewController : MyViewController

//@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) HomeBannerModel *homeBannerModel;

@end
