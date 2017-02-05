//
//  DAChatViewController.m
//  chatcoin
//
//  Created by okerivy on 2017/2/5.
//  Copyright © 2017年 okerivy. All rights reserved.
//

#import "DAChatViewController.h"

@interface DAChatViewController ()

@end

@implementation DAChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = JYUnvColor_White;
    self.title = self.conversationModel.userName;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
