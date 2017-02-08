//
//  DATableView.m
//  chatcoin
//
//  Created by okerivy on 2017/2/8.
//  Copyright © 2017年 okerivy. All rights reserved.
//

#import "DATableView.h"

@implementation DATableView


- (void)layoutSubviews
{
    [super layoutSubviews];
    ZLog(@"tableview 布局");
    ZLog(@"%@", NSStringFromCGRect(self.frame));
}

@end
