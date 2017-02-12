//
//  ChatMessage.h
//  chatcoin
//
//  Created by okerivy on 2017/2/12.
//  Copyright © 2017年 okerivy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    userTypeMe,
    userTypeOther,
} userType;

typedef NS_ENUM(NSInteger, LLMessageBodyType) {
    kLLMessageBodyTypeText = 1,
    kLLMessageBodyTypeDateTime,
    
};

@interface ChatMessage : NSObject

@property(nonatomic, copy) NSString *userHeadImage;

@property(nonatomic, copy) NSString *userName;

@property(nonatomic, copy) NSString *messageContent;

@property(nonatomic, assign) userType userType;

@property(nonatomic, assign) NSInteger userId;

@property (nonatomic, assign) LLMessageBodyType messageBodyType;

@property (nonatomic) NSTimeInterval timestamp;

@end
