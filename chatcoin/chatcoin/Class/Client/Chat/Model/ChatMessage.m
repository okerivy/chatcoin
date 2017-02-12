//
//  ChatMessage.m
//  chatcoin
//
//  Created by okerivy on 2017/2/12.
//  Copyright © 2017年 okerivy. All rights reserved.
//

#import "ChatMessage.h"

@implementation ChatMessage

- (void)setUserType:(userType)userType {

    _userType = userType;
    
    _userHeadImage = userType == userTypeMe ? @"路飞" : @"鸣人";
    
    _userName = userType == userTypeMe ? @"路飞" : @"";
}

@end
