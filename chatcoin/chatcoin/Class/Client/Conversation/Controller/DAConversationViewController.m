//
//  DAConversationViewController.m
//  chatcoin
//
//  Created by okerivy on 2017/2/4.
//  Copyright © 2017年 okerivy. All rights reserved.
//

#import "DAConversationViewController.h"
#import "DANavigationController.h"
#import "LYSideslipCell.h"
#import "LYHomeCell.h"
#import "DAChatViewController.h"
#import "LLSearchBar.h"
#import "UIKit+LLExt.h"
#import "LLSearchViewController.h"
#import "LLSearchControllerDelegate.h"
#import "LLChatSearchController.h"
#import "DATableView.h"


#define kIcon @"kIcon"
#define kName @"kName"
#define kTime @"kTime"
#define kMessage @"kMessage"


typedef NS_ENUM(NSInteger, LLConnectionState) {
    kLLConnectionStateConnected = 0,
    kLLConnectionStateDisconnected,
};

//navigationBar右侧按钮距离屏幕边缘的距离
#define NAVIGATION_BAR_RIGHT_MARGIN 5

#define NAVIGATION_BAR_HEIGHT 64

#define MAIN_BOTTOM_TABBAR_HEIGHT 50

#define TABLE_VIEW_CELL_DEFAULT_FONT_SIZE 17

#define TABLE_VIEW_CELL_LEFT_MARGIN 20

#define TABLE_VIEW_CELL_DEFAULT_HEIGHT 44

#define FOOTER_LABEL_FONT_SIZE 14

@interface DAConversationViewController ()
<LYSideslipCellDelegate,
UITableViewDelegate,
UITableViewDataSource,
UINavigationControllerDelegate,
//LLChatManagerConversationListDelegate,
UISearchBarDelegate,
LLSearchControllerDelegate>
@property (nonatomic, strong) NSArray *dataArray;


@property (nonatomic) UIView *connectionAlertView;

@property (nonatomic) DATableView *tableView;

@property (nonatomic) LLSearchBar *searchBar;

@property (nonatomic) UIView *tableHeaderView;

/** 网络链接 */
@property (nonatomic, assign) BOOL isConnected;



@end



@implementation DAConversationViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.isConnected = YES;
    _dataArray = [LYHomeCellModel requestDataArray];
    
//    UIBarButtonItem *plusItem = [[UIBarButtonItem alloc]
//                                 initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self
//                                 action:@selector(plusButtonHandler:)];
//    
//    self.navigationItem.rightBarButtonItem = plusItem;
    
    self.tableView = [[DATableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    //    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    //    self.tableView.rowHeight = TABLE_CELL_HEIGHT;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 8, 0, 0);
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, MAIN_BOTTOM_TABBAR_HEIGHT, 0);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 70;
    
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    
    _searchBar = [LLSearchBar defaultSearchBarWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SEARCH_TEXT_FIELD_HEIGHT + 16)];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"搜索";
    
    _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(_searchBar.frame))];
    _tableHeaderView.backgroundColor = [UIColor clearColor];
    [_tableHeaderView addSubview:_searchBar];
    
    self.tableView.tableHeaderView = _tableHeaderView;
    
    NSInteger _viewHeight = SCREEN_HEIGHT;
    UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(0,-_viewHeight, SCREEN_WIDTH, _viewHeight)];
    barView.backgroundColor = self.searchBar.barTintColor;
    [self.tableView addSubview:barView];
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectionStateChanged:) name:LLConnectionStateDidChangedNotification object:nil];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uploadCompleteHandler:) name:LLMessageUploadStatusChangedNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(connectionStateChanged:)
                                                 name:kRealReachabilityChangedNotification
                                               object:nil];
    
    //fetch data
    //    [self fetchData];
    
}





@end
