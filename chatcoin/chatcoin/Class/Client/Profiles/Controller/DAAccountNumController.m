//
//  DAAccountNumController.m
//  chatcoin
//
//  Created by okerivy on 2017/2/20.
//  Copyright © 2017年 okerivy. All rights reserved.
//

#import "DAAccountNumController.h"

#import "DANavigationController.h"
#import "LYSideslipCell.h"
#import "DAChatViewController.h"
#import "UIKit+LLExt.h"
#import "DATableView.h"

#import "DAAccountNumCell.h"




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




@interface DAAccountNumController ()
<LYSideslipCellDelegate,
UITableViewDelegate,
UITableViewDataSource,
UINavigationControllerDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) DATableView *tableView;
@property (nonatomic, strong) UIButton *creatAcount;

@end

@implementation DAAccountNumController



#pragma mark- Static变量



#pragma mark- 系统方法


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账号";
    _dataArray = [NSMutableArray array];
    [self initData];
    
    self.view.backgroundColor = kLLBackgroundColor_Default;
    self.tableView = [[DATableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - MAIN_BOTTOM_TABBAR_HEIGHT) style:UITableViewStylePlain];
    self.tableView.backgroundColor = kLLBackgroundColor_Default;
    
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 8, 0, 0);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 70;
    
    [self.view addSubview:self.tableView];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.creatAcount = [[UIButton alloc] initWithFrame:CGRectMake(10, self.tableView.bottom_LL, SCREEN_WIDTH - 20, MAIN_BOTTOM_TABBAR_HEIGHT -5)];
    [self.creatAcount setTitle:@"生成新账号" forState:UIControlStateNormal];
    self.creatAcount.backgroundColor = ZKColor_Var(116, 151, 241);
    self.creatAcount.clipsToBounds = YES;
    self.creatAcount.layer.cornerRadius = 3;
    self.creatAcount.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.2].CGColor;
    self.creatAcount.layer.borderWidth = 0.5;
    [self.creatAcount addTarget:self action:@selector(creatNewAcount:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.creatAcount];

    
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

- (void)creatNewAcount:(UIButton *)btn
{
    [self.dataArray addObject:@"1"];
    [self.tableView reloadData];
}

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

    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DAAccountNumCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(DAAccountNumCell.class)];
    if (!cell) {
        cell = [[DAAccountNumCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(DAAccountNumCell.class)];
        cell.delegate = self;
    }
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
//    UIViewController * chatVC = [[UIViewController alloc] init];
//    [self.navigationController pushViewController:chatVC animated:YES];
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil                                                                             message: nil                                                                       preferredStyle:UIAlertControllerStyleActionSheet];
    //添加Button
    [alertController addAction: [UIAlertAction actionWithTitle: @"复制" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //处理点击拍照
        ZLog(@"%@", @"复制");
        [self copyAcount];
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"删除" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        //处理点击从相册选取
        ZLog(@"%@", @"删除");
        [self deleteAcount];
        

    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController: alertController animated: YES completion: nil];
    
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
