//
//  HomeCollectionViewCell.h
//  MyBilibili
//
//  Created by Hubin_Huang on 2017/2/22.
//  Copyright © 2017年 Hubin_Huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeCellModel.h"

@interface HomeCollectionViewCell : UICollectionViewCell

- (void)layoutCellWithModel:(HomeCellModel *)model;

@end
