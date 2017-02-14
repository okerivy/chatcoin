//
//  DAChatMessageReq.h
//  chatcoin
//
//  Created by okerivy on 2017/2/14.
//  Copyright © 2017年 okerivy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DAChatEnum.h"
#import "DAChatMessageHeardeReq.h"



@interface DAChatMessageReq : NSObject

/** 消息头部 */
@property (nonatomic, strong) DAChatMessageHeardeReq *header;

/** 事件ID,一个事件完成周期内使用相同的EventId */
@property (nonatomic, assign) NSInteger EventId;
/** 消息发送者的公钥 */
@property (nonatomic, strong) NSString *Sender;
/** 消息接收者的公钥 */
@property (nonatomic, strong) NSString *Recipient;
/** 内容类型:1.文字 2.图片 3.语音 4.小视频 */
@property (nonatomic, assign) DAMessageContentType ContentType;
/** 数据包序号 */
@property (nonatomic, assign) NSInteger PackageSeq;
/** 数据包总数 */
@property (nonatomic, assign) NSInteger TotalPackage;
/** 16进制字符串 */
@property (nonatomic, strong) NSString *data;

@end

//"header": {
//    "SendingTime": 1486887952,
//    "CommandId": 1,
//    "AppId": 1,
//    "MessageId": 1,
//    "Version": 1001
//},
//"EventId": 100861,
//"Sender": "1DQe9F3agsDcr4qoTZ3Sush4e88Nv9tNxa",
//"Recipient": "5DQe9F3agsDcr4qoTZ3Sush4e88Nv9tNxa",
//"ContentType": 1,
//"PackageSeq": 1,
//"TotalPackage": 1,
//"data": "e4bda0e5a5bdefbc8c4461656d73"
//}
