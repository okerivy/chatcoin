//
//  ChatMessageCell.h
//  chatcoin
//
//  Created by okerivy on 2017/2/12.
//  Copyright © 2017年 okerivy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatMessageFrame.h"

@interface ChatMessageCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableview;

@property(nonatomic, strong) ChatMessageFrame *MessageFrame;

@property(nonatomic, copy)void(^deleteMessage)(ChatMessageFrame *MessageFrame);

@end
