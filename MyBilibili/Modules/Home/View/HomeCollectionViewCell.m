//
//  HomeCollectionViewCell.m
//  MyBilibili
//
//  Created by Hubin_Huang on 2017/2/22.
//  Copyright © 2017年 Hubin_Huang. All rights reserved.
//

#import "HomeCollectionViewCell.h"

@interface HomeCollectionViewCell()
{
    UIImageView *_titleImgView; //大图浏览视图
    UILabel *_titleLabel;       // 标题
   
    UIImageView *_playCountImageView;  // 播放数图标
    UIImageView *_danmuCountImageView; // 弹幕数图标
    
    UILabel *_playCountLabel;  // 播放数
    UILabel *_dumuCountLabel;  // 弹幕数
}

@end
@implementation HomeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        NSLog(@"HomeCollectionViewCell init --------");
        
        WS(ws);
        
        //35/135   1/3
        _titleImgView = [[UIImageView alloc]init];
        [self addSubview:_titleImgView];
        
        DrawViewBorderRadius(_titleImgView, 5, 1, [UIColor clearColor]);
        
        _titleLabel = [[UILabel alloc]init];
        [self addSubview:_titleLabel];
        
        //CGFloat titleImgViewW = self.frame.size.width;
        CGFloat titleImgViewH = self.frame.size.height *3/4;
        
        //===========
        [_titleImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.left.right.equalTo(ws);
            make.height.mas_equalTo(titleImgViewH);
        }];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(_titleImgView.mas_bottom).offset(5);
            make.left.right.bottom.equalTo(ws);
        }];
        
        
        //=============
        UIView *logView = [[UIView alloc]init];
        [_titleImgView addSubview:logView];
        //logView.backgroundColor = [UIColor clearColor];
        
        //添加弹幕,播放计数视图
        UIImage *playCountImage  = [UIImage imageNamed:@"misc_playCount_new"];
        //_danmuCountImage = [UIImage imageNamed:@"misc_danmakuCount_new"];

        CGFloat playCountImgW = playCountImage.size.width;
        CGFloat playCountImgH = playCountImage.size.height;
        
        [logView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(_titleImgView);
            make.height.mas_equalTo(playCountImgH * 1.2);
        }];
        
        //DrawViewBorderRadius(logView, 1, 1, [UIColor whiteColor]);
        
        _playCountImageView = [[UIImageView alloc]init];
        [logView addSubview:_playCountImageView];
        _playCountLabel = [[UILabel alloc]init];
        [logView addSubview:_playCountLabel];
        
        _danmuCountImageView = [[UIImageView alloc]init];
        [logView addSubview:_danmuCountImageView];
        _dumuCountLabel = [[UILabel alloc]init];
        [logView addSubview:_dumuCountLabel];
        
        [_playCountImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(logView);
            make.left.equalTo(logView.mas_left).offset(playCountImgH * 0.2);
            make.bottom.equalTo(logView.mas_bottom).offset(- playCountImgH * 0.2);
            make.width.mas_equalTo(playCountImgW);
        }];
        
        [_playCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(logView);
            make.left.equalTo(_playCountImageView.mas_right).offset(playCountImgW * 0.2);
            make.bottom.equalTo(_playCountImageView.mas_bottom);
            //make.width.mas_equalTo(titleImgViewW/2 - )
            //        make.right.equalTo(logView.m)
            make.trailing.mas_equalTo(logView.mas_centerX);
        }];
        
        [_danmuCountImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(logView);
            make.left.equalTo(logView.mas_centerX).offset(playCountImgH * 0.2);
            make.bottom.equalTo(_playCountImageView.mas_bottom);
            make.width.mas_equalTo(playCountImgW);
        }];
        
        [_dumuCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(logView);
            make.left.equalTo(_danmuCountImageView.mas_right).offset(playCountImgW * 0.2);
            make.bottom.equalTo(_playCountImageView.mas_bottom);
            make.right.equalTo(logView.mas_right).offset(- playCountImgH * 0.2);
        }];
        
        _playCountLabel.textColor = [UIColor whiteColor];
        _dumuCountLabel.textColor = [UIColor whiteColor];
        
        return self;
    }
    return self;
}

- (void)layoutCellWithModel:(HomeCellModel *)model
{
    [_titleImgView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:nil];
    _titleLabel.text = model.title;
    _titleLabel.numberOfLines = 0;
    _titleLabel.font = [UIFont systemFontOfSize:9.0f];
    
    _playCountImageView.image  = [UIImage imageNamed:@"misc_playCount_new"];
    _danmuCountImageView.image = [UIImage imageNamed:@"misc_danmakuCount_new"];
    
    _playCountLabel.text = [model.play stringValue]?[model.play stringValue] : @"0";
    _dumuCountLabel.text = [model.danmaku stringValue]?[model.danmaku stringValue] : @"0";
    _playCountLabel.font = _titleLabel.font;
    _dumuCountLabel.font = _titleLabel.font;
}

- (void)prepareForReuse
{
    _titleLabel.text = nil;
}

@end
