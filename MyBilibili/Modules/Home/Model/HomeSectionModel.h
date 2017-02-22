//
//  HomeSectionModel.h
//  MyBilibili
//
//  Created by Mac on 2017/2/22.
//  Copyright © 2017年 Hubin_Huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeSectionModel : NSObject

@property (nonatomic, strong) NSDictionary *banner;
@property (nonatomic, strong) NSArray *body;
@property (nonatomic, copy) NSString *param;
@property (nonatomic, copy) NSString *style;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *type;

@end
