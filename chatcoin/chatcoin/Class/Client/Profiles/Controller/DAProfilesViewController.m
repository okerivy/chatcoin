//
//  DAProfilesViewController.m
//  chatcoin
//
//  Created by okerivy on 2017/2/6.
//  Copyright © 2017年 okerivy. All rights reserved.
//

#import "DAProfilesViewController.h"
#import "DANavigationController.h"
#import "LYSideslipCell.h"
#import "DAChatViewController.h"
#import "UIKit+LLExt.h"
#import "DATableView.h"
#import "DAProfilesCell.h"
#import "DAAccountNumController.h"
#import "DAWalletViewController.h"




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

@interface DAProfilesViewController ()
<LYSideslipCellDelegate,
UITableViewDelegate,
UITableViewDataSource,
UINavigationControllerDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;



@property (nonatomic) DATableView *tableView;

@end

@implementation DAProfilesViewController

#pragma mark- Static变量



#pragma mark- 系统方法


- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    [self initData];
    
    self.tableView = [[DATableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    self.tableView.backgroundColor = kLLBackgroundColor_Default;

    self.tableView.separatorInset = UIEdgeInsetsMake(0, 8, 0, 0);
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, MAIN_BOTTOM_TABBAR_HEIGHT, 0);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 50.0;
    
    [self.view addSubview:self.tableView];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
}



#pragma mark- 初始化方法


- (void)initData
{

    
}


#pragma mark- set方法



#pragma mark- 监听方法



#pragma mark- 代理方法 Delegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

// 第一组没有索引
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    return 1;
}


- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 20;
    }
    return 30;
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = ZKColor_Clear;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DAProfilesCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(DAProfilesCell.class)];
    if (!cell) {
        cell = [[DAProfilesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(DAProfilesCell.class)];
        cell.delegate = self;
    }
    // 取消 cell 的选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;




    if (indexPath.section==0) {
        if (indexPath.row ==0) {
            cell.userNameLabel.text = @"账号";
            cell.iconImageView.image = [UIImage imageNamed:@"center_subcription"];
        } else if (indexPath.row ==1) {
            cell.userNameLabel.text = @"钱包";
            cell.iconImageView.image = [UIImage imageNamed:@"center_Wallet"];

        }
    } else if (indexPath.section==1) {
        cell.userNameLabel.text = @"网络";
        cell.iconImageView.image = [UIImage imageNamed:@"center_subcription"];
        
    }
    
    
    return cell;
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




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [tableView deselectRowAtIndexPath:indexPath animated:NO];
            DAAccountNumController * chatVC = [[DAAccountNumController alloc] init];
            [self.navigationController pushViewController:chatVC animated:YES];
        } else if (indexPath.row == 1) {
            [tableView deselectRowAtIndexPath:indexPath animated:NO];
            DAWalletViewController * chatVC = [[DAWalletViewController alloc] init];
            [self.navigationController pushViewController:chatVC animated:YES];
        }
    } else if (indexPath.section == 1) {
        
    }
    
    return;
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
