//
//  DAConversationViewController.m
//  chatcoin
//
//  Created by okerivy on 2017/2/4.
//  Copyright © 2017年 okerivy. All rights reserved.
//

#import "DAConversationViewController.h"
#import "LYSideslipCell.h"
#import "LYHomeCell.h"
#import "DAChatViewController.h"


#define kIcon @"kIcon"
#define kName @"kName"
#define kTime @"kTime"
#define kMessage @"kMessage"

@interface DAConversationViewController () <LYSideslipCellDelegate>
@property (nonatomic, strong) NSArray *dataArray;
@end



@implementation DAConversationViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 70;
    _dataArray = [LYHomeCellModel requestDataArray];
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
    
    DAChatViewController * chatVC = [[DAChatViewController alloc] init];
    chatVC.conversationModel = _dataArray[indexPath.row];
    [self.navigationController pushViewController:chatVC animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - LYSideslipCellDelegate
- (void)sideslipCell:(LYSideslipCell *)sideslipCell rowAtIndexPath:(NSIndexPath *)indexPath didSelectedAtIndex:(NSInteger)index {
    NSLog(@"选中了: %ld", index);
}

- (BOOL)sideslipCell:(LYSideslipCell *)sideslipCell canSideslipRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 4) {
        return NO;
    }
    return YES;
}



@end
