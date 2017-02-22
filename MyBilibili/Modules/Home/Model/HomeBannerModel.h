//
//  HomeBannerModel.h
//  MyBilibili
//
//  Created by Hubin_Huang on 2017/2/22.
//  Copyright © 2017年 Hubin_Huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeBannerModel : NSObject

/**
 "hash" : "7a3954660236a823b297b89c5993145e",
 "id" : 35110,
 "image" : "http://i0.hdslb.com/bfs/archive/3873e99c30e77546d2637e531aa13d17c34436bd.jpg",
 "is_ad" : false,
 "title" : "鬼畜0221",
 "uri" : "http://www.bilibili.com/blackboard/activity-SykvysbYg.html"
 */
@property (nonatomic, copy) NSString *Hash;
@property (nonatomic, strong) NSNumber *Id;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, assign) BOOL   is_ad;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *uri;


@end
