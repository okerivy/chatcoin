//
//  ChatMessage.m
//  chatcoin
//
//  Created by okerivy on 2017/2/12.
//  Copyright © 2017年 okerivy. All rights reserved.
//

#import "DAChatMessageRes.h"

@implementation DAChatMessageRes


- (void)setSenderUserId:(NSString *)senderUserId
{
    _senderUserName = senderUserId;
    // 消息 是 属于消息发送者的，所以只要根据消息发送者的 id，就能判断这个消息是不是我发送的。
    [self judgeUserType:senderUserId];
}


- (void)judgeUserType:(NSString *)userId
{
    if ([userId isEqualToString:myUserId]) {
        self.userType = DAMessageUserTypeMe;
    } else {
        self.userType = DAMessageUserTypeOther;
    }
}

- (void)setUserType:(DAMessageUserType)userType {

    _userType = userType;
    
    
}

@end
