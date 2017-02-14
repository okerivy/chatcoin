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



#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LYHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(LYSideslipCell.class)];
    if (!cell) {
        cell = [[LYHomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(LYSideslipCell.class)];
        cell.delegate = self;
    }
    LYHomeCellModel *model = _dataArray[indexPath.row];
    UIButton *button1 = [cell rowActionWithStyle:LYSideslipCellActionStyleNormal title:@"取消关注"];
    UIButton *button2 = [cell rowActionWithStyle:LYSideslipCellActionStyleDestructive title:@"删除"];
    UIButton *button3 = [cell rowActionWithStyle:LYSideslipCellActionStyleNormal title:@"置顶"];
    switch (model.messageType) {
        case LYHomeCellTypeMessage:
            [cell setRightButtons:@[button2]];
            break;
        case LYHomeCellTypeSubscription:
            [cell setRightButtons:@[button1, button2]];
            break;
        case LYHomeCellTypePubliction:
            [cell setRightButtons:@[button3, button2]];
            break;
        default:
            break;
    }
    cell.model = model;
    // 取消 cell 的选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    DAChatViewController * chatVC = [[DAChatViewController alloc] init];
    chatVC.conversationModel = _dataArray[indexPath.row];
    [self.navigationController pushViewController:chatVC animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    UIViewController * chatVC = [[UIViewController alloc] init];
//    //    chatVC.conversationModel = _dataArray[indexPath.row];
//    [self.navigationController pushViewController:chatVC animated:YES];
//    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//}

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


#pragma mark- Static变量



#pragma mark- 系统方法
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
}


#pragma mark- 初始化方法



#pragma mark- set方法



#pragma mark- 监听方法

- (void)connectionStateChanged:(NSNotification*)notification {
    
    RealReachability *reachability = (RealReachability *)notification.object;
    ReachabilityStatus status = [reachability currentReachabilityStatus];
    [self realNetworkingStatus:status];
    
    AppDelegate *App = (AppDelegate *)[[UIApplication sharedApplication] delegate] ;

    self.isConnected = App.isNetworkConnect;//[self realNetworkingStatus:status];

    if (!self.isConnected) {
        self.navigationItem.title = @"聊天(未连接)";
        [self.tableHeaderView addSubview:self.connectionAlertView];
    }else {
        self.navigationItem.title = @"聊天";
        [self.connectionAlertView removeFromSuperview];
    }
    
    [self adjustTableHeaderView];
}



-(BOOL)realNetworkingStatus:(ReachabilityStatus)status{
    BOOL isConnected = YES;
    switch (status)
    {
        case RealStatusUnknown:
        {
            NSLog(@"~~~~~~~~~~~~~RealStatusUnknown");
            isConnected = NO;
            break;
        }
            
        case RealStatusNotReachable:
        {
            NSLog(@"~~~~~~~~~~~~~RealStatusNotReachable");
            isConnected = NO;
            break;
        }
            
        case RealStatusViaWWAN:
        {
            NSLog(@"~~~~~~~~~~~~~RealStatusViaWWAN");
            isConnected = YES;
            break;
        }
        case RealStatusViaWiFi:
        {
            NSLog(@"~~~~~~~~~~~~~RealStatusViaWiFi");
            isConnected = YES;
            break;
        }
        default:
            break;
    }
    return isConnected;
}



//TableHeaderView 从上至下，依次为SearchBar、connectionAlertView、电脑端登录等
- (void)adjustTableHeaderView {
    CGFloat maxHeight = CGRectGetHeight(self.searchBar.frame);
    if (self.connectionAlertView.superview == _tableHeaderView) {
        self.connectionAlertView.top_LL = maxHeight;
        [self.tableHeaderView addSubview:self.connectionAlertView];
        
        maxHeight = CGRectGetMaxY(self.connectionAlertView.frame);
    }
    
    self.tableHeaderView.height_LL = maxHeight;
    
    [self.tableView setTableHeaderView:self.tableHeaderView];
}


#pragma mark- 代理方法 Delegate

#pragma mark - 搜索 -

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    LLSearchViewController *vc = [LLSearchViewController sharedInstance];
    DANavigationController *navigationVC = [[DANavigationController alloc] initWithRootViewController:vc];
    navigationVC.view.backgroundColor = [UIColor clearColor];
    vc.delegate = self;
    LLChatSearchController *resultController = [[LLChatSearchController alloc] init];
    
    vc.searchResultController = resultController;
    resultController.searchViewController = vc;
    [vc showInViewController:self fromSearchBar:self.searchBar];
    
    return NO;
}

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



- (UIView *)connectionAlertView {
    if (!_connectionAlertView) {
        _connectionAlertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        _connectionAlertView.backgroundColor = UIColorRGB(255, 223, 224);
        
        UIImageView *alertView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"connect_alert_error"]];
        alertView.frame = CGRectMake(20, (CGRectGetHeight(_connectionAlertView.frame) - 28)/2, 28, 28);
        [_connectionAlertView addSubview:alertView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(alertView.frame) + 12, 0, 300, 45)];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentLeft;
        label.text = @"当前网络不可用，请检查你的网络设置";
        [_connectionAlertView addSubview:label];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showNotConnectWebView:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [_connectionAlertView addGestureRecognizer:tap];
        
    }
    
    return _connectionAlertView;
}




@end
