//
//  DAFlowTransactionController.m
//  chatcoin
//
//  Created by okerivy on 2017/2/22.
//  Copyright © 2017年 okerivy. All rights reserved.
//

#import "DAFlowTransactionController.h"



#import "DANavigationController.h"
#import "LYSideslipCell.h"
#import "DAChatViewController.h"
#import "UIKit+LLExt.h"
#import "DATableView.h"

#import "DATransactionCell.h"


#define kIcon @"kIcon"
#define kName @"kName"
#define kTime @"kTime"
#define kMessage @"kMessage"


//navigationBar右侧按钮距离屏幕边缘的距离
#define NAVIGATION_BAR_RIGHT_MARGIN 5

#define NAVIGATION_BAR_HEIGHT 64

#define MAIN_BOTTOM_TABBAR_HEIGHT 50

#define TABLE_VIEW_CELL_DEFAULT_FONT_SIZE 17

#define TABLE_VIEW_CELL_LEFT_MARGIN 20

#define TABLE_VIEW_CELL_DEFAULT_HEIGHT 44

#define FOOTER_LABEL_FONT_SIZE 14



@interface DAFlowTransactionController ()
<LYSideslipCellDelegate,
UITableViewDelegate,
UITableViewDataSource,
UINavigationControllerDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) DATableView *tableView;



@end

@implementation DAFlowTransactionController


#pragma mark- Static变量



#pragma mark- 系统方法


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"交易记录";
    _dataArray = [NSMutableArray array];
    [self initData];
    
    self.view.backgroundColor = kLLBackgroundColor_Default;
    self.tableView = [[DATableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    self.tableView.backgroundColor = kLLBackgroundColor_Default;
    
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 8, 0, 0);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    
    
}



#pragma mark- 初始化方法


- (void)initData
{
    for (int i = 0; i<6; i++) {
        [self.dataArray addObject:[NSString stringWithFormat:@"测试--%zd",i]];
    }
    
    
}


#pragma mark- set方法



#pragma mark- 监听方法


- (void)deleteAcount
{
    if (self.dataArray.count > 0) {
        [self.dataArray removeLastObject];
        [self.tableView reloadData];
    }
    
}

- (void)copyAcount
{
    
}

#pragma mark- 代理方法 Delegate




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *_cell;
    DATransactionCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(DATransactionCell.class)];
    if (!cell) {
        cell = [[DATransactionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(DATransactionCell.class)];
        cell.delegate = self;
    }
    _cell = cell;
    
    // 取消 cell 的选中效果
    _cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return _cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    return;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.preservesSuperviewLayoutMargins = NO;
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 0)];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 10, 0, 0)];
    }
}



#pragma mark - LYSideslipCellDelegate
- (void)sideslipCell:(LYSideslipCell *)sideslipCell rowAtIndexPath:(NSIndexPath *)indexPath didSelectedAtIndex:(NSInteger)index {
    NSLog(@"选中了: %ld", index);
}

- (BOOL)sideslipCell:(LYSideslipCell *)sideslipCell canSideslipRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
    
    if (indexPath.row == 4) {
        return NO;
    }
    return YES;
}


#pragma mark- 其他方法




#pragma mark- 懒加载



@end
