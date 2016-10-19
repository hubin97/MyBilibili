//
//  StartView.m
//  MyBilibili
//
//  Created by Hubin_Huang on 16/9/25.
//  Copyright © 2016年 Hubin_Huang. All rights reserved.
//

#import "StartView.h"
#import "Masonry.h"

@implementation StartView

+ (void)lanuchStart
{
    [[UIApplication sharedApplication].keyWindow addSubview:[[StartView alloc]init]];
}

- (id)init
{
    if (self = [super init])
    {
        //默认启动图方式
        __block StartView *weakStart = self;
        UIImage *bg  = [UIImage imageNamed:@"bilibili_splash_iphone_bg"];
        UIImage *img = [UIImage imageNamed:@"bilibili_splash_default"];

        UIImageView *startBgView  = [[UIImageView alloc]init];
        UIImageView *startImgView = [[UIImageView alloc]init];
        startBgView.image = bg;

        [self addSubview:startBgView];
        [self addSubview:startImgView];
        [self bringSubviewToFront:startImgView];
        
        [startBgView  mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(weakStart);
        }];
        
        [startImgView mas_makeConstraints:^(MASConstraintMaker *make) {

            make.size.mas_equalTo(CGSizeMake(img.size.width, img.size.height));
            make.center.equalTo(startBgView);
        }];

        [UIView animateWithDuration:1.5 animations:^{
            
        } completion:^(BOOL finished) {
            
        }];


        
        //与服务器交互后加载
        return self;
    }
    return self;
}
@end
