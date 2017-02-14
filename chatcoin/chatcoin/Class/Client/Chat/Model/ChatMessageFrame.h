//
//  ChatMessageFrame.h
//  chatcoin
//
//  Created by okerivy on 2017/2/12.
//  Copyright © 2017年 okerivy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DAChatMessageRes.h"

@interface ChatMessageFrame : NSObject

@property(nonatomic, assign) CGRect headViewFrame;

@property(nonatomic, assign) CGRect nameLabelFrame;

@property(nonatomic, assign) CGRect messageLabelFrame;

@property(nonatomic, assign) CGRect airViewFrame;

@property(nonatomic, strong) DAChatMessageRes *message;

@property(nonatomic, strong) NSMutableAttributedString *attMessage;

@property(nonatomic, assign) CGFloat cellHeight;

@end
