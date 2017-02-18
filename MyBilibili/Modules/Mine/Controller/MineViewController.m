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

#import "ThemeTableViewController.h"


#define col 4  //4列
#define sectionHeaderH 30

#define controlColor [UIColor colorWithDisplayP3Red:246/255.0 green:246/255.0 blue:246/255.0 alpha:1]

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
    
    [self layoutNavi];
    
    [self layoutFlow];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
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

- (void)layoutNavi
{
    UIView *naviBar = [[UIView alloc] init];
    [self.view addSubview:naviBar];
    
    naviBar.backgroundColor = cherryPowder;

    [naviBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenW);
        make.height.mas_equalTo(@(150 *k5SWScale));
    }];
    
    UIImageView *settingImgView = [[UIImageView alloc] init];
    [naviBar addSubview:settingImgView];
    settingImgView.image = [UIImage imageNamed:@"mine_settings"];
    [settingImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(naviBar.mas_top).offset(30 * k5SWScale);
        make.right.equalTo(naviBar.mas_right).offset(-15 * k5SWScale);
        make.width.height.mas_equalTo(@(20 * k5SWScale));
    }];
    
    
    UIButton *signInBtn = [[UIButton alloc]init];
    UIButton *loginBtn  = [[UIButton alloc]init];
    [naviBar addSubview:signInBtn];
    [naviBar addSubview:loginBtn];
    
    [signInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.left.mas_equalTo(@(50 *k5SWScale));
        //make.centerX.mas_equalTo(naviBar).offset((signInBtn.mas_width)-10 *k5SWScale);
        make.trailing.mas_equalTo(naviBar.mas_centerX).offset(-10 *k5SWScale);
        
        make.height.mas_equalTo(@(35 *k5SWScale));
        make.centerY.equalTo(naviBar).offset(20 *k5SWScale);
        make.width.mas_equalTo(signInBtn.mas_height).multipliedBy(3);
    }];
    
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.centerX.mas_equalTo(naviBar).offset(10 *k5SWScale);
        
        make.leading.mas_equalTo(naviBar.mas_centerX).offset(10 *k5SWScale);
        make.width.mas_equalTo(signInBtn);
        make.height.mas_equalTo(signInBtn);
        make.centerY.equalTo(signInBtn);
        //make.left.mas_equalTo(signInBtn.mas_right).offset(10 *k5SWScale);
    }];
    DrawViewBorderRadius(signInBtn, 5, 1, [UIColor clearColor]);
    DrawViewBorderRadius(loginBtn, 5, 1, [UIColor clearColor]);
    
    [signInBtn setTitle:@"注册" forState:UIControlStateNormal];
//    [signInBtn setBackgroundColor:[UIColor colorWithDisplayP3Red:257/255.0 green:117/255.0 blue:156/255.0 alpha:1.0]];
    [signInBtn setBackgroundColor:[UIColor colorWithRed:257/255.0 green:117/255.0 blue:156/255.0 alpha:1.0]];

    [signInBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:[UIColor whiteColor]];
    [loginBtn setTitleColor:cherryPowder forState:UIControlStateNormal];
    
    signInBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    
//    WS(ws);
//    
//    //画圆角 凹
//    UIView *lineView = [[UIView alloc] init];
//    [self.view addSubview:lineView];
//    
//    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(naviBar.mas_bottom);
//        make.leading.trailing.mas_equalTo(naviBar);
//        make.height.mas_equalTo(@(20 * k5SWScale));
//    }];
//    
//    lineView.backgroundColor = cherryPowder;
//
//    UILabel *lineLabel = [[UILabel alloc]init];
//    [lineView addSubview:lineLabel];
//    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(lineView).insets(UIEdgeInsetsZero);
//    }];
//    
//    lineLabel.backgroundColor = [UIColor clearColor];
////    DrawViewBorderRadius(lineLabel, 10, 1, [UIColor blackColor]);
//    DrawViewBorderRadius(lineLabel, 10, 1, [UIColor whiteColor]);

}


- (void)layoutFlow
{
    WS(ws);
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize = CGSizeMake(kScreenW/col, kScreenW/col *1.2);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    _mineCollection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.view addSubview:_mineCollection];
    
    _mineCollection.backgroundColor = cherryPowder;//[UIColor whiteColor];
    _mineCollection.showsHorizontalScrollIndicator = NO;
    _mineCollection.showsVerticalScrollIndicator = NO;
    
    [_mineCollection setDataSource:self];
    [_mineCollection setDelegate:self];
    
    //DrawViewBorderRadius(_mineCollection, 2, 2, cherryPowder);
    
    [layout setHeaderReferenceSize:CGSizeMake(kScreenW, sectionHeaderH)]; //设置headview 的大小
    //由段决定
    //[layout setFooterReferenceSize:CGSizeMake(kScreenW, sectionHeaderH/3)]; //设置footview 的大小
    
    [_mineCollection registerClass:[MineCollectionViewCell class] forCellWithReuseIdentifier:@"mineMainCell"];
    
    [_mineCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view).insets(UIEdgeInsetsMake(150 *k5SWScale, 0, 49, 0));
    }];
    
    _mineCollection.contentSize = CGSizeMake(kScreenW, kScreenH);
    
    [_mineCollection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderIdentifier"];

    
    [_mineCollection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterIdentifier"];

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
//    return [_dataSourceArrs[section] count];
    return [_dataSourceArrs count] *col;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdent = @"mineMainCell";
    MineCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdent forIndexPath:indexPath];
   
    if (indexPath.row < [[_dataSourceArrs objectAtIndex:indexPath.section] count])
    {
        MineModel *model = [[_dataSourceArrs objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        
        [cell layoutWithModel:model];
        //NSLog(@"indexPath(%@)--Model(%@)",indexPath,model.title);
    }
    else
    {
        cell.backgroundColor = [UIColor whiteColor];
    }
   
//方法一
#if 1
    float cellwidth  = cell.frame.size.width;
    float cellheight = cell.frame.size.height;

    //top -> left -> bottom -> right
    CALayer *modifyBorder = [CALayer layer];
    modifyBorder.backgroundColor = controlColor.CGColor;
    
    CALayer *modifyBorder2 = [CALayer layer];
    modifyBorder2.backgroundColor = controlColor.CGColor;
    
    CALayer *modifyBorder3 = [CALayer layer];
    modifyBorder3.backgroundColor = controlColor.CGColor;
    
    CALayer *modifyBorder4 = [CALayer layer];
    modifyBorder4.backgroundColor = controlColor.CGColor;
    
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

//添加段头
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *HeaderIdentifier = @"HeaderIdentifier";
    static NSString *FooterIdentifier = @"FooterIdentifier";
    
    UICollectionReusableView *reusableView = nil;
    
    NSLog(@"kind = %@", kind);
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderIdentifier forIndexPath:indexPath];
        
        reusableView.backgroundColor = [UIColor whiteColor];
        
        if (reusableView)
        {
            UILabel *sectionLabel = [[UILabel alloc] init];
            sectionLabel.backgroundColor = [UIColor whiteColor];
            
            [reusableView addSubview:sectionLabel];
            
            [sectionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(reusableView).insets(UIEdgeInsetsMake(0, 20, 0, 0));
            }];
            
            if (indexPath.section == 0)
            {
                sectionLabel.text = @"个人中心";
            }
            else
            {
                sectionLabel.text = @"我的消息";
            }
            
            sectionLabel.textColor = [UIColor blackColor];
            sectionLabel.font = [UIFont systemFontOfSize:13];
        }
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter])
    {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:FooterIdentifier forIndexPath:indexPath];
        reusableView.backgroundColor = controlColor;
    }
    
    return reusableView;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < [[_dataSourceArrs objectAtIndex:indexPath.section] count])
    {
        MineModel *model = [[_dataSourceArrs objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        NSLog(@"indexPath(%@)--Model(%@)",indexPath,model.title);
        
        switch ([indexPath section])
        {
            case 0: //个人中心
            {
                switch ([indexPath row])
                {
                    case 0:
                    {}
                        break;
                    case 1:
                    {}
                        break;
                    case 2:
                    {}
                        break;
                    case 3:
                    {}
                        break;
                    case 4:
                    {}
                        break;
                    case 5:
                    {}
                        break;
                    case 6:
                    {
                        ThemeTableViewController *themeTableVc = [[ThemeTableViewController alloc] init];
                        [self.navigationController pushViewController:themeTableVc animated:YES];
                        //[self presentViewController:themeTableVc animated:NO completion:nil];
                    }
                        break;
                    default:
                        break;
                }
            }
                break;
             
            case 1: //我的消息
            {
            }
                break;
            default:
                break;
        }
        
        
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section == [_dataSourceArrs count] - 1)
    {
        return CGSizeMake(kScreenW, sectionHeaderH * 2);
    }
    return CGSizeMake(kScreenW, sectionHeaderH/3);
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
