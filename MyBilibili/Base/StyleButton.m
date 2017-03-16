//
//  StyleButtom.m
//  MyStyleBtnDemo
//
//  Created by Hubin_Huang on 2017/3/16.
//  Copyright © 2017年 Hubin_Huang. All rights reserved.
//

#import "StyleButton.h"


@implementation StyleButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



- (void)setMyStyle:(UIButtonStyle)myStyle
{
    if (_myStyle != myStyle)
    {
        _myStyle = myStyle;
    }
}

- (void)setRatio:(CGFloat)ratio
{
    if (_ratio != ratio)
    {
        _ratio = ratio;
    }
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    if(!_ratio) _ratio = 0.5;
    
    CGRect imageRect = contentRect;
    
    switch (_myStyle) {
        case UIButtonLeftRightStyle:
        {
            imageRect.size.width  *= _ratio;
        }
            break;
        case UIButtonTopBottomStyle:
        {
            imageRect.size.height *= _ratio;
        }
            break;
        case UIButtonRightLeftStyle:
        {
            imageRect.origin.x += (imageRect.size.width * (1 - _ratio));
            imageRect.size.width  *= _ratio;
        }
            break;
        case UIButtonBottomTopStyle:
        {
            imageRect.origin.y += (imageRect.size.height * (1 - _ratio));
            imageRect.size.height *= _ratio;
        }
            break;
        default:
            break;
    }
    return imageRect;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    if(!_ratio) _ratio = 0.5;

    CGRect titleRect = contentRect;
    
    switch (_myStyle) {
        case UIButtonLeftRightStyle:
        {
            titleRect.origin.x += (titleRect.size.width * _ratio);
            titleRect.size.width  *= (1 -_ratio);
        }
            break;
        case UIButtonTopBottomStyle:
        {
            titleRect.origin.y += (titleRect.size.height * _ratio);
            titleRect.size.height *= (1 -_ratio);
        }
            break;
        case UIButtonRightLeftStyle:
        {
            titleRect.size.width  *= (1 -_ratio);
        }
            break;
        case UIButtonBottomTopStyle:
        {
            titleRect.size.height *= (1 -_ratio);
        }
            break;
        default:
            break;
    }
    
    return titleRect;
}

//- (CGRect)backgroundRectForBounds:(CGRect)bounds
//{}
//- (CGRect)contentRectForBounds:(CGRect)bounds
//{}

@end
