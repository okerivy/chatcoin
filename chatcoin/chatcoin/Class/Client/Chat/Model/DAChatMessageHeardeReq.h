//
//  DAChatMessageHeardeReq.h
//  chatcoin
//
//  Created by okerivy on 2017/2/14.
//  Copyright © 2017年 okerivy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAChatMessageHeardeReq : NSObject


/** 消息发送时间 */
@property (nonatomic, assign) NSTimeInterval SendingTime;
/** 消息 */
@property (nonatomic, assign) NSInteger CommandId;
/** 消息 */
@property (nonatomic, assign) NSInteger AppId;
/** 消息 */
@property (nonatomic, assign) NSInteger MessageId;
/** 版本号 */
@property (nonatomic, assign) NSInteger Version;


@end


//"header": {
//    "SendingTime": 1486887952,
//    "CommandId": 1,
//    "AppId": 1,
//    "MessageId": 1,
//    "Version": 1001
//},
