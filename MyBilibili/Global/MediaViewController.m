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
    
    CGFloat playViewH;
    CGFloat sendDanmuViewH;
}
@property (atomic, retain) id <IJKMediaPlayback> player;
@property (nonatomic, strong) UIView *playView ;

@property (nonatomic, strong) UIImageView *topImageView;    //播放上菜单栏 (背景渐变黑色)
@property (nonatomic, strong) UIImageView *bottomImageView; //播放下菜单栏 (同上)
@property (nonatomic, strong) UIView *sendDanmuView;        //弹幕视图
@property (nonatomic, strong) UIView *playSubView;          //播放器展示视图
@property (nonatomic, strong) UIButton *bigPlayBtn;         //大播放按钮

@property (nonatomic, strong) UIView *bottomView;           //播放控制视图
@property (nonatomic, strong) UIButton *smallPlayBtn;       //小播放按钮
@property (nonatomic, strong) UILabel *currentTimeLabel;    //当前播放时长
@property (nonatomic, strong) UILabel *totalTimeLabel;      //总共播放时长
@property (nonatomic, strong) UIProgressView *progressView; //播放进度条

@property (nonatomic, strong) UIButton *fullScreenBtn;      //全屏按钮
@property (nonatomic, strong) UIImageView *headIconView;    //头像视图
@property (nonatomic, strong) UITextField *danmuTextField;  //弹幕输入框
@end

@implementation MediaViewController

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initPlayView];//初始化布局
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_player prepareToPlay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Lay out
//初始化布局
- (void)initPlayView
{
    WS(ws);
    
    // 播放视图 225/ 568
    playViewH = [UIScreen mainScreen].bounds.size.height * 0.4;
    
    // 弹幕发送栏 40 / 225
    sendDanmuViewH = playViewH * 0.2;
    
    
    //======整个播放器视图=========
    _playView = [[UIView alloc]init];
    [self.view addSubview:_playView];
    
    [_playView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(ws.view);
        make.height.mas_equalTo(playViewH);
    }];
    
    //_playView.backgroundColor = [UIColor blackColor];
    //DrawViewBorderRadius(_playView, 1, 2, [UIColor redColor]);
    
    //======模糊视图=========
    //毛玻璃上
    _topImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"live_player_vtop_bg"]];
    [self.view addSubview:_topImageView];
    [_topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.view.mas_top);
        make.left.right.equalTo(ws.view);
        make.height.mas_equalTo(40 + 10 *k5SWScale);
    }];
    _topImageView.userInteractionEnabled = YES;
    
#if 0
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *topVisualEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    [topImageView addSubview:topVisualEffectView];
    
    [topVisualEffectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.view.mas_top);
        make.left.right.equalTo(ws.view);
        make.height.mas_equalTo(topImageView.mas_height);
    }];
    
    topVisualEffectView.alpha = 1.0;
#endif
    
    //DrawViewBorderRadius(topVisualEffectView, 1, 1, [UIColor redColor]);
    
    CGFloat bottomImageViewH = (/*sendDanmuViewH + */20 + 10 *k5SWScale);
    //毛玻璃下
    _bottomImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"live_player_vbottom_bg"]];
    [self.view addSubview:_bottomImageView];
    [_bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_playView);
        make.bottom.equalTo(_playView).offset(- sendDanmuViewH);
        make.height.mas_equalTo(bottomImageViewH);
    }];
    _bottomImageView.userInteractionEnabled = YES;
    
    //DrawViewBorderRadius(bottomImageView, 1, 1, [UIColor greenColor]);
    
#if 0
    
    UIVisualEffectView *bottomVisualEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    [_playView addSubview:bottomVisualEffectView];
    
    bottomVisualEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    bottomVisualEffectView.alpha = 0.9;
    DrawViewBorderRadius(bottomVisualEffectView, 1, 1, [UIColor greenColor]);
#endif
    
    //添加标题视图
    UIView *topView = [[UIView alloc]init];
    [_topImageView addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topImageView.mas_top).offset(20);
        make.left.right.equalTo(_topImageView);
        make.height.mas_equalTo(20 + 10 *k5SWScale);
    }];
    
    //    DrawViewBorderRadius(topView, 1, 1, [UIColor whiteColor]);
    
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
        make.left.equalTo(topView.mas_left).offset(15 *k5SWScale);
        make.width.equalTo(backBtn.mas_height);
    }];
    
    
    //更多键
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [topView addSubview:moreBtn];
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(topView);
        make.right.equalTo(topView.mas_right).offset(- 15 *k5SWScale);
        make.width.equalTo(moreBtn.mas_height);
    }];
    
    [backBtn setImage:[UIImage imageNamed:@"common_backShadow"] forState:UIControlStateNormal];
    [moreBtn setImage:[UIImage imageNamed:@"icmpv_more_light"] forState:UIControlStateNormal];
    
    [backBtn addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    //播放控制视图
    _bottomView = [[UIView alloc]init];
    [_bottomImageView addSubview:_bottomView];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_bottomImageView);
        //make.bottom.equalTo(bottomImageView.mas_bottom).offset(- sendDanmuViewH);
        make.top.equalTo(_bottomImageView);
        make.height.mas_equalTo(20 + 10 *k5SWScale);
    }];
    
    //DrawViewBorderRadius(bottomView, 1, 1, [UIColor whiteColor]);
    
    //大播放按钮
    UIImage *bigPlayImg = [UIImage imageNamed:@"player_play_c"];
    CGFloat bigPlayBtnW = bigPlayImg.size.width;
    CGFloat bigPlayBtnH = bigPlayImg.size.height;
    
    _bigPlayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_bigPlayBtn];
    [_bigPlayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.view.mas_right).offset(- 20 *k5SWScale);
        make.bottom.equalTo(_bottomView.mas_top).offset(- 20 * k5SWScale);
        make.width.mas_equalTo(bigPlayBtnW);
        make.height.mas_equalTo(bigPlayBtnH);
    }];
    
    [_bigPlayBtn setImage:bigPlayImg forState:UIControlStateNormal];
    [_bigPlayBtn addTarget:self action:@selector(playOrPause) forControlEvents:UIControlEventTouchUpInside];
    
    //小播放按钮
    _smallPlayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_bottomView addSubview:_smallPlayBtn];
    [_smallPlayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(_bottomView);
        make.left.equalTo(_bottomView.mas_left).offset(10 *k5SWScale);
        make.width.equalTo(_smallPlayBtn.mas_height);
    }];
    
    [_smallPlayBtn setImage:[UIImage imageNamed:@"player_play_bottom_window"] forState:UIControlStateNormal];
    [_smallPlayBtn addTarget:self action:@selector(playOrPause) forControlEvents:UIControlEventTouchUpInside];
    
    //全屏按钮
    //UIImage *fullScreenBtnImg = [UIImage imageNamed:@"player_fullScreen_iphone"];
    
    _fullScreenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_bottomView addSubview:_fullScreenBtn];
    [_fullScreenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(_bottomView);
        make.right.equalTo(_bottomView.mas_right).offset(- 15 *k5SWScale);
        make.width.equalTo(_smallPlayBtn.mas_height);
    }];
    
    [_fullScreenBtn setImage:[UIImage imageNamed:@"player_fullScreen_iphone"] forState:UIControlStateNormal];
    
    [_fullScreenBtn addTarget:self action:@selector(fullScreenAction) forControlEvents:UIControlEventTouchUpInside];
    
    //时长/读条
    _currentTimeLabel = [[UILabel alloc]init];
    [_bottomView addSubview:_currentTimeLabel];
    [_currentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(_bottomView);
        make.left.equalTo(_smallPlayBtn.mas_right).offset(10 *k5SWScale);
        make.width.mas_equalTo(_currentTimeLabel.mas_height).multipliedBy(1.2);
    }];
    _currentTimeLabel.text = @"00:00";
    _currentTimeLabel.textColor = [UIColor whiteColor];
    _currentTimeLabel.font = [UIFont systemFontOfSize:12.0];
    
    //DrawViewBorderRadius(currentTimeLabel, 1, 1, [UIColor redColor]);
    
    
    _totalTimeLabel = [[UILabel alloc]init];
    [_bottomView addSubview:_totalTimeLabel];
    [_totalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(_bottomView);
        make.right.equalTo(_fullScreenBtn.mas_left).offset(- 10 *k5SWScale);
        make.width.mas_equalTo(_currentTimeLabel.mas_height).multipliedBy(1.2);
    }];
    
    _totalTimeLabel.text = @"66:66";
    _totalTimeLabel.textColor = [UIColor whiteColor];
    _totalTimeLabel.font = [UIFont systemFontOfSize:12.0];
    
    _progressView = [[UIProgressView alloc]init];
    [_bottomView addSubview:_progressView];
    
    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.equalTo(bottomView.mas_top).offset(10 *k5SWScale);
        //        make.bottom.equalTo(bottomView.mas_bottom).offset(-10 *k5SWScale);
        make.left.equalTo(_currentTimeLabel.mas_right).offset(10 *k5SWScale);
        make.right.equalTo(_totalTimeLabel.mas_left).offset(- 10 *k5SWScale);
        make.centerY.equalTo(_bottomView.mas_centerY);
        make.height.mas_equalTo(2);
    }];
    
    _progressView.progressTintColor = cherryPowder;
    _progressView.trackTintColor = [UIColor blackColor];
    _progressView.progress = 0.3;
    
    
    //======发送弹幕视图=========
    _sendDanmuView = [[UIView alloc]init];
    [self.view addSubview:_sendDanmuView];
  
    [_sendDanmuView mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.height.mas_equalTo(h);
        make.left.right.bottom.equalTo(_playView);
        make.height.mas_equalTo(sendDanmuViewH);
    }];
    
    _sendDanmuView.backgroundColor = [UIColor blackColor];
    
    //DrawViewBorderRadius(_sendDanmuView, 1, 1, [UIColor whiteColor]);
    
    //头像
    _headIconView = [[UIImageView alloc]init];
    [_sendDanmuView addSubview:_headIconView];
    [_headIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(_sendDanmuView).offset(10 *k5SWScale);
        make.centerY.equalTo(_sendDanmuView.mas_centerY);
        make.width.equalTo(_headIconView.mas_height);
    }];
    _headIconView.image = [UIImage imageNamed:@"headIcon01"];
    CGFloat headIconRadius = (sendDanmuViewH - 20 *k5SWScale)/2;
    DrawViewBorderRadius(_headIconView, headIconRadius, 1, [UIColor clearColor]);
    
    //编辑输入框
    _danmuTextField = [[UITextField alloc]init];
    [_sendDanmuView addSubview:_danmuTextField];
    [_danmuTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_sendDanmuView).offset(10);
        make.left.equalTo(_headIconView.mas_right).offset(10 *k5SWScale);
        make.right.equalTo(_sendDanmuView).offset(- 10*k5SWScale);
        make.centerY.equalTo(_sendDanmuView.mas_centerY);
//        make.width.equalTo(_sendDanmuView.mas_width - );
    }];
    DrawViewBorderRadius(_danmuTextField, headIconRadius, 1, [UIColor clearColor]);
    _danmuTextField.placeholder = @"发个弹幕呗";
    _danmuTextField.font = [UIFont systemFontOfSize:14.0];
    //danmuTextField.attributedPlaceholder =
    _danmuTextField.backgroundColor = [UIColor grayColor];
    _danmuTextField.textAlignment = NSTextAlignmentCenter;
    
    
    //======播放器显示视图=========
    _playSubView = [[UIView alloc]init];
    [_playView addSubview:_playSubView];
    
    [_playSubView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(ws.view);
        //make.bottom.equalTo(_sendDanmuView.mas_top);
        make.height.mas_equalTo(playViewH - sendDanmuViewH);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(playSubViewTap)];
    [_playSubView addGestureRecognizer:tap];
    
    
    //playImageView.image = [UIImage imageNamed:@"1.jpg"];
    
    //220 630  25
    
    NSURL *url = [NSURL URLWithString:@"http://live.hkstv.hk.lxdns.com/live/hks/playlist.m3u8"];
    
    _player = [[IJKFFMoviePlayerController alloc]initWithContentURL:url withOptions:nil];
    
    UIView *playerView = [_player view];
    playerView.frame = _playSubView.frame;
    playerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [_playSubView insertSubview:playerView atIndex:1];
    [_player setScalingMode:IJKMPMovieScalingModeAspectFill];
    //[self installMovieNotificationObservers];
}


//====  整合横竖屏 ====
- (void)layoutWithInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    [self interfaceOrientation:orientation];

    CGFloat timeInterval = [[UIApplication sharedApplication]statusBarOrientationAnimationDuration];
    
    BOOL isPortrait = (orientation == UIInterfaceOrientationPortrait)? YES : NO;
    
    CGFloat h = (isPortrait)? (self.view.frame.size.height * 0.4) : (self.view.frame.size.height);

    [UIView animateWithDuration:timeInterval animations:^{
        
        [_playView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(h);
        }];
        
        [_playSubView mas_remakeConstraints:^(MASConstraintMaker *make) {
            if (isPortrait)
            {
                make.top.left.right.equalTo(_playView);
                make.bottom.equalTo(_playView.mas_bottom).offset(- sendDanmuViewH);
            }
            else
            {
                make.top.left.bottom.right.equalTo(_playView);
            }
        }];
        
        [_bottomImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            if (isPortrait)
            {
                make.left.right.equalTo(_playView);
                make.bottom.equalTo(_playView).offset(- sendDanmuViewH);
                make.height.mas_equalTo(20 + 10 *k5SWScale);
            }
            else
            {
                make.left.bottom.right.equalTo(_playView);
                make.height.mas_equalTo(sendDanmuViewH + 20 + 10 *k5SWScale);
            }
        }];
        
        
        if (isPortrait)
        {
            _fullScreenBtn.hidden = NO;   //显示全屏按钮
            _headIconView.hidden  = NO;   //显示头像视图
            [_smallPlayBtn removeFromSuperview];
            [_bottomView addSubview:_smallPlayBtn];
        }
        else
        {
            _fullScreenBtn.hidden = YES;  //隐藏全屏按钮
            _headIconView.hidden  = YES;   //隐藏头像视图
            [_smallPlayBtn removeFromSuperview];
            [_sendDanmuView addSubview:_smallPlayBtn];
        }

        
        CGFloat headIconRadius = (sendDanmuViewH - 20 *k5SWScale)/2;
        [_danmuTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
            if (isPortrait)
            {
                make.left.equalTo(_headIconView.mas_right).offset(10 *k5SWScale);
                make.right.equalTo(_sendDanmuView).offset(- 10*k5SWScale);
                DrawViewBorderRadius(_danmuTextField, headIconRadius, 1, [UIColor clearColor]);
            }
            else
            {
                make.left.equalTo(_smallPlayBtn.mas_right).offset(10 *k5SWScale);
                make.width.equalTo(_playView.mas_width).dividedBy(2);
                DrawViewBorderRadius(_danmuTextField, headIconRadius/1.5, 1, [UIColor clearColor]);
            }
            make.top.equalTo(_sendDanmuView).offset(10);  //默认
            make.centerY.equalTo(_sendDanmuView.mas_centerY);
        }];
        
        //====
        //小控件约束
        [_smallPlayBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            if (isPortrait)
            {
                make.top.bottom.equalTo(_bottomView);
                make.left.equalTo(_bottomView.mas_left).offset(10 *k5SWScale);
            }
            else
            {
                make.left.equalTo(_sendDanmuView).offset(10 *k5SWScale);
                make.top.equalTo(_sendDanmuView);//.offset(10);
                make.centerY.equalTo(_sendDanmuView.mas_centerY);
            }
        }];
        
        [_currentTimeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            if (isPortrait)
            {
                make.left.equalTo(_smallPlayBtn.mas_right).offset(10 *k5SWScale);
//                make.width.mas_equalTo(_currentTimeLabel.mas_height).multipliedBy(1.2);
            }
            else
            {
                make.left.equalTo(_bottomView.mas_left).offset(10 *k5SWScale);
//                make.width.equalTo(_smallPlayBtn.mas_height);
            }
            make.width.mas_equalTo(_currentTimeLabel.mas_height).multipliedBy(1.2);
            make.centerY.equalTo(_bottomView.mas_centerY);
        }];
   
        [_totalTimeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            if (isPortrait)
            {
                make.top.bottom.equalTo(_bottomView);
                make.right.equalTo(_fullScreenBtn.mas_left).offset(- 10 *k5SWScale);
                make.width.mas_equalTo(_currentTimeLabel.mas_height).multipliedBy(1.2);
            }
            else
            {
                make.right.equalTo(_bottomView.mas_right).offset(- 10 *k5SWScale);
            }
            make.centerY.equalTo(_bottomView.mas_centerY);
        }];
        
        
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        //横屏时默认点击一下做隐藏菜单栏
        if(!isPortrait)[self playSubViewTap];
    }];
}

//切换竖屏
//- (void)setupPortraitPlayView
//{
//    CGFloat timeInterval = [[UIApplication sharedApplication]statusBarOrientationAnimationDuration];
//
//    [self interfaceOrientation:UIInterfaceOrientationPortrait];
//    
//    CGFloat h = (self.view.frame.size.height * 0.4);
//    
//    [UIView animateWithDuration:timeInterval animations:^{
//        
//        [_playView mas_updateConstraints:^(MASConstraintMaker *make) {
//            
//            make.height.mas_equalTo(h);
//        }];
//        
//        [_playSubView mas_updateConstraints:^(MASConstraintMaker *make) {
//            
//            make.top.left.right.equalTo(_playView);
//            make.bottom.equalTo(_playView.mas_bottom).offset(- sendDanmuViewH);
//        }];
//        
//        [_bottomImageView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.left.right.equalTo(_playView);
//            make.bottom.equalTo(_playView).offset(- sendDanmuViewH);
//            make.height.mas_equalTo(20 + 10 *k5SWScale);
//        }];
//        
//        _fullScreenBtn.hidden = NO;   //显示全屏按钮
//        _headIconView.hidden  = NO;   //显示头像视图
//
//        [_smallPlayBtn removeFromSuperview];
//        [_bottomView addSubview:_smallPlayBtn];
//        
//        
//        [self.view layoutIfNeeded];
//    }];
//}

//切换横屏
//- (void)setupLandscapePlayView
//{
//    CGFloat timeInterval = [[UIApplication sharedApplication]statusBarOrientationAnimationDuration];
//    
//    CGFloat h = (self.view.frame.size.width);
//    
//    [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
//    
//    [UIView animateWithDuration:timeInterval animations:^{
//        
//        [_playView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(h);
//        }];
//        
//        [_playSubView mas_updateConstraints:^(MASConstraintMaker *make) {
//            //make.height.mas_equalTo(h);
//            make.top.left.bottom.right.equalTo(_playView);
//        }];
//        
//        [_sendDanmuView mas_updateConstraints:^(MASConstraintMaker *make) {
//            //make.height.mas_equalTo(h);
//            make.left.right.bottom.equalTo(_playView);
//            make.height.mas_equalTo(sendDanmuViewH);
//        }];
//        
//        [_bottomImageView mas_updateConstraints:^(MASConstraintMaker *make) {
//            //make.height.mas_equalTo(h);
//            make.left.bottom.right.equalTo(_playView);
//            make.height.mas_equalTo(sendDanmuViewH + 20 + 10 *k5SWScale);
//        }];
//        
//        //小控件约束
//        _fullScreenBtn.hidden = YES;  //隐藏全屏按钮
//        _headIconView.hidden = YES;   //隐藏头像视图
//        
//        //_currentTimeLabel.frame = _smallPlayBtn.frame; //调换位置
//        //_smallPlayBtn.frame = _headIconView.frame;
//        [_currentTimeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.bottom.equalTo(_bottomView);
//            make.left.equalTo(_bottomView.mas_left).offset(10 *k5SWScale);
//            make.width.equalTo(_smallPlayBtn.mas_height);
//        }];
//        
//        [_smallPlayBtn removeFromSuperview];
//        [_sendDanmuView addSubview:_smallPlayBtn];
//        
//        [_smallPlayBtn mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(_sendDanmuView).offset(10 *k5SWScale);
//            make.top.equalTo(_sendDanmuView).offset(10);
//            make.centerY.equalTo(_sendDanmuView.mas_centerY);
//            make.width.equalTo(_smallPlayBtn.mas_height);
//        }];
//        
//        [_totalTimeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(_bottomView.mas_right).offset(- 10 *k5SWScale);
//        }];
//        
//        [_danmuTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(_sendDanmuView).offset(10);
//            make.left.equalTo(_smallPlayBtn.mas_right).offset(10 *k5SWScale);
//            //make.right.equalTo(_sendDanmuView).offset(- 10*k5SWScale);
//            make.centerY.equalTo(_sendDanmuView.mas_centerY);;
//            make.width.equalTo(_playView.mas_width).dividedBy(2);
//        }];
//
//        //[self setNeedsUpdateConstraints];
//
//        [self.view layoutIfNeeded];
//        
//    } completion:^(BOOL finished) {
//        
//        //横屏时默认点击一下做隐藏菜单栏
//        [self playSubViewTap];
//    }];
//}


#pragma mark - Private
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

/**
 点击播放视图
 */
- (void)playSubViewTap
{
    NSLog(@"playSubViewTap-----");
    BOOL isPortrait = [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait;
    //CGFloat timeInterval = [[UIApplication sharedApplication]statusBarOrientationAnimationDuration];
    
    // 竖屏时点击
    if (isPortrait)
    {
        if(_topImageView.hidden)
        {
            _topImageView.hidden = NO;
            _bottomImageView.hidden = NO;
            _bigPlayBtn.hidden = NO;
        }
        else
        {
            _topImageView.hidden = YES;
            _bottomImageView.hidden = YES;
            _bigPlayBtn.hidden = YES;
        }
    }
    else // 横屏时点击
    {
        if(_topImageView.hidden)
        {
            _topImageView.hidden = NO;
            _bottomImageView.hidden = NO;
            _sendDanmuView.hidden = NO;
            _bigPlayBtn.hidden = NO;
        }
        else
        {
            _topImageView.hidden = YES;
            _bottomImageView.hidden = YES;
            _sendDanmuView.hidden = YES;
            _bigPlayBtn.hidden = YES;
        }
    }
    
    //重调- (BOOL)prefersStatusBarHidden方法
    [self setNeedsStatusBarAppearanceUpdate];
}


/**
 点击播放暂定键
 */
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


/**
 点击全屏键
 */
- (void)fullScreenAction
{
    isClicked = YES;
  
    //[self setupLandscapePlayView];
    
    [self layoutWithInterfaceOrientation:UIInterfaceOrientationLandscapeRight];
    
    isClicked = !isClicked;
}


/**
 点击返回键
 */
- (void)backBtnClicked
{
    BOOL isPortrait = [[UIApplication sharedApplication]statusBarOrientation] == UIInterfaceOrientationPortrait;

    //竖屏时返回上一页
    if(isPortrait)
    {
        [_player stop];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else //横屏时返回点击切换成竖屏
    {
        isClicked = YES;
        
        //[self setupPortraitPlayView];
        [self layoutWithInterfaceOrientation:UIInterfaceOrientationPortrait];

        isClicked = !isClicked;
    }
}



#pragma mark - Settings
//设置状态栏
- (BOOL)prefersStatusBarHidden
{
//    BOOL landscape = [[UIApplication sharedApplication]statusBarOrientation] == UIInterfaceOrientationLandscapeLeft || [[UIApplication sharedApplication]statusBarOrientation] == UIInterfaceOrientationLandscapeRight;
//    if (_topImageView.hidden && landscape)
//    {
//        return YES;
//    }
#warning 重调- (BOOL)prefersStatusBarHidden方法
    //[self setNeedsStatusBarAppearanceUpdate];

    return (_topImageView.hidden)? YES: NO;
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
