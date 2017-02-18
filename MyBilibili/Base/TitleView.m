//
//  TitleView.m
//  LoopBrowsDemo
//
//  Created by Mac on 2017/2/16.
//  Copyright © 2017年 TUTK. All rights reserved.
//

#import "TitleView.h"

#define kpadding (10 *k5SWScale)

@interface TitleView()
{
    UILabel *_indexLabel; //下标label
    NSArray *_titleArr;   //标题数组
}

@end

@implementation TitleView

- (instancetype)initWithFrame:(CGRect)frame andTitles:(NSArray *)titles
{
    if(self = [super initWithFrame:frame])
    {
        //layout
        NSInteger btnCount = [titles count];
        //padding = 10;
        CGFloat btnWidth = (frame.size.width - (btnCount + 1) * kpadding)/ btnCount;
        NSLog(@"btnWidth:%f",btnWidth); // >57.50
        
        _titleArr = titles;
        
        CGRect assagnBtnRect = CGRectZero;
        
        for (NSInteger index = 0; index < [titles count]; index ++)
        {
            UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            titleBtn.frame = CGRectMake(kpadding* (index + 1) + btnWidth * index, kpadding *3/5, btnWidth, frame.size.height/2 *k5SWScale);
//            titleBtn.layer.borderWidth = 1.0;
//            titleBtn.layer.borderColor = [[UIColor brownColor] CGColor];
            titleBtn.tag = index;
            titleBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];

            [titleBtn setTitle:[titles objectAtIndex:index] forState:UIControlStateNormal];
            [titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            if([titles count] > 1)
            {
                [titleBtn addTarget:self action:@selector(tapTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
            }
            [self addSubview:titleBtn];
            
            assagnBtnRect = (index == 1)? titleBtn.frame : assagnBtnRect;
        }
        
        if([titles count] > 1)
        {
            //下标线
            CGRect indexLabelFrame = assagnBtnRect;
            indexLabelFrame.origin.y += (assagnBtnRect.size.height + kpadding/2);
            indexLabelFrame.origin.x += kpadding/2;
            indexLabelFrame.size.width = assagnBtnRect.size.width - kpadding;
            indexLabelFrame.size.height = kpadding/5;
            
            _indexLabel = [[UILabel alloc]initWithFrame:indexLabelFrame];
            _indexLabel.backgroundColor =[UIColor whiteColor];
            [self addSubview:_indexLabel];
        }
        return self;
    }
    return self;
}

//点击后, callback给调用者
- (void)tapTitleBtn:(UIButton *)sender
{
    NSLog(@"titleView:------%@",sender.titleLabel.text);

    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect rect = _indexLabel.frame;
        rect.origin.x = sender.frame.origin.x + kpadding/2;
        _indexLabel.frame = rect;
    }];
    
    _titleBtnBlock(sender.tag ,sender.titleLabel.text);
}

- (void)updataIndexLabelUIWithNum:(NSInteger)num
{
    if(num < 0 || num > _titleArr.count - 1) return;
   
    UIButton *tmpBtn = [self viewWithTag:num];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect rect = _indexLabel.frame;
        rect.origin.x = tmpBtn.frame.origin.x + kpadding/2;
        _indexLabel.frame = rect;
    }];
}

@end
