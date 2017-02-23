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
    UILabel *_titleLabel;
}

@end
@implementation HomeCollectionViewCell

- (void)layoutCellWithModel:(HomeCellModel *)model
{
    WS(ws);
    
    //35/135   1/3
    UIImageView *titleImgView = [[UIImageView alloc]init];
    [self addSubview:titleImgView];
    
    DrawViewBorderRadius(titleImgView, 5, 1, [UIColor clearColor]);

    _titleLabel = [[UILabel alloc]init];
    [self addSubview:_titleLabel];
    
    //CGFloat titleImgViewW = self.frame.size.width;
    CGFloat titleImgViewH = self.frame.size.height *3/4;
    
    //===========
    [titleImgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.right.equalTo(ws);
        make.height.mas_equalTo(titleImgViewH);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(titleImgView.mas_bottom).offset(5);
        make.left.right.bottom.equalTo(ws);
    }];
    
    [titleImgView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:nil];
    _titleLabel.text = model.title;
    _titleLabel.numberOfLines = 0;
    _titleLabel.font = [UIFont systemFontOfSize:9.0f];
    
    
    //=============
    UIView *logView = [[UIView alloc]init];
    [titleImgView addSubview:logView];
    logView.backgroundColor = [UIColor clearColor];
    
    //添加弹幕,播放计数视图
    UIImage *playCountImage  = [UIImage imageNamed:@"misc_playCount_new"];
    UIImage *danmuCountImage = [UIImage imageNamed:@"misc_danmakuCount_new"];
    
    CGFloat playCountImgW = playCountImage.size.width;
    CGFloat playCountImgH = playCountImage.size.height;
    
    [logView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(titleImgView);
        make.height.mas_equalTo(playCountImgH * 1.2);
    }];
    
    //DrawViewBorderRadius(logView, 1, 1, [UIColor whiteColor]);
    
    UIImageView *playCountImageView = [[UIImageView alloc]init];
    [logView addSubview:playCountImageView];
    UILabel *playCountLabel = [[UILabel alloc]init];
    [logView addSubview:playCountLabel];
    
    UIImageView *danmuCountImageView = [[UIImageView alloc]init];
    [logView addSubview:danmuCountImageView];
    UILabel *dumuCountLabel = [[UILabel alloc]init];
    [logView addSubview:dumuCountLabel];
    
    [playCountImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logView);
        make.left.equalTo(logView.mas_left).offset(playCountImgH * 0.2);
        make.bottom.equalTo(logView.mas_bottom).offset(- playCountImgH * 0.2);
        make.width.mas_equalTo(playCountImgW);
    }];
    
    [playCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logView);
        make.left.equalTo(playCountImageView.mas_right).offset(playCountImgW * 0.2);
        make.bottom.equalTo(playCountImageView.mas_bottom);
        //make.width.mas_equalTo(titleImgViewW/2 - )
//        make.right.equalTo(logView.m)
        make.trailing.mas_equalTo(logView.mas_centerX);
    }];
    
    [danmuCountImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logView);
        make.left.equalTo(logView.mas_centerX).offset(playCountImgH * 0.2);
        make.bottom.equalTo(playCountImageView.mas_bottom);
        make.width.mas_equalTo(playCountImgW);
    }];
    
    [dumuCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logView);
        make.left.equalTo(danmuCountImageView.mas_right).offset(playCountImgW * 0.2);
        make.bottom.equalTo(playCountImageView.mas_bottom);
        make.right.equalTo(logView.mas_right).offset(- playCountImgH * 0.2);
    }];
    
    playCountImageView.image = playCountImage;
    danmuCountImageView.image = danmuCountImage;
    
    playCountLabel.text = [model.play stringValue]?[model.play stringValue] : @"0";
    dumuCountLabel.text = [model.danmaku stringValue]?[model.danmaku stringValue] : @"0";
    playCountLabel.font = _titleLabel.font;
    dumuCountLabel.font = _titleLabel.font;
    
    playCountLabel.textColor = [UIColor whiteColor];
    dumuCountLabel.textColor = [UIColor whiteColor];
    
}

- (void)prepareForReuse
{
    _titleLabel.text = nil;
}

@end
