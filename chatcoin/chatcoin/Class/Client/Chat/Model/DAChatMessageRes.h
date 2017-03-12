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

// conversationId messageId loginId fromId toId userType messageBodyType messageContent timestamp

/** 所属会话的唯一标识符 会话 id conversationId 和一个人聊天代表一个回话，一个回话包含很多消息 */
@property (nonatomic, copy) NSString *conversationId;
/** 消息的唯一标识符  单条消息id 一个MessageId唯一对应一个MessageModel*/
@property (nonatomic, copy) NSString *messageId;
/** 当前登录用户的id */
@property (nonatomic, copy) NSString *loginId;
/** 消息发送方的id */
@property (nonatomic, copy) NSString *fromId;
/** 消息接收方的id */
@property (nonatomic, copy) NSString *toId;
/** 消息是谁发的 */
@property(nonatomic, assign) DAMessageUserType userType;
/** 内容类型:1.文字 2.图片 3.语音 4.小视频, 5,生成的 时间条 */
@property (nonatomic, assign) DAMessageContentType messageBodyType;



/** 消息体 */
@property(nonatomic, copy) NSString *messageContent;
/** 消息发送或接受的时间戳 */
@property (nonatomic, assign) NSTimeInterval timestamp;


// 非网络数据, 可以从第一个回话列表界面获取 不需要存储的数据库中
/** 消息发送者的用户名 */
@property (nonatomic, copy) NSString *senderUserName;
/** 消息发送者的头像 */
@property (nonatomic, copy) NSString *senderUserIconName;

/** 备注姓名 */
@property (nonatomic, copy) NSString *remarkName;


/** 消息接收者的用户名 */
//@property (nonatomic, copy) NSString *recipientUserName;
/** 消息接收者的头像 */
//@property (nonatomic, copy) NSString *recipientUserIconName;





@end

// 环信

//log: level: 1, area: 1, SEND:
//{
//    verison : MSYNC_V1,
//    compress_algorimth : 0,
//    command : SYNC,
//    payload :
//    {
//        meta :
//        {
//            id : 14892853165600057,
//            to : 111111,
//            ns : CHAT,
//            payload :
//            {
//                chattype : CHAT,
//                from : 111,
//                to : 111111,
//                contents : [
//                            {
//                                contenttype : TEXT,
//                                text : 4
//                            }
//                            ]
//            }
//        } 
//    } 
//}
//
//
//
//log: level: 1, area: 1, RECV:
//{ 
//    verison : MSYNC_V1, 
//    command : SYNC, 
//    payload : { 
//        status : { 
//            error_code : 0 
//        }, 
//        
//        meta_id : 14892853165600057, 
//        server_id : 308037362477172752, 
//        timestamp : 1489285337391 
//    } 
//}


