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
    BOOL isClicked;
}
@property (atomic, retain) id <IJKMediaPlayback> player;
@property (nonatomic, strong) UIView *playView ;

@end

@implementation MediaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
 
    [self setup];
}

- (void)setup
{
    WS(ws);
    
    CGFloat playViewH = [UIScreen mainScreen].bounds.size.height * 0.35;
    CGFloat playPadding = playViewH * 0.12;
    
    _playView = [[UIView alloc]init];
    [self.view addSubview:_playView];
    
    [_playView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(ws.view);
        make.height.mas_equalTo(playViewH);
    }];

    _playView.backgroundColor = [UIColor blackColor];

    UIView *playSubView = [[UIView alloc]init];
    [_playView addSubview:playSubView];
    
    [playSubView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_playView.mas_top).offset(playPadding);
        make.bottom.equalTo(_playView.mas_bottom).offset(- playPadding);
        make.left.right.equalTo(ws.view);
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
    
    if (![_player isPlaying])
    {
        [_player prepareToPlay];
    }
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    if (_player.isPlaying)
//    {
//        [_player pause];
//    }
//    else
//    {
//        [_player play];
//    }
    
    
    isClicked = YES;
    
    //WS(ws);
    
    BOOL isPortrait = [[UIApplication sharedApplication]statusBarOrientation] == UIInterfaceOrientationPortrait;
    CGFloat timeInterval = [[UIApplication sharedApplication]statusBarOrientationAnimationDuration];
    
    if(isPortrait)
    {
        CGFloat h = (self.view.frame.size.width);
        
        [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
        
        [UIView animateWithDuration:timeInterval animations:^{
            
            [_playView mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.height.mas_equalTo(h);
            }];
            [_playView layoutIfNeeded];
        }];
    }
    else
    {
        [self interfaceOrientation:UIInterfaceOrientationPortrait];
        
        CGFloat h = (self.view.frame.size.height * 0.35);
        
        [UIView animateWithDuration:timeInterval animations:^{
            
            [_playView mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.height.mas_equalTo(h);
            }];
            [_playView layoutIfNeeded];
        }];
    }
    
    isClicked = !isClicked;
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


- (void)backBtnClicked
{
    [super backBtnClicked];

    [_player stop];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
//{
//    [self.view layoutIfNeeded];
//}


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
