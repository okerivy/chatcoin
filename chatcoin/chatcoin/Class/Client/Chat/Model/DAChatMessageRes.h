//
//  ChatMessage.h
//  chatcoin
//
//  Created by okerivy on 2017/2/12.
//  Copyright © 2017年 okerivy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DAChatEnum.h"



@interface DAChatMessageRes : NSObject

@property(nonatomic, copy) NSString *userHeadImage;

@property(nonatomic, copy) NSString *userName;

@property(nonatomic, copy) NSString *messageContent;

@property(nonatomic, assign) DAMessageUserType userType;

@property(nonatomic, assign) NSInteger userId;

@property (nonatomic, assign) DAMessageContentType messageBodyType;

@property (nonatomic) NSTimeInterval timestamp;

@end
