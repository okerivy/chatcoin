//
//  DAContractCellModel.h
//  chatcoin
//
//  Created by okerivy on 2017/2/16.
//  Copyright © 2017年 okerivy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DAPersonModel.h"



typedef NS_ENUM(NSInteger, DAContractCellType) {
    DAContractCellTypeMessage,
    DAContractCellTypePubliction,
    DAContractCellTypeSubscription
};


@interface DAContractCellModel : DAPersonModel

/** 用户名*/
@property (nonatomic, copy) NSString *userName;
/** 备注姓名 */
@property (nonatomic, copy) NSString *remarkName;
/** 头像名 */
@property (nonatomic, copy) NSString *iconName;
/** 个性签名 */
@property (nonatomic, copy) NSString *autograph;
@property (nonatomic, assign) DAContractCellType messageType;

/** 会话 id conversationId 和一个人聊天代表一个回话，一个回话包含很多消息 */
@property (nonatomic, copy) NSString *conversationId;
/** 回话者的用户 id */
@property (nonatomic, copy) NSString *messageUserId;

+ (NSMutableArray *)requestDataArray;


@end
