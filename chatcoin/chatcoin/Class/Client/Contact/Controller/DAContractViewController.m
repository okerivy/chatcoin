//
//  DAContractViewController.m
//  chatcoin
//
//  Created by okerivy on 2017/2/4.
//  Copyright © 2017年 okerivy. All rights reserved.
//

#import "DAContractViewController.h"
#import "DAChatViewController.h"

@interface DAContractViewController ()

@end

@implementation DAContractViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 70;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIViewController * chatVC = [[UIViewController alloc] init];
//    chatVC.conversationModel = _dataArray[indexPath.row];
    [self.navigationController pushViewController:chatVC animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
