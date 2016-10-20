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
{
    NSTimer *_myTimer;
    NSInteger _skipTime;//跳过的时间
}

+ (void)lanuchStart
{
    [[UIApplication sharedApplication].keyWindow addSubview:[[StartView alloc]init]];
}

- (id)init
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    
    if (self)
    {
        _skipTime = 3;
        [self loadDefaultSubviews];
        
        //与服务器交互后加载
        [self loadAction];
    }
    return self;
}

- (void)loadAction
{
    _myTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
}

- (void)timerAction
{
    _skipTime --;
    if (!_skipTime)
    {
        [_myTimer invalidate];
        _myTimer = nil;
        [self removeFromSuperview];
    }
}

- (void)loadDefaultSubviews
{
    //默认启动图方式
    __block StartView *weakStart = self;
    UIImage *bg  = [UIImage imageNamed:@"bilibili_splash_iphone_bg"];
    UIImage *img = [UIImage imageNamed:@"bilibili_splash_default"];
    
    UIImageView *startBgView  = [[UIImageView alloc]init];
    UIImageView *startImgView = [[UIImageView alloc]init];
    startBgView.image  = bg;
    startImgView.image = img;
    
    startBgView.contentMode  = UIViewContentModeScaleAspectFit;
    startImgView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self addSubview:startBgView];
    [self addSubview:startImgView];
    [self bringSubviewToFront:startImgView];
    
    [startBgView  mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(weakStart);
    }];
    
    [startImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.center.equalTo(startBgView);
    }];
    
    
    [UIView animateWithDuration:0.8 animations:^{
        
        [startImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(weakStart.mas_width);
            make.height.mas_equalTo(weakStart.mas_height).multipliedBy(0.8);
            make.top.left.right.mas_equalTo(weakStart);
        }];
        [startImgView layoutIfNeeded];
    }];
}
@end
