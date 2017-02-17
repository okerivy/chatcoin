//
//  DAAddressModel.m
//  DAAddressBook
//
//  Created by okerivy on 2017/2/17.
//  Copyright © 2017年 okerivy. All rights reserved.
//
#import "DAPersonModel.h"

@implementation DAPersonModel

- (void)setShowName:(NSString *)showName
{
    if (![self isBlankString:showName]) {
        _showName = @"用户名为空";
    } else {
        _showName = showName;
    }
}


//判断字符串是否为空字符的方法
- (NSString *) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return nil;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return nil;
    }
    NSString *str = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([str length]!=0) {
        return str;
    }
    return nil;
}

@end
