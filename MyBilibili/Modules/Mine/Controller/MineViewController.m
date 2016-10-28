//
//  MineViewController.m
//  MyBilibili
//
//  Created by Hubin_Huang on 16/9/24.
//  Copyright © 2016年 Hubin_Huang. All rights reserved.
//

#import "MineViewController.h"

#import "MineCollectionViewCell.h"
#import "MineModel.h"

#define  col 4  //4列

@interface MineViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_mineCollection;
    NSArray *_dataSourceArrs;

}
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
  
    [self initDataSource];
    
    [self layoutFlow];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
   
}

- (void)initDataSource
{
    _dataSourceArrs = [[NSArray alloc]init];
    //个人中心
    NSArray *personCenterImgArrs = @[[self itemObjectWithIcon:@"mine_download" andTitle:@"离线缓存"],
                                     [self itemObjectWithIcon:@"mine_history" andTitle:@"历史记录"],
                                     [self itemObjectWithIcon:@"mine_favourite" andTitle:@"我的收藏"],
                                     [self itemObjectWithIcon:@"mine_follow" andTitle:@"我的关注"],
                                     [self itemObjectWithIcon:@"mine_pocketcenter" andTitle:@"我的钱包"],
                                     [self itemObjectWithIcon:@"mine_gamecenter" andTitle:@"游戏中心"],
                                     [self itemObjectWithIcon:@"mine_theme" andTitle:@"主题选择"]];
    
    //我的消息
    NSArray *myMessageImgArrs    = @[[self itemObjectWithIcon:@"mine_answerMessage" andTitle:@"回复我的"],
                                     [self itemObjectWithIcon:@"mine_shakeMe" andTitle:@"@我"],
                                     [self itemObjectWithIcon:@"mine_gotPrise" andTitle:@"收到的赞"],
                                     [self itemObjectWithIcon:@"mine_privateMessage" andTitle:@"私信"],
                                     [self itemObjectWithIcon:@"mine_systemNotification" andTitle:@"系统通知"]];
    
    _dataSourceArrs = @[personCenterImgArrs,myMessageImgArrs];
}

- (MineModel *)itemObjectWithIcon:(NSString *)iconStr andTitle:(NSString *)title
{
    MineModel *mindeModel = [[MineModel alloc]init];
    mindeModel.icon  = iconStr;
    mindeModel.title = title;
    return mindeModel;
}


- (void)layoutFlow
{
    WS(ws);
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize = CGSizeMake(kScreenW/col, kScreenW/col *1.2);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(10, 0, 0, 0);
    
    _mineCollection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.view addSubview:_mineCollection];
    
    _mineCollection.backgroundColor = [UIColor whiteColor];
    _mineCollection.showsHorizontalScrollIndicator = NO;
    _mineCollection.showsVerticalScrollIndicator = NO;
    
    [_mineCollection setDataSource:self];
    [_mineCollection setDelegate:self];
    
    //DrawViewBorderRadius(_mineCollection, 2, 2, [UIColor blueColor]);
    
    [_mineCollection registerClass:[MineCollectionViewCell class] forCellWithReuseIdentifier:@"mineMainCell"];
    
    [_mineCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view).insets(UIEdgeInsetsMake(150 *k5SWScale, 0, 49, 0));
    }];
    
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [_dataSourceArrs count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_dataSourceArrs[section] count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdent = @"mineMainCell";
    MineCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdent forIndexPath:indexPath];
   
    MineModel *model = [[_dataSourceArrs objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    [cell layoutWithModel:model];
    NSLog(@"indexPath(%@)--Model(%@)",indexPath,model.title);
    

//方法一
#if 1
    float cellwidth  = cell.frame.size.width;
    float cellheight = cell.frame.size.height;

    //top -> left -> bottom -> right
    CALayer *modifyBorder = [CALayer layer];
    modifyBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    
    CALayer *modifyBorder2 = [CALayer layer];
    modifyBorder2.backgroundColor = [UIColor lightGrayColor].CGColor;
    
    CALayer *modifyBorder3 = [CALayer layer];
    modifyBorder3.backgroundColor = [UIColor lightGrayColor].CGColor;
    
    CALayer *modifyBorder4 = [CALayer layer];
    modifyBorder4.backgroundColor = [UIColor lightGrayColor].CGColor;
    
    [cell.layer addSublayer:modifyBorder];
    [cell.layer addSublayer:modifyBorder2];
    [cell.layer addSublayer:modifyBorder3];
    [cell.layer addSublayer:modifyBorder4];

    
    unsigned long currentSectionrow = [[_dataSourceArrs objectAtIndex:indexPath.section] count] /col;
    
    if ([[_dataSourceArrs objectAtIndex:indexPath.section] count] % col > 0)
    {
        currentSectionrow += 1;
    }
    
    if (indexPath.row /col < currentSectionrow - 1)
    {
        modifyBorder.frame  = CGRectMake(0.0f, 0.0f, cellwidth, 1.0f);
    }
    
    modifyBorder2.frame = CGRectMake(0.0f, 0.0f, 1.0f, cellheight);
    modifyBorder3.frame = CGRectMake(0.0f, cellheight-1.0f, cellwidth, 1.0f);
    modifyBorder4.frame = CGRectMake(cellwidth -0.1f, 0.0f, 1.0f, cellheight);
    
#endif
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MineModel *model = [[_dataSourceArrs objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    NSLog(@"indexPath(%@)--Model(%@)",indexPath,model.title);
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
