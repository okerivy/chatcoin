//
//  ChatMessage.h
//  chatcoin
//
//  Created by okerivy on 2017/2/12.
//  Copyright © 2017年 okerivy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DAChatEnum.h"


#define myUserId @"13611223344" // 我的用户 id
#define myUserName @"鸣人" // 我的用户名
#define myUserIconName @"鸣人" // 我的用户头像



@interface DAChatMessageRes : NSObject


/** 会话 id conversationId 和一个人聊天代表一个回话，一个回话包含很多消息 */
@property (nonatomic, copy) NSString *conversationId;
/** 单条消息id 一个MessageId唯一对应一个MessageModel*/
@property (nonatomic, copy) NSString *messageId;
//        _messageId = [NSString stringWithFormat:@"%f%d",[NSDate date].timeIntervalSince1970, arc4random()];

/** 备注姓名 */
@property (nonatomic, copy) NSString *remarkName;

/** 消息发送者的id */
@property (nonatomic, copy) NSString *senderUserId;
/** 消息接收者的id */
@property (nonatomic, copy) NSString *recipientUserId;
/** 消息发送者的用户名 */
@property (nonatomic, copy) NSString *senderUserName;
/** 消息接收者的用户名 */
@property (nonatomic, copy) NSString *recipientUserName;
/** 消息发送者的头像 */
@property (nonatomic, copy) NSString *senderUserIconName;
/** 消息接收者的头像 */
@property (nonatomic, copy) NSString *recipientUserIconName;


@property(nonatomic, copy) NSString *messageContent;

@property(nonatomic, assign) DAMessageUserType userType;

@property (nonatomic, assign) DAMessageContentType messageBodyType;

@property (nonatomic) NSTimeInterval timestamp;

@end
