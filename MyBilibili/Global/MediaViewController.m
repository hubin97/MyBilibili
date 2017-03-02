//
//  MediaViewController.m
//  MyBilibili
//
//  Created by Mac on 2017/2/27.
//  Copyright © 2017年 Hubin_Huang. All rights reserved.
//

#import "MediaViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>

@interface MediaViewController ()
{
    BOOL isClicked;  //能否换个思路?
}
@property (atomic, retain) id <IJKMediaPlayback> player;
@property (nonatomic, strong) UIView *playView ;

@end

@implementation MediaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
 
    [self setupPortraitPlayView];
}

- (void)setupPortraitPlayView
{
    WS(ws);
    
    // 播放视图 225/ 568
    CGFloat playViewH = [UIScreen mainScreen].bounds.size.height * 0.4;
    
    // 弹幕发送栏 40 / 225
    CGFloat sendDanmuViewH = playViewH * 0.2;
    
    //======整个播放器视图=========
    _playView = [[UIView alloc]init];
    [self.view addSubview:_playView];
    
    [_playView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(ws.view);
        make.height.mas_equalTo(playViewH);
    }];

    _playView.backgroundColor = [UIColor blackColor];

    //添加标题视图
    UIView *topView = [[UIView alloc]init];
    [self.view addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_playView.mas_top).offset(20);
        make.left.right.equalTo(_playView);
        make.height.mas_equalTo(20 + 10 *k5SWScale);
    }];
    
    //DrawViewBorderRadius(topView, 1, 1, [UIColor whiteColor]);
    
    //标题label 70 / 320
    CGFloat titleLabelX = self.view.frame.size.width * 0.22;
    //CGFloat titleLabelW = topView.frame.size.width * (1 - 2 * 0.22);
    
    UILabel *titleLabel = [[UILabel alloc]init];
    [topView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(topView);
        make.left.equalTo(topView.mas_left).offset(titleLabelX);
        make.right.equalTo(topView.mas_right).offset(-titleLabelX);
    }];
    
    titleLabel.text = @"正在播放的是<大秦帝国>电视剧,up主欢迎大家打赏鲜花.";
    titleLabel.font = [UIFont systemFontOfSize:12.0];
    titleLabel.textColor = [UIColor whiteColor];
    
    //返回键  70 / 320
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [topView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(topView);
        make.left.equalTo(topView.mas_left).offset(20 *k5SWScale);
        make.width.equalTo(backBtn.mas_height);
    }];
    
    
    //更多键
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [topView addSubview:moreBtn];
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(topView);
        make.right.equalTo(topView.mas_right).offset(- 20 *k5SWScale);
        make.width.equalTo(moreBtn.mas_height);
    }];
    
    [backBtn setImage:[UIImage imageNamed:@"common_backShadow"] forState:UIControlStateNormal];
    [moreBtn setImage:[UIImage imageNamed:@"icmpv_more_light"] forState:UIControlStateNormal];

    [backBtn addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    //播放控制视图
    UIView *bottomView = [[UIView alloc]init];
    [self.view addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(_playView.mas_bottom).offset(- sendDanmuViewH);
        make.height.mas_equalTo(20 + 10 *k5SWScale);
    }];
    
    //DrawViewBorderRadius(bottomView, 1, 1, [UIColor whiteColor]);

    //大播放按钮
    UIImage *bigPlayImg = [UIImage imageNamed:@"player_play_c"];
    CGFloat bigPlayBtnW = bigPlayImg.size.width;
    CGFloat bigPlayBtnH = bigPlayImg.size.height;

    UIButton *bigPlayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:bigPlayBtn];
    [bigPlayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.view.mas_right).offset(- 20 *k5SWScale);
        make.bottom.equalTo(bottomView.mas_top).offset(- 20 * k5SWScale);
        make.width.mas_equalTo(bigPlayBtnW);
        make.height.mas_equalTo(bigPlayBtnH);
    }];
    
    [bigPlayBtn setImage:bigPlayImg forState:UIControlStateNormal];
    [bigPlayBtn addTarget:self action:@selector(playOrPause) forControlEvents:UIControlEventTouchUpInside];

    //小播放按钮
    UIButton *smallPlayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomView addSubview:smallPlayBtn];
    [smallPlayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(bottomView);
        make.left.equalTo(bottomView.mas_left).offset(10 *k5SWScale);
        make.width.equalTo(smallPlayBtn.mas_height);
    }];
    
    [smallPlayBtn setImage:[UIImage imageNamed:@"player_play_bottom_window"] forState:UIControlStateNormal];
    [smallPlayBtn addTarget:self action:@selector(playOrPause) forControlEvents:UIControlEventTouchUpInside];
    
    //全屏按钮
    //UIImage *fullScreenBtnImg = [UIImage imageNamed:@"player_fullScreen_iphone"];
    
    UIButton *fullScreenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomView addSubview:fullScreenBtn];
    [fullScreenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(bottomView);
        make.right.equalTo(bottomView.mas_right).offset(- 15 *k5SWScale);
        make.width.equalTo(smallPlayBtn.mas_height);
    }];
    
    [fullScreenBtn setImage:[UIImage imageNamed:@"player_fullScreen_iphone"] forState:UIControlStateNormal];
    
    [fullScreenBtn addTarget:self action:@selector(fullScreenAction) forControlEvents:UIControlEventTouchUpInside];
    
    //时长/读条
    UILabel *currentTimeLabel = [[UILabel alloc]init];
    [bottomView addSubview:currentTimeLabel];
    [currentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(bottomView);
        make.left.equalTo(smallPlayBtn.mas_right).offset(10 *k5SWScale);
        make.width.mas_equalTo(currentTimeLabel.mas_height).multipliedBy(2);
    }];
    currentTimeLabel.text = @"00:00";
    currentTimeLabel.textColor = [UIColor whiteColor];
    currentTimeLabel.font = [UIFont systemFontOfSize:12.0];
    
    //DrawViewBorderRadius(currentTimeLabel, 1, 1, [UIColor redColor]);
    
    
    UILabel *totalTimeLabel = [[UILabel alloc]init];
    [bottomView addSubview:totalTimeLabel];
    [totalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(bottomView);
        make.right.equalTo(fullScreenBtn.mas_left).offset(- 20 *k5SWScale);
        make.width.mas_equalTo(currentTimeLabel.mas_height).multipliedBy(2);
    }];
    
    totalTimeLabel.text = @"66:66";
    totalTimeLabel.textColor = [UIColor whiteColor];
    totalTimeLabel.font = [UIFont systemFontOfSize:12.0];
    
    UIProgressView *progressView = [[UIProgressView alloc]init];
    [bottomView addSubview:progressView];
    
    [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(bottomView.mas_top).offset(10 *k5SWScale);
//        make.bottom.equalTo(bottomView.mas_bottom).offset(-10 *k5SWScale);
        make.left.equalTo(currentTimeLabel.mas_right).offset(10 *k5SWScale);
        make.right.equalTo(totalTimeLabel.mas_left).offset(- 10 *k5SWScale);
        make.centerY.equalTo(bottomView.mas_centerY);
        make.height.mas_equalTo(5);
    }];
    
    progressView.progressTintColor = cherryPowder;
    progressView.trackTintColor = [UIColor blackColor];
    progressView.progress = 0.3;
    
    
    //======发送弹幕视图=========
    UIView *sendDanmuView = [[UIView alloc]init];
    [_playView addSubview:sendDanmuView];
    
    [sendDanmuView mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.top.equalTo(playSubView);
        make.left.right.bottom.equalTo(_playView);
        make.height.mas_equalTo(sendDanmuViewH);
    }];
    sendDanmuView.backgroundColor = [UIColor grayColor];
    
    
    
    //======播放器显示视图=========
    UIView *playSubView = [[UIView alloc]init];
    [_playView addSubview:playSubView];
    
    [playSubView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(ws.view);
        make.bottom.equalTo(sendDanmuView.mas_top);
    }];
    
  
    //playImageView.image = [UIImage imageNamed:@"1.jpg"];
    
    //220 630  25
    
    NSURL *url = [NSURL URLWithString:@"http://live.hkstv.hk.lxdns.com/live/hks/playlist.m3u8"];
    
    _player = [[IJKFFMoviePlayerController alloc]initWithContentURL:url withOptions:nil];
    
    UIView *playerView = [_player view];
    playerView.frame = playSubView.frame;
    playerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [playSubView insertSubview:playerView atIndex:1];
    [_player setScalingMode:IJKMPMovieScalingModeAspectFill];
    //[self installMovieNotificationObservers];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_player prepareToPlay];
}


- (void)interfaceOrientation:(UIInterfaceOrientation)orientation
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector             = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val                  = orientation;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

#pragma mark - Action
- (void)playOrPause
{
    if (![_player isPlaying])
    {
        [_player play];
    }
    else
    {
        [_player pause];
    }
}

- (void)fullScreenAction
{
    isClicked = YES;
  
    CGFloat timeInterval = [[UIApplication sharedApplication]statusBarOrientationAnimationDuration];
    
    CGFloat h = (self.view.frame.size.width);
    
    [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
    
    [UIView animateWithDuration:timeInterval animations:^{
        
        [_playView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(h);
        }];
        [_playView layoutIfNeeded];
    }];
    
    isClicked = !isClicked;
}

- (void)backBtnClicked
{
    BOOL isPortrait = [[UIApplication sharedApplication]statusBarOrientation] == UIInterfaceOrientationPortrait;
    CGFloat timeInterval = [[UIApplication sharedApplication]statusBarOrientationAnimationDuration];
    //竖屏时返回上一页
    if(isPortrait)
    {
        [_player stop];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else //横屏时返回点击切换成竖屏
    {
        isClicked = YES;

        [self interfaceOrientation:UIInterfaceOrientationPortrait];
        
        CGFloat h = (self.view.frame.size.height * 0.4);
        
        [UIView animateWithDuration:timeInterval animations:^{
            
            [_playView mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.height.mas_equalTo(h);
            }];
            [_playView layoutIfNeeded];
        }];
        
        isClicked = !isClicked;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//设置状态栏
- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)shouldAutorotate
{
    //return YES;
    return (isClicked)? YES : NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

@end
