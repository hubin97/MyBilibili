//
//  MineCollectionViewCell.m
//  MyBilibili
//
//  Created by Hubin_Huang on 16/10/24.
//  Copyright © 2016年 Hubin_Huang. All rights reserved.
//

#import "MineCollectionViewCell.h"

@implementation MineCollectionViewCell
{
    UIImageView *imageView;
    UILabel *titleLabel;
}
- (void)layoutWithModel:(MineModel *)model
{
    CGFloat cellWidth  = kScreenW/4;
    //CGFloat cellHeight = cellWidth *1.2;
    CGFloat iconSide  = cellWidth/3;
//    CGFloat iconSide  = 26;
    self.backgroundColor = [UIColor whiteColor];
    
    WS(ws);
    
    imageView = [[UIImageView alloc]init];
    [self addSubview:imageView];
    
    titleLabel = [[UILabel alloc]init];
    [self addSubview:titleLabel];
    
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(ws.mas_top).offset(iconSide);
        make.left.equalTo(ws.mas_left).offset(iconSide);
        make.right.equalTo(ws.mas_right).offset(-iconSide);
        make.height.mas_equalTo(@(iconSide));
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(imageView.mas_bottom).offset(5 *k5SWScale);
        make.left.right.equalTo(ws);
        make.height.mas_equalTo(@(iconSide));
    }];
    
    
    //DrawViewBorderRadius(imageView, 0, 1, [UIColor redColor]);
    //DrawViewBorderRadius(titleLabel, 0, 1, [UIColor redColor]);

    //MineModel
    imageView.image = [UIImage imageNamed:[model icon]];
    titleLabel.text = [model title];
    titleLabel.font = [UIFont systemFontOfSize:12 *k5SWScale];
    titleLabel.textAlignment = NSTextAlignmentCenter;
}


//解决滑动复用问题
- (void)prepareForReuse
{
    imageView.image = nil;
    titleLabel.text = nil;
}
@end
