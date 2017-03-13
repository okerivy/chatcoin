//
//  DAChatDatabaseManager.m
//  chatcoin
//
//  Created by okerivy on 2017/3/11.
//  Copyright © 2017年 okerivy. All rights reserved.
//

#import "DAChatDatabaseManager.h"
#import "DAChatMessageRes.h"



static FMDatabaseQueue *dataBaseQueue;

@implementation DAChatDatabaseManager

DASingletonM(DAChatDatabaseManager)

+ (void)initialize {
    
    // 1.打开数据库
    NSString *dbName = @"chatDb.sqlite";
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:dbName];
    dataBaseQueue = [FMDatabaseQueue databaseQueueWithPath:path];
    
}

//判断字符串是否为空字符的方法
- (NSString *) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return nil;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return nil;
    }
    NSString *str = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([str length]!=0) {
        return str;
    }
    return nil;
}


- (BOOL)isExistsTable:(NSString *)tableName
{
    if (![self isBlankString:tableName]) {
        NSLog(@"表名为空,无法查询");
        return NO;
    }
    
    // 拼接表名
    NSString *tableN = [NSString stringWithFormat:@"t_chat_%@", tableName];
    
    //监测数据库中我要需要的表是否已经存在
    NSString *existsTableSql = [NSString stringWithFormat:@"select count(name) as countNum from sqlite_master where type = 'table' and name = '%@'", tableN ];
    
    
    // 先检测表是否存在
    BOOL __block createTableResult = NO;
    [dataBaseQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *set = [db executeQuery:existsTableSql];
        if ([set next]) {
            
            NSInteger count = [set intForColumn:@"countNum"];
            NSLog(@"The table count: %li", count);
            if (count == 1) {
                NSLog(@"%@ 表已经存在,可以直接使用", tableN);
                createTableResult = YES;
                return;
            }
            createTableResult = NO;
            NSLog(@"%@ 表 还没有存在,重新创建", tableN);
        }
    }];
    
    return createTableResult;
}

- (void)creatChatTableWithName:(NSString *)tableName
{

    
    BOOL __block createTableResult = [self isExistsTable:tableName];
    
    // 拼接表名
    NSString *tableN = [NSString stringWithFormat:@"t_chat_%@", tableName];
    //创建表
    if (createTableResult) {return;}
    [dataBaseQueue inDatabase:^(FMDatabase *db) {
        // conversationId  loginId messageId  fromId toId  messageContent  userType messageBodyType  timestamp messageData
        // UNIQUE 唯一约束 messageId 防止插入重复
        NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id INTEGER PRIMARY KEY, conversationId TEXT  NOT NULL, loginId TEXT  NOT NULL, messageId TEXT NOT NULL UNIQUE, fromId TEXT  NOT NULL, toId TEXT, messageContent TEXT ,  userType TEXT  NOT NULL,  messageBodyType TEXT  NOT NULL, timestamp TEXT  NOT NULL, createTime TEXT DEFAULT (datetime('now', 'localtime')) NOT NULL);", tableN];
        
        createTableResult = [db executeUpdate:sql];
        if (createTableResult) {
            NSLog(@"创建消息表成功");
        } else {
            NSLog(@"创建消息表失败");
        }

    }];
}


/**
 *  根据请求参数去沙盒中加载缓存的消息数据
 */
- (NSArray *)loadMoreMessagesFromId:(NSString *)messageId
                          fromTable:(NSString *)tableName
                             offset:(NSInteger)offset
                              limit:(NSInteger)limit
{
    [self creatChatTableWithName:tableName];
    
    NSString *tableN = [NSString stringWithFormat:@"t_chat_%@", tableName];
    
    // 根据请求参数生成对应的查询SQL语句
    NSString *sql = nil;

    //sql查询数据库最后10条记录 并按升序排列 返回
    sql = [NSString stringWithFormat:@"SELECT * FROM (SELECT * FROM %@ WHERE id >= %@ ORDER BY id DESC LIMIT %ld OFFSET %ld) ORDER BY id;", tableN,messageId,limit,offset];
    
    // 执行SQL
    NSMutableArray *arrM = [NSMutableArray array];
    [dataBaseQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *set = [db executeQuery:sql];
        while ([set next]) {
            
            DAChatMessageRes *messageRes = [[DAChatMessageRes alloc] init];
            messageRes.conversationId = [set objectForColumnName:@"conversationId"];

            messageRes.loginId = [set stringForColumn:@"loginId"];
            messageRes.messageId = [set stringForColumn:@"messageid"];
            messageRes.fromId = [set stringForColumn:@"fromId"];
            messageRes.toId = [set objectForColumnName:@"toId"];
            messageRes.messageContent = [set stringForColumn:@"messageContent"];
            messageRes.userType = [set intForColumn:@"userType"];
            messageRes.messageBodyType = [set intForColumn:@"messageBodyType"];
            messageRes.timestamp = [set doubleForColumn:@"timestamp"];
    
            
            [arrM addObject:messageRes];
        }
    }];
    return arrM;
}




/**
 *  存储消息数据到沙盒中
 *
 *  @param messages 需要存储的微博数据
 */
- (void)insertMessages:(NSArray *)messages toTable:(NSString *)tableName
{
    [self creatChatTableWithName:tableName];

    NSString *tableN = [NSString stringWithFormat:@"t_chat_%@", tableName];

    BOOL __block insertTableResult = NO;
    NSInteger __block insertNum = 0;
    [dataBaseQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        //FMDB默认情况是关闭缓存的
        [db shouldCacheStatements];
        
        for (DAChatMessageRes *messageRes in messages) {

            // conversationId  loginId messageId  fromId toId  messageContent userType messageBodyType  timestamp
            NSString *sql = [NSString stringWithFormat:@"insert or replace  into %@ (conversationId, loginId, messageId, fromId, toId, messageContent, userType, messageBodyType, timestamp) values (?,?,?,?,?,?,?,?,?)",tableN];

            insertTableResult = [db executeUpdate:sql, messageRes.conversationId,messageRes.loginId, messageRes.messageId,messageRes.fromId, messageRes.toId, messageRes.messageContent, @(messageRes.userType), @(messageRes.messageBodyType), @(messageRes.timestamp)];
            
            if (insertTableResult){
                insertNum += 1;
            }else{
                
                NSLog(@"插入失败");
                *rollback = YES;
                [db rollback];
                break;
            }
        }
        
    }];
    
    NSLog(@"插入 %zd条数据", insertNum);
    
}

/*
 * 删除数据，默认删除所有
 */
- (BOOL)deleteMessageFromId:(NSString *)messageId fromTable:(NSString *)tableName
{
    NSString *tableN = [NSString stringWithFormat:@"t_chat_%@", tableName];
    NSString *sql = [NSString stringWithFormat:@"delete from %@ where messageId = %@",tableN, messageId];

    BOOL __block result;
    [dataBaseQueue inDatabase:^(FMDatabase *db) {
        
        result = [db executeUpdate:sql];
        if (result) {
            NSLog(@"删除成功！");
        }else {
            NSLog(@"删除失败");
        }
    }];
    
    return result;
}



@end


