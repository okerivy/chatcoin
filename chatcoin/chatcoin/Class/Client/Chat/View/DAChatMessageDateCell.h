//
//  DAChatMessageDateCell.h
//  chatcoin
//
//  Created by okerivy on 2017/2/12.
//  Copyright © 2017年 okerivy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatMessageFrame.h"

@interface DAChatMessageDateCell : UITableViewCell

@property(nonatomic, strong) ChatMessageFrame *MessageFrame;

@property (nonatomic) DAChatMessageRes *messageModel;


@end
