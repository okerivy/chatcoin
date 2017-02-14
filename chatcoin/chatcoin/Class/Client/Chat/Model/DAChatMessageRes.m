//
//  ChatMessage.m
//  chatcoin
//
//  Created by okerivy on 2017/2/12.
//  Copyright © 2017年 okerivy. All rights reserved.
//

#import "DAChatMessageRes.h"

@implementation DAChatMessageRes

- (void)setUserType:(DAMessageUserType)userType {

    _userType = userType;
    
    _userHeadImage = userType == DAMessageUserTypeMe ? @"路飞" : @"鸣人";
    
    _userName = userType == DAMessageUserTypeMe ? @"路飞" : @"";
}

@end
