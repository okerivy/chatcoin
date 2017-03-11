//
//  DAChatDatabaseManager.h
//  chatcoin
//
//  Created by okerivy on 2017/3/11.
//  Copyright © 2017年 okerivy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAChatDatabaseManager : NSObject
DASingletonH(DAChatDatabaseManager)

+ (void)creatChatTableWithName:(NSString *)tableName;
/**
 *  根据请求参数去沙盒中加载缓存的消息数据
 *
 *  @param params 请求参数
 */
+ (NSArray *)queryMessagesWithParams:(NSDictionary *)params  fromTable:(NSString *)tableName;

/**
 *  存储消息数据到沙盒中
 *
 *  @param messages 需要存储的微博数据
 */
+ (void)saveMessages:(NSArray *)messages toTable:(NSString *)tableName userId:(NSString *)userId;

/*
 * 删除数据，默认删除所有
 */
+ (BOOL)deleteData:(NSString *)deleteSql;


@end
