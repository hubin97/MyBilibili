//
//  HomeViewController.m
//  MyBilibili
//
//  Created by Hubin_Huang on 16/9/24.
//  Copyright © 2016年 Hubin_Huang. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@end

@implementation HomeViewController

#pragma mark - Live life
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //DrawViewBorderRadius(self.view, 0, 2, [UIColor redColor]);
    [self initNavi];
    
    [self initCollection];
}

#pragma mark - Setup
- (void)initNavi
{
    UIView *naviBar = [[UIView alloc] init];
    [self.view addSubview:naviBar];
    
    naviBar.backgroundColor = cherryPowder;

    [naviBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenW);
        make.height.mas_equalTo(@(52 *k5SWScale));
    }];
    
    //测试
    NSArray *titles = @[@"直播",@"推荐",@"番剧"];
    
    for (int i = 0; i < [titles count]; i ++)
    {
        UIButton *titleBtn = [[UIButton alloc] init];
        [naviBar addSubview:titleBtn];
        UILabel *titleFlag = [[UILabel alloc]init];
        [naviBar addSubview:titleFlag];
        
        [titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(@(20 *k5SWScale));
            make.left.equalTo(naviBar).offset(kScreenW * 2/9  * (i + 1));
            make.width.mas_equalTo(@(kScreenW *1/9));
        }];
        
        [titleFlag mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(naviBar).offset(kScreenW * 2/9 * (i + 1));
            make.top.equalTo(titleBtn.mas_bottom).offset(2);
            make.bottom.equalTo(naviBar.mas_bottom).offset(-1);
            make.width.equalTo(titleBtn.mas_width);
            make.height.mas_equalTo(@2);
        }];
        
        [titleBtn setTitle:titles[i] forState:UIControlStateNormal];
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       
        //默认选择第一个
        [titleFlag setBackgroundColor:((i == 1)?[UIColor whiteColor] : [UIColor clearColor])];
        
        titleBtn.tag  = 100 + i;
        titleFlag.tag = 110 + i;
        [titleBtn addTarget:self action:@selector(changeTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)initCollection
{
//    UIView *bgView = [[UIView alloc]init];
//    [self.view addSubview:bgView];
//    [bgView setBackgroundColor:cherryPowder];
//    DrawViewBorderRadius(bgView, 1, 1, [UIColor blueColor]);
//    
//    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.insets = UIEdgeInsetsMake(52 *k5SWScale, 0, 49, 0);
//    }];
    
    
    int col = 2; //列
    CGFloat padding = 10 * k5SWScale;
    CGFloat itemW = (kScreenW - (col + 1)*padding)/col;
    CGFloat itemH = itemW *3 / 4;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //4 : 3
    layout.itemSize = CGSizeMake(itemW, itemH);
    
    layout.minimumLineSpacing = padding;
    layout.minimumInteritemSpacing = padding;
    layout.sectionInset = UIEdgeInsetsMake(0, padding, 0, padding);
    
    [layout setHeaderReferenceSize:CGSizeMake(kScreenW, 40)]; //设置headview 的大小

    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:collectionView];

    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"HomeCell"];
    
    //DrawViewBorderRadius(collectionView, 1, 1, [UIColor brownColor]);
    
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets = UIEdgeInsetsMake(52 *k5SWScale, 0, 49, 0);
    }];
    
//    collectionView.bouncesZoom = NO;
    collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    collectionView.contentOffset = CGPointMake(0, 0);
    
    

    //[collectionView bringSubviewToFront:self.view];

    //collectionView.foo
}



#pragma mark - Action
- (void)changeTitleBtn:(UIButton *)sender
{
    NSLog(@"Home-title%@",sender.titleLabel.text);
    
    for (int i = 110 ; i < 113; i ++)
    {
        UILabel *titleFlag = [self.view viewWithTag:i];
        //NSLog(@"titleFlag:%@",titleFlag);
        [titleFlag setBackgroundColor:((i == (sender.tag + 10))?[UIColor whiteColor] : [UIColor clearColor])];
    }
}


#pragma mark - coll
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 5;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdent = @"HomeCell";

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdent forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    DrawViewBorderRadius(cell, 1, 1, [UIColor redColor]);
    return cell;
}

@end
