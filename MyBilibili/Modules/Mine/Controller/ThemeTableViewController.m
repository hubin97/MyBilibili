//
//  ThemeTableViewController.m
//  MyBilibili
//
//  Created by Hubin_Huang on 16/10/30.
//  Copyright © 2016年 Hubin_Huang. All rights reserved.
//

#import "ThemeTableViewController.h"


@interface ThemeTableViewController ()
{
    NSArray *_dataSourceArr;
}

@end

@implementation ThemeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    _dataSourceArr = @[@"樱粉红",@"纯白"];
    
    self.navigationController.navigationBar.hidden = NO;

    
//    WS(ws);
    
//    UITableView *themeTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    UITableView *themeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) style:UITableViewStyleGrouped];


 
//    [themeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.bottom.right.equalTo(ws.view);
//    }];
 
    [themeTableView setDataSource:self];
    [themeTableView setDelegate:self];
    
    [themeTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"themeTableCell"];

    UIView *footView = [[UIView alloc]init];
    footView.frame = CGRectZero;
    
    themeTableView.tableFooterView = footView;
    
    [self.view addSubview:themeTableView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    static NSString *themeCellIdf = @"themeTableCell";

    UITableViewCell *cell = nil;
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:themeCellIdf];
    }
    
   //cell =  [tableView dequeueReusableCellWithIdentifier:themeCellIdf forIndexPath:indexPath];
    

    // Configure the cell...
    cell.textLabel.text = _dataSourceArr[indexPath.row];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
