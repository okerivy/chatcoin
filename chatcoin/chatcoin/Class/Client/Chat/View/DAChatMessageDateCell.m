//
//  DAChatMessageDateCell.m
//  chatcoin
//
//  Created by okerivy on 2017/2/12.
//  Copyright © 2017年 okerivy. All rights reserved.
//

#import "DAChatMessageDateCell.h"


#define HorizontalMargin 3
#define VerticalMargin 3

@interface DAChatMessageDateCell ()

@property (nonatomic) UILabel *dateLabel;

@end


@implementation DAChatMessageDateCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = kLLBackgroundColor_lightGray;
        
        self.dateLabel = [[UILabel alloc] init];
        self.dateLabel.font = [UIFont systemFontOfSize:12];
        self.dateLabel.textColor = [UIColor whiteColor];
        self.dateLabel.backgroundColor = kLLBackgroundColor_darkGray;
        self.dateLabel.layer.cornerRadius = 6;
        self.dateLabel.clipsToBounds = YES;
        self.dateLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:self.dateLabel];
    }
    
    return self;
}


- (void)setMessageFrame:(ChatMessageFrame *)MessageFrame {
    
    
    if (_MessageFrame != MessageFrame) {
        _MessageFrame = MessageFrame;
        DAChatMessageRes *messageModel =  MessageFrame.message;

        NSDate *date = [NSDate dateWithTimeIntervalSince1970:messageModel.timestamp];
        self.dateLabel.text = [date timeIntervalBeforeNowLongDescription];
        
        [self layoutContentView];
    }

    
}

- (void)setMessageModel:(DAChatMessageRes *)messageModel {
    if (_messageModel != messageModel) {
        _messageModel = messageModel;
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:_messageModel.timestamp];
        self.dateLabel.text = [date timeIntervalBeforeNowLongDescription];
        
        [self layoutContentView];
    }
    
//    [messageModel clearNeedsUpdateForReuse];
}

- (void)layoutContentView {
    CGRect frame = CGRectZero;
    frame.size.width = self.dateLabel.intrinsicContentSize.width + 2 * HorizontalMargin;
    frame.size.height = self.dateLabel.intrinsicContentSize.height + 2 * VerticalMargin;
    
    frame.origin.x = (SCREEN_WIDTH - frame.size.width) /2;
    frame.origin.y = (self.MessageFrame.cellHeight - frame.size.height)/2 - 5;
    self.dateLabel.frame = frame;
    
}



@end
