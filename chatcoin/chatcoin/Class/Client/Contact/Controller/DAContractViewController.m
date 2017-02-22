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
#import "DAContactStaicCell.h"




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


- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [DAContractCellModel requestDataArray];
    [self initData];
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
    
    //    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SEARCH_TEXT_FIELD_HEIGHT + 16+100)];
    //    view.backgroundColor = ZKColor_Random;
    //    _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(view.frame))];
    
    _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(_searchBar.frame))];
    _tableHeaderView.backgroundColor = [UIColor clearColor];
    [_tableHeaderView addSubview:_searchBar];
    //    [_tableHeaderView addSubview:view];
    
    
    self.tableView.tableHeaderView = _tableHeaderView;
    
    self.tableView.sectionIndexColor = ZKColor_Black;
    self.tableView.sectionIndexBackgroundColor = ZKColor_Clear;
    self.tableView.sectionIndexTrackingBackgroundColor = ZKColor_Clear;
    
    
    NSInteger _viewHeight = SCREEN_HEIGHT;
    UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(0,-_viewHeight, SCREEN_WIDTH, _viewHeight)];
    barView.backgroundColor = self.searchBar.barTintColor;
    [self.tableView addSubview:barView];
    
    
}


- (void)initData
{
    [DAGetAddressBook getOrderAddressBook:^(NSDictionary<NSString *,NSArray *> *addressBookDict, NSMutableArray *personOrderArray, NSArray *nameKeys) {
        [_dataArray removeAllObjects];
        _dataArray = [NSMutableArray arrayWithArray:personOrderArray];
        //装着所有联系人的字典
        self.contactPeopleDict = addressBookDict;
        //联系人分组按拼音分组的Key值
        self.keys = nameKeys;
        [self.tableView reloadData];
        
    } fromArray:self.dataArray];
    
    
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _keys.count + 1;
}

// 第一组没有索引
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    NSString *key = _keys[section-1];
    return [_contactPeopleDict[key] count];
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @" ";
    }
    return _keys[section -1];
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 20;
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = ZKColor_Clear;
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.contentView.backgroundColor= kLLBackgroundColor_Default;
    header.textLabel.textAlignment=NSTextAlignmentLeft;
    header.textLabel.font=[UIFont systemFontOfSize:12];
    
    [header.textLabel setTextColor:ZKColor_VarGrayA(100, 0.9)];
    
}

//右侧的索引
- (NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@" ", nil];
    [arr addObjectsFromArray:_keys];
    return arr;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        DAContactStaicCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(DAContactStaicCell.class)];
        if (!cell) {
            cell = [[DAContactStaicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(DAContactStaicCell.class)];
            cell.delegate = self;
        }
        // 取消 cell 的选中效果
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
    DAContactCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(DAContactCell.class)];
    if (!cell) {
        cell = [[DAContactCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(DAContactCell.class)];
        cell.delegate = self;
    }
    NSString *key = _keys[indexPath.section -1];
    DAContractCellModel *model = [_contactPeopleDict[key] objectAtIndex:indexPath.row];
    UIButton *button1 = [cell rowActionWithStyle:LYSideslipCellActionStyleNormal title:@"取消关注"];
    UIButton *button2 = [cell rowActionWithStyle:LYSideslipCellActionStyleDestructive title:@"删除"];
    UIButton *button3 = [cell rowActionWithStyle:LYSideslipCellActionStyleNormal title:@"置顶"];
    switch (model.messageType) {
        case DAContractCellTypeMessage:
            [cell setRightButtons:@[button2]];
            break;
        case DAContractCellTypeSubscription:
            [cell setRightButtons:@[button1, button2]];
            break;
        case DAContractCellTypePubliction:
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
    
    
    if (indexPath.section == 0) {
        UIViewController * chatVC = [[UIViewController alloc] init];
        [self.navigationController pushViewController:chatVC animated:YES];
        return;
    }
    
    DAChatViewController * chatVC = [[DAChatViewController alloc] init];
    NSString *key = _keys[indexPath.section -1];
    DAContractCellModel *model = [_contactPeopleDict[key] objectAtIndex:indexPath.row];
    LYHomeCellModel *conversationModel = [[LYHomeCellModel alloc] init];
    conversationModel.iconName = model.iconName;
    conversationModel.userName = model.userName;
    conversationModel.conversationId = model.conversationId;
    conversationModel.messageUserId = model.messageUserId;
    conversationModel.iconName = model.iconName;
    
    chatVC.conversationModel = conversationModel;
    [self.navigationController pushViewController:chatVC animated:YES];
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



//TableHeaderView 从上至下，依次为SearchBar、connectionAlertView、电脑端登录等
- (void)adjustTableHeaderView {
    CGFloat maxHeight = CGRectGetHeight(self.searchBar.frame);
    
    
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
//    [vc showInViewController:self fromSearchBar:self.searchBar];

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






@end
