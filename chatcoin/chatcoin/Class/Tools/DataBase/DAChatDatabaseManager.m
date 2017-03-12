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


- (void)creatChatTableWithName:(NSString *)tableName
{
    if (![self isBlankString:tableName]) {
        ZLog(@"创建消息表失败");
        return;
    }
    NSString *tableN = [NSString stringWithFormat:@"t_chat_%@", tableName];
    
    // id userId messageId createTime messageData
    // 2.创表
    BOOL __block createTableResult;
    [dataBaseQueue inDatabase:^(FMDatabase *db) {
        // conversationId  loginId messageId  fromId toId  messageContent userType messageBodyType  timestamp
        NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id INTEGER PRIMARY KEY, conversationId TEXT  NOT NULL, loginId TEXT  NOT NULL, messageId TEXT NOT NULL, fromId TEXT  NOT NULL, toId TEXT, messageContent TEXT ,  userType TEXT  NOT NULL,  messageBodyType TEXT  NOT NULL, timestamp TEXT  NOT NULL, createTime TEXT DEFAULT (datetime('now', 'localtime')) NOT NULL);", tableN];
        
        createTableResult = [db executeUpdate:sql];
        if (createTableResult) {
            ZLog(@"创建消息表成功");
        } else {
            ZLog(@"创建消息表失败");
        }
    }];
}


/**
 *  根据请求参数去沙盒中加载缓存的消息数据
 */
//- (NSArray *)queryMessagesWithParams:(NSDictionary *)params  fromTable:(NSString *)tableName
- (NSArray *)loadMoreMessagesFromId:(NSString *)messageId
                          fromTable:(NSString *)tableName
                             offset:(NSInteger)offset
                              limit:(NSInteger)limit
{
    if (![self isBlankString:tableName]) {
        ZLog(@"没有找到表名");
        return nil;
    }
    
    NSString *tableN = [NSString stringWithFormat:@"t_chat_%@", tableName];
    
    // 根据请求参数生成对应的查询SQL语句
    NSString *sql = nil;
//    if (params[@"since_id"]) {
//        sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE id > %@ ORDER BY id DESC LIMIT 5;", tableN,params[@"since_id"]];
//    } else if (params[@"max_id"]) {
//        sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE id <= %@ ORDER BY id DESC LIMIT 5;", tableN,params[@"max_id"]];
//    } else {
//        sql = [NSString stringWithFormat:@"SELECT * FROM %@ ORDER BY id DESC LIMIT 5;", tableN];
//    }
//    sql = [NSString stringWithFormat:@"select * from (select * from %@ where loginId=%ld and friendid=%ld order by cureatetime desc limit %ld offset %ld) order by cureatetime",tableN,loginid,friendid,limit,offset];
    sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE id >= %@ ORDER BY id DESC LIMIT %ld OFFSET %ld;", tableN,messageId,limit,offset];


    
    // 执行SQL
    NSMutableArray *arrM = [NSMutableArray array];
    [dataBaseQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *set = [db executeQuery:sql];
        while ([set next]) {
            
            DAChatMessageRes *messageRes = [[DAChatMessageRes alloc] init];
            messageRes.conversationId = [set objectForColumnName:@"conversationId"];

            messageRes.loginId = [set objectForColumnName:@"loginId"];
            messageRes.messageId = [set objectForColumnName:@"messageid"];
            messageRes.fromId = [set objectForColumnName:@"fromId"];
            messageRes.toId = [set objectForColumnName:@"toId"];
            messageRes.messageContent = [set objectForColumnName:@"messageContent"];
            messageRes.userType = [set intForColumn:@"userType"];
            messageRes.messageBodyType = [set intForColumn:@"messageBodyType"];
            messageRes.timestamp = [set doubleForColumn:@"timestamp"];
        
            
//            NSData *messageData = [set objectForColumnName:@"messageData"];
//            NSDictionary *message = [NSKeyedUnarchiver unarchiveObjectWithData:messageData];
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
    BOOL __block insertTableResult;
    NSString *tableN = [NSString stringWithFormat:@"t_chat_%@", tableName];

    
    // id userId messageId createTime messageData
    
    [dataBaseQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        //FMDB默认情况是关闭缓存的
        [db shouldCacheStatements];
        
        // 要将一个对象存进数据库的blob字段,最好先转为NSData
        // 一个对象要遵守NSCoding协议,实现协议中相应的方法,才能转成NSData
        for (DAChatMessageRes *messageRes in messages) {

            // 方式2  当方式1 中插入的数据有特殊的字符是，就会数据写入失败，使用方式2可以完美解决这一问题。
            // conversationId  loginId messageId  fromId toId  messageContent userType messageBodyType  timestamp
            NSString *sql = [NSString stringWithFormat:@"insert into %@ (conversationId, loginId, messageId, fromId, toId, messageContent, userType, messageBodyType, timestamp) values (?,?,?,?,?,?,?,?,?)",tableN];

            NSNumber *userType = [NSNumber numberWithInteger:messageRes.userType];
            NSNumber *messageBodyType = [NSNumber numberWithInteger:messageRes.messageBodyType];
            NSNumber *timestamp = [NSNumber numberWithDouble:messageRes.timestamp];

            
            id conversationId = messageRes.conversationId ? messageRes.conversationId : [NSNull null];
            id loginId = messageRes.loginId ? messageRes.loginId : [NSNull null];
            id messageId = messageRes.messageId ? messageRes.messageId : [NSNull null];
            id fromId = messageRes.fromId ? messageRes.fromId : [NSNull null];
            id toId = messageRes.toId ? messageRes.toId : [NSNull null];
            id messageContent = messageRes.messageContent ? messageRes.messageContent : [NSNull null];
            
            NSArray *arr = @[conversationId,loginId, messageId,fromId, toId, messageContent, userType, messageBodyType, timestamp];
            insertTableResult = [db executeUpdate:sql withArgumentsInArray:arr];
            if (insertTableResult){
                NSLog(@"插入成功！");
            }else{
                
                NSLog(@"插入失败");
                *rollback = YES;
                [db rollback];
                break;
            }

            
        }
        
    }];
    
}

/*
 * 删除数据，默认删除所有
 */
- (BOOL)deleteData:(NSString *)deleteSql
{
    return  YES;
}




@end


//
//
//
//INSERT  INTO t_chat_conversationId13711223319 (userId, messageId, messageData) VALUES ('13611223344', '118269', '<62706c69 73743030 d4010203 04050636 37582476 65727369 6f6e5824 6f626a65 63747359 24617263 68697665 72542474 6f701200 0186a0af 10120708 1f202122 23242526 2728292a 2b2c2d2e 55246e75 6c6cd309 0a0b0c15 1e574e53 2e6b6579 735a4e53 2e6f626a 65637473 5624636c 617373a8 0d0e0f10 11121314 80028003 80048005 80068007 80088009 a8161718 19181b1c 1d800a80 0b800c80 0d800c80 0e800f80 10801159 6d657373 61676549 64597469 6d657374 616d705e 73656e64 65725573 65724e61 6d655e63 6f6e7665 72736174 696f6e49 645f1012 73656e64 65725573 65724963 6f6e4e61 6d655f10 0f6d6573 73616765 426f6479 54797065 5e6d6573 73616765 436f6e74 656e7458 75736572 54797065 56313138 32363923 41d6280c 25000000 629e234e ba5f1019 636f6e76 65727361 74696f6e 49643133 37313132 32333331 3910016f 10668fd9 662f6211 76846d88 606fff0c 8fd9662f 62117684 6d88606f 30028fd9 662f6211 76846d88 606fff0c 8fd9662f 62117684 6d88606f 30028fd9 662f6211 76846d88 606fff0c 8fd9662f 62117684 6d88606f 30028fd9 662f6211 76846d88 606fff0c 8fd9662f 62117684 6d88606f 30028fd9 662f6211 76846d88 606fff0c 8fd9662f 62117684 6d88606f 30028fd9 662f6211 76846d88 606fff0c 8fd9662f 62117684 6d88606f 30028fd9 662f6211 76846d88 606fff0c 8fd9662f 62117684 6d88606f 30020020 00200020 00311000 d22f3031 325a2463 6c617373 6e616d65 5824636c 61737365 735f1013 4e534d75 7461626c 65446963 74696f6e 617279a3 3334355f 10134e53 4d757461 626c6544 69637469 6f6e6172 795c4e53 44696374 696f6e61 7279584e 534f626a 6563745f 100f4e53 4b657965 64417263 68697665 72d13839 54726f6f 74800100 08001100 1a002300 2d003200 37004c00 52005900 61006c00 73007c00 7e008000 82008400 86008800 8a008c00 95009700 99009b00 9d009f00 a100a300 a500a700 b100bb00 ca00d900 ee010001 0f011801 1f012801 2d014901 4b021a02 1c022102 2c023502 4b024f02 65027202 7b028d02 90029500 00000000 00020100 00000000 00003a00 00000000 00000000 00000000 000297>');
//
//
//2017-03-12 00:39:56.486 chatcoin[77460:8548539] -[__NSCFString bytes]: unrecognized selector sent to instance 0x7fed1689a800
//(lldb) po messageData
//    <
//    62706c69 73743030 d4010203 04050636 37582476 65727369 6f6e5824 6f626a65 63747359 24617263 68697665 72542474 6f701200 0186a0af 10120708 1f202122 23242526 2728292a 2b2c2d2e 55246e75 6c6cd309 0a0b0c15 1e574e53 2e6b6579 735a4e53 2e6f626a 65637473 5624636c 617373a8 0d0e0f10 11121314 80028003 80048005 80068007 80088009 a8161718 19181b1c 1d800a80 0b800c80 0d800c80 0e800f80 10801159 6d657373 61676549 64597469 6d657374 616d705e 73656e64 65725573 65724e61 6d655e63 6f6e7665 72736174 696f6e49 645f1012 73656e64 65725573 65724963 6f6e4e61 6d655f10 0f6d6573 73616765 426f6479 54797065 5e6d6573 73616765 436f6e74 656e7458 75736572 54797065 56323637 36323823 41d6280d 60000000 629e234e ba5f1019 636f6e76 65727361 74696f6e 49643133 37313132 32333331 3910016f 10678fd9 662f6211 76846d88 606fff0c 8fd9662f 62117684 6d88606f 30028fd9 662f6211 76846d88 606fff0c 8fd9662f 62117684 6d88606f 30028fd9 662f6211 76846d88 606fff0c 8fd9662f 62117684 6d88606f 30028fd9 662f6211 76846d88 606fff0c 8fd9662f 62117684 6d88606f 30028fd9 662f6211 76846d88 606fff0c 8fd9662f 62117684 6d88606f 30028fd9 662f6211 76846d88 606fff0c 8fd9662f 62117684 6d88606f 30028fd9 662f6211 76846d88 606fff0c 8fd9662f 62117684 6d88606f 30020020 00200020 00310039 1000d22f 3031325a 24636c61 73736e61 6d655824 636c6173 7365735f 10134e53 4d757461 626c6544 69637469 6f6e6172 79a33334 355f1013 4e534d75 7461626c 65446963 74696f6e 6172795c 4e534469 6374696f 6e617279 584e534f 626a6563 745f100f 4e534b65 79656441 72636869 766572d1 38395472 6f6f7480 01000800 11001a00 23002d00 32003700 4c005200 59006100 6c007300 7c007e00 80008200 84008600 88008a00 8c009500 97009900 9b009d00 9f00a100 a300a500 a700b100 bb00ca00 d900ee01 00010f01 18011f01 28012d01 49014b02 1c021e02 23022e02 37024d02 51026702 74027d02 8f029202 97000000 00000002 01000000 00000000 3a000000 00000000 00000000 00000002 99>
//
