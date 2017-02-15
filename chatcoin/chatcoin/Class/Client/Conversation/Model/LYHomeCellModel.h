//
//  LYHomeCellModel.h
//  LYSideslipCellDemo
//
//  Created by Louis on 16/7/5.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, LYHomeCellType) {
    LYHomeCellTypeMessage,
    LYHomeCellTypePubliction,
    LYHomeCellTypeSubscription
};

@interface LYHomeCellModel : NSObject
@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *timeString;
@property (nonatomic, copy) NSString *lastMessage;
@property (nonatomic, assign) LYHomeCellType messageType;

/** 会话 id conversationId 和一个人聊天代表一个回话，一个回话包含很多消息 */
@property (nonatomic, copy) NSString *conversationId;
/** 回话者的用户 id */
@property (nonatomic, copy) NSString *messageUserId;

+ (NSArray *)requestDataArray;
@end
