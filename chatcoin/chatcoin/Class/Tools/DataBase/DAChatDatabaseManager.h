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

- (void)creatChatTableWithName:(NSString *)tableName;
/**
 *  根据请求参数去沙盒中加载缓存的消息数据
 *  @param offset   查询数据起始位置
 *  @param limit    一次查询的最大个数，查询最新20条 offset=0,limit=20. 查询最新20-40条，offset=20,limit=20;
 如果是 -1 表示获取从开始位置起的所有数据。
 */
- (NSArray *)loadMoreMessagesFromId:(NSString *)messageId
                          fromTable:(NSString *)tableName
                             offset:(NSInteger)offset
                              limit:(NSInteger)limit;

/**
 *  存储消息数据到沙盒中
 *
 *  @param messages 需要存储的消息数据
 */
- (void)insertMessages:(NSArray *)messages toTable:(NSString *)tableName;

/*
 * 删除数据，默认删除所有
 */
- (BOOL)deleteData:(NSString *)deleteSql;


@end


/*!
 *  \~chinese
 *  插入一条消息，消息的conversationId应该和会话的conversationId一致，消息会被插入DB，并且更新会话的latestMessage等属性
 *
 *  @param aMessage  消息实例
 *
 *  @result 是否成功
 *
 *  \~english
 *  Insert a message to conversation, message's conversationId should equle to conversation's conversationId, message will be inserted to DB, and update conversation's property
 *
 *  @param aMessage  Message
 *
 *  @result Message insert result, YES: success, No: fail
 */
//- (BOOL)insertMessage:(EMMessage *)aMessage;

/*!
 *  \~chinese
 *  删除一条消息
 *
 *  @param aMessageId  要删除消失的ID
 *
 *  @result 是否成功
 *
 *  \~english
 *  Delete a message
 *
 *  @param aMessageId  Message's ID who will be deleted
 *
 *  @result Message delete result, YES: success, No: fail
 */
//- (BOOL)deleteMessageWithId:(NSString *)aMessageId;

/*!
 *  \~chinese
 *  删除该会话所有消息
 *
 *  @result 是否成功
 *
 *  \~english
 *  Delete all message of the conversation
 *
 *  @result Delete result, YES: success, No: fail
 */
//- (BOOL)deleteAllMessages;

/*!
 *  \~chinese
 *  更新一条消息，不能更新消息ID，消息更新后，会话的latestMessage等属性进行相应更新
 *
 *  @param aMessage  要更新的消息
 *
 *  @result 是否成功
 *
 *  \~english
 *  Update a message, can't update message's messageId, conversation's latestMessage and so on properties will update after update the message
 *
 *  @param aMessage  Message
 *
 *  @result Message update result, YES: success, No: fail
 */
//- (BOOL)updateMessage:(EMMessage *)aMessage;

/*!
 *  \~chinese
 *  将消息设置为已读
 *
 *  @param aMessageId  要设置消息的ID
 *
 *  @result 是否成功
 *
 *  \~english
 *  Mark a message as read
 *
 *  @param aMessageId  Message's ID who will be set read status
 *
 *  @result Result of mark message as read, YES: success, No: fail
 */
//- (BOOL)markMessageAsReadWithId:(NSString *)aMessageId;

/*!
 *  \~chinese
 *  将所有未读消息设置为已读
 *
 *  @result 是否成功
 *
 *  \~english
 *  Mark all message as read
 *
 *  @result Result of mark all message as read, YES: success, No: fail
 */
//- (BOOL)markAllMessagesAsRead;

/*!
 *  \~chinese
 *  更新会话扩展属性到DB
 *
 *  @result 是否成功
 *
 *  \~english
 *  Update conversation extend properties to DB
 *
 *  @result Extend properties update result, YES: success, No: fail
 */
//- (BOOL)updateConversationExtToDB __deprecated_msg("setExt: will update extend properties to DB");

/*!
 *  \~chinese
 *  获取指定ID的消息
 *
 *  @param aMessageId  消息ID
 *
 *  @result 消息
 *
 *  \~english
 *  Get a message with the ID
 *
 *  @param aMessageId  Message's id
 *
 *  @result Message instance
 */
//- (EMMessage *)loadMessageWithId:(NSString *)aMessageId;

/*!
 *  \~chinese
 *  从数据库获取指定数量的消息，取到的消息按时间排序，并且不包含参考的消息，如果参考消息的ID为空，则从最新消息向前取
 *
 *  @param aMessageId  参考消息的ID
 *  @param aLimit      获取的条数
 *  @param aDirection  消息搜索方向
 *
 *  @result 消息列表<EMMessage>
 *
 *  \~english
 *  Get more messages from DB, result messages are sorted by receive time, and NOT include the reference message, if reference messag's ID is nil, will fetch message from latest message
 *
 *  @param aMessageId  Reference message's ID
 *  @param aLimit      Count of messages to load
 *  @param aDirection  Message search direction
 *
 *  @result Message list<EMMessage>
 */
//- (NSArray *)loadMoreMessagesFromId:(NSString *)aMessageId
//limit:(int)aLimit
//direction:(EMMessageSearchDirection)aDirection;


/*!
 *  \~chinese
 *  从数据库获取指定类型的消息，取到的消息按时间排序，如果参考的时间戳为负数，则从最新消息向前取，如果aLimit是负数，则获取所有符合条件的消息
 *
 *  @param aType        消息类型
 *  @param aTimestamp   参考时间戳
 *  @param aLimit       获取的条数
 *  @param aSender      消息发送方，如果为空则忽略
 *  @param aDirection   消息搜索方向
 *
 *  @result 消息列表<EMMessage>
 *
 *  \~english
 *  Get more messages with specified type from DB, result messages are sorted by received time, if reference timestamp is negative, will fetch message from latest message, andd will fetch all messages that meet the condition if aLimit is negative
 *
 *  @param aType        Message type to load
 *  @param aTimestamp   Reference timestamp
 *  @param aLimit       Count of messages to load
 *  @param aSender      Message sender, will ignore it if it's empty
 *  @param aDirection   Message search direction
 *
 *  @result Message list<EMMessage>
 */
//- (NSArray *)loadMoreMessagesWithType:(EMMessageBodyType)aType
//before:(long long)aTimestamp
//limit:(int)aLimit
//from:(NSString*)aSender
//direction:(EMMessageSearchDirection)aDirection;

/*!
 *  \~chinese
 *  从数据库获取包含指定内容的消息，取到的消息按时间排序，如果参考的时间戳为负数，则从最新消息向前取，如果aLimit是负数，则获取所有符合条件的消息
 *
 *  @param aKeywords    搜索关键字，如果为空则忽略
 *  @param aTimestamp   参考时间戳
 *  @param aLimit       获取的条数
 *  @param aSender      消息发送方，如果为空则忽略
 *  @param aDirection   消息搜索方向
 *
 *  @result 消息列表<EMMessage>
 *
 *  \~english
 *  Get more messages contain specified keywords from DB, result messages are sorted by received time, if reference timestamp is negative, will fetch message from latest message, andd will fetch all messages that meet the condition if aLimit is negative
 *
 *  @param aKeywords    Search content, will ignore it if it's empty
 *  @param aTimestamp   Reference timestamp
 *  @param aLimit       Count of messages to load
 *  @param aSender      Message sender, will ignore it if it's empty
 *  @param aDirection    Message search direction
 *
 *  @result Message list<EMMessage>
 */
//- (NSArray *)loadMoreMessagesContain:(NSString*)aKeywords
//before:(long long)aTimestamp
//limit:(int)aLimit
//from:(NSString*)aSender
//direction:(EMMessageSearchDirection)aDirection;

/*!
 *  \~chinese
 *  从数据库获取指定时间段内的消息，取到的消息按时间排序，为了防止占用太多内存，用户应当制定加载消息的最大数
 *
 *  @param aStartTimestamp  毫秒级开始时间
 *  @param aEndTimestamp    结束时间
 *  @param aMaxCount        加载消息最大数
 *
 *  @result 消息列表<EMMessage>
 *
 *  \~english
 *  Load messages from DB in duration, result messages are sorted by receive time, user should limit the max count to load to avoid memory issue
 *
 *  @param aStartTimestamp  Start time's timestamp in miliseconds
 *  @param aEndTimestamp    End time's timestamp in miliseconds
 *  @param aMaxCount        Message search direction
 *
 *  @result Message list<EMMessage>
 */
//- (NSArray *)loadMoreMessagesFrom:(long long)aStartTimestamp
//to:(long long)aEndTimestamp
//maxCount:(int)aMaxCount;

/*!
 *  \~chinese
 *  收到的对方发送的最后一条消息
 *
 *  @result 消息实例
 *
 *  \~english
 *  Get latest message that received from others
 *
 *  @result Message instance
 */
//- (EMMessage *)latestMessageFromOthers;
//


