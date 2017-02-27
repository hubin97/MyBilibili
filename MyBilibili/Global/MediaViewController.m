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

@property (atomic, retain) id <IJKMediaPlayback> player;

@end

@implementation MediaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSURL *url = [NSURL URLWithString:@"http://live.hkstv.hk.lxdns.com/live/hks/playlist.m3u8"];

    _player = [[IJKFFMoviePlayerController alloc]initWithContentURL:url withOptions:nil];
    
    UIView *playerView = [_player view];
    
    playerView.frame = self.view.bounds;
    
//    [self.view addSubview:playerView];
    [self.view insertSubview:playerView atIndex:1];
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
    if (_player.isPlaying)
    {
        [_player pause];
    }
    else
    {
        [_player play];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
