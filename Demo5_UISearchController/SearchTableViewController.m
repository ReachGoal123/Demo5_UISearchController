//
//  SearchTableViewController.m
//  Demo5_UISearchController
//
//  Created by tarena on 15-1-28.
//  Copyright (c) 2015年 Tarena. All rights reserved.
//

#import "SearchTableViewController.h"
#import "TRPerson.h"
#import "UIColor+RandomColor.h"

@interface SearchTableViewController () <UISearchResultsUpdating>
@property (nonatomic, strong)NSMutableArray *allData;//存放所有数据
@property (nonatomic, strong)NSMutableArray *searchResultData;//存放搜索结果数据

//用于搜索的专用VC
@property(nonatomic, strong)UISearchController *searchController;
//显示搜索结果的TVC
@property(nonatomic, strong)UITableViewController *searchTVC;

@end

@implementation SearchTableViewController

- (NSMutableArray *)allData
{
    if (!_allData) {
        TRPerson *p1 = [[TRPerson alloc]initWithName:@"武媚娘" phoneNumber:@"1383838438" gender:@"女"];
        TRPerson *p2 = [[TRPerson alloc]initWithName:@"武媚娘" phoneNumber:@"1393939439" gender:@"女"];
        TRPerson *p3 = [[TRPerson alloc]initWithName:@"武媚娘" phoneNumber:@"1373838438" gender:@"女"];
        TRPerson *p4 = [[TRPerson alloc]initWithName:@"武媚娘" phoneNumber:@"1363838438" gender:@"女"];
        TRPerson *p5 = [[TRPerson alloc]initWithName:@"武媚娘" phoneNumber:@"1383838438" gender:@"女"];
        _allData = [@[ p1, p2, p3, p4, p5]mutableCopy];
    }
    return _allData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.tableView) {
        return self.allData.count;
    }else{
        return self.searchResultData.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //一直从self.tableView中获取Cell原型
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"SearchCell" forIndexPath:indexPath];
    TRPerson *person = nil;
    if (tableView == self.tableView) {
        person = self.allData[indexPath.row];
    } else {
        person = self.searchResultData[indexPath.row];
    }
    
    cell.textLabel.text = person.name;
    cell.textLabel.textColor = [UIColor blueColor];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:35.0f];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@    %@", person.phoneNumber, person.gender];
    cell.detailTextLabel.textColor = [UIColor brownColor];
    cell.detailTextLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    cell.imageView.image = [UIImage imageNamed:@"a"];
    cell.backgroundColor = [UIColor randomColor];
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

//返回一组可以对Cell进行的操作(iOS8及以上支持)
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *topRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"置顶" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"第%d行Cell被置顶了", indexPath.row);
        [tableView setEditing:NO animated:YES];
    }];
    UITableViewRowAction *markRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"标记骚扰" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"第%d行Cell被标记了", indexPath.row);
        [tableView setEditing:NO animated:YES];
    }];
    markRowAction.backgroundColor = [UIColor blueColor];
    UITableViewRowAction *moreRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"更多..." handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"第%d行Cell展示更多内容", indexPath.row);
        [tableView setEditing:NO animated:YES];
    }];
    return @[topRowAction, markRowAction, moreRowAction];
}
- (IBAction)searchPerson:(UIBarButtonItem *)sender {
    //创建显示搜索结果的TableViewController
    if (!_searchTVC) {
        _searchTVC = [[UITableViewController alloc]initWithStyle:UITableViewStylePlain];
    }
    self.searchTVC.tableView.dataSource = self;
    self.searchTVC.tableView.delegate = self;
    
    //创建搜索控制器
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:self.searchTVC];
    //当搜索框中的内容发生变化时，由谁来处理
    self.searchController.searchResultsUpdater = self;
    //提示信息
    self.searchController.searchBar.placeholder = @"姓名 | 电话 | 性别";
    self.searchController.searchBar.prompt = @"请输入要查询的家伙";
    //展示搜索控制器
    [self presentViewController:self.searchController animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    //1. 获取输入的要搜索的数据
    NSString *conditionStr = searchController.searchBar.text;
    //2. 创建谓词, 准备进行判断
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.phoneNumber contains [cd] %@ OR self.name contains [cd] %@ OR self.gender contains [cd] %@", conditionStr, conditionStr, conditionStr];
    //3. 获取匹配的结果
    self.searchResultData = [NSMutableArray arrayWithArray:[self.allData filteredArrayUsingPredicate:predicate]];
    //4. 刷新
    [self.searchTVC.tableView reloadData];
}




@end
