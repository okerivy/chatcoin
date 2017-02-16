//
//  DAContractViewController.m
//  chatcoin
//
//  Created by okerivy on 2017/2/4.
//  Copyright © 2017年 okerivy. All rights reserved.
//

#import "DAContractViewController.h"
#import "DANavigationController.h"
#import "LYSideslipCell.h"
#import "DAContactCell.h"
#import "DAChatViewController.h"
#import "LLSearchBar.h"
#import "UIKit+LLExt.h"
#import "LLSearchViewController.h"
#import "LLSearchControllerDelegate.h"
#import "LLChatSearchController.h"
#import "DATableView.h"
#import "DAGetAddressBook.h"



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

@interface DAContractViewController ()
<LYSideslipCellDelegate,
UITableViewDelegate,
UITableViewDataSource,
UINavigationControllerDelegate,
UISearchBarDelegate,
LLSearchControllerDelegate>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, copy) NSArray *keys;
@property (nonatomic, copy) NSDictionary *contactPeopleDict;


@property (nonatomic) DATableView *tableView;

@property (nonatomic) LLSearchBar *searchBar;

@property (nonatomic) UIView *tableHeaderView;



@end


@implementation DAContractViewController


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.textLabel.text= @"111111111";
    cell.detailTextLabel.text=[NSString stringWithFormat:@"detale --%d",arc4random_uniform(10)];
    cell.backgroundColor = kLLBackgroundColor_lightGray;
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
    
    UIViewController * chatVC = [[UIViewController alloc] init];
//    chatVC.conversationModel = _dataArray[indexPath.row];
    [self.navigationController pushViewController:chatVC animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [DAContractCellModel requestDataArray];
//    [self initData];
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
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SEARCH_TEXT_FIELD_HEIGHT + 16+100)];
    view.backgroundColor = ZKColor_Random;
    _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(view.frame))];

//    _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(_searchBar.frame))];
    _tableHeaderView.backgroundColor = [UIColor clearColor];
//    [_tableHeaderView addSubview:_searchBar];
    [_tableHeaderView addSubview:view];

    
    self.tableView.tableHeaderView = _tableHeaderView;
    
    self.tableView.sectionIndexColor = ZKColor_Black;
    self.tableView.sectionIndexBackgroundColor = ZKColor_Clear;
    self.tableView.sectionIndexTrackingBackgroundColor = ZKColor_Clear;

    
    NSInteger _viewHeight = SCREEN_HEIGHT;
    UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(0,-_viewHeight, SCREEN_WIDTH, _viewHeight)];
    barView.backgroundColor = self.searchBar.barTintColor;
    [self.tableView addSubview:barView];

    
}



//- (void)testpersonarray
//{
//    NSArray *stringsToSort=[NSArray arrayWithObjects:
//                            @"李白",@"张三",
//                            @"重庆",@"重量",
//                            @"调节",@"调用",
//                            @"小白",@"小明",@"千珏",
//                            @"黄家驹", @"鼠标",@"hello",@"多美丽",@"肯德基",@"##",
//                            nil];
//    
//    //模拟网络请求接收到的数组对象 Person数组
//    self.personArray = [[NSMutableArray alloc] initWithCapacity:0];
//    for (int i = 0; i<[stringsToSort count]; i++) {
//        DAPersonModel *p = [[DAPersonModel alloc] init];
//        p.showName = [stringsToSort objectAtIndex:i];
//        p.number = i;
//        [self.personArray addObject:p];
//    }
//    ZLog(@"%@", [DAPersonModel mj_keyValuesArrayWithObjectArray:self.personArray]);
//    ZLog(@"%@", [[self.personArray lastObject] mj_keyValues]);
//
//}

- (void)willPresentSearchController:(LLSearchViewController *)searchController {
    
}

- (void)didPresentSearchController:(LLSearchViewController *)searchController {
    self.tableView.tableHeaderView = nil;
    CGRect frame = _tableHeaderView.frame;
    frame.origin.y = -frame.size.height;
    _tableHeaderView.frame = frame;
}

- (void)willDismissSearchController:(LLSearchViewController *)searchController {
    
    [UIView animateWithDuration:HIDE_ANIMATION_DURATION animations:^{
        _searchBar.hidden = YES;
        self.tableView.tableHeaderView = _tableHeaderView;
    } completion:^(BOOL finished) {
        _searchBar.hidden = NO;
    }];
    
}

- (void)didDismissSearchController:(LLSearchViewController *)searchController {
    //    _connectionAlertView.alpha = 0;
    //    for (UITableViewCell *cell in self.tableView.visibleCells) {
    //        cell.alpha = 0;
    //    }
    //    [UIView animateWithDuration:0.25 animations:^{
    //        _connectionAlertView.alpha = 1;
    //        for (UITableViewCell *cell in self.tableView.visibleCells) {
    //            cell.alpha = 1;
    //        }
    //    }];
}


#pragma mark- 其他方法

- (void)showNotConnectWebView:(UITapGestureRecognizer *)tap {
    //    LLWebViewController *vc = [[LLWebViewController alloc] init];
    //    vc.title = @"未能连接到互联网";
    //    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"network_setting" ofType:@"html"];
    //    vc.url = [NSURL fileURLWithPath:htmlPath];
    //    vc.fromViewController = self;
    //
    //    [self.navigationController pushViewController:vc animated:YES];
    
}

//- (void)plusButtonHandler:(UIBarButtonItem *)item {
//    [self presentImagePickerController];
//    self.isConnected = !self.isConnected;
//    if (!self.isConnected) {
//        self.navigationItem.title = @"聊天(未连接)";
//        [self.tableHeaderView addSubview:self.connectionAlertView];
//    }else {
//        self.navigationItem.title = @"聊天";
//        [self.connectionAlertView removeFromSuperview];
//    }
//
//    [self adjustTableHeaderView];
//
//}

- (void)presentImagePickerController {
    
}



#pragma mark- 懒加载






@end
