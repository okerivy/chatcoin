//
//  ChatMessageFrame.m
//  chatcoin
//
//  Created by okerivy on 2017/2/12.
//  Copyright © 2017年 okerivy. All rights reserved.
//

#import "ChatMessageFrame.h"
#import "LiuqsDecoder.h"

//屏幕宽
#define screenW [UIScreen mainScreen].bounds.size.width
//屏幕高
#define screenH [UIScreen mainScreen].bounds.size.height


@implementation ChatMessageFrame

- (void)setMessage:(DAChatMessageRes *)message {

    _message = message;
    
    CGFloat headW  = 40;
    CGFloat headH  = 40;
    CGFloat margin = 10;
    CGFloat headX = message.userType == DAMessageUserTypeMe ? screenW - headW - margin : margin;
    self.headViewFrame = CGRectMake(headX, margin, headW, headH);
    
    CGRect nameFrame = CGRectMake(CGRectGetMaxX(self.headViewFrame) + margin, CGRectGetMinY(self.headViewFrame), screenW - margin * 2 - headW, 20);
    
    self.nameLabelFrame = message.userType == DAMessageUserTypeMe ? nameFrame : CGRectZero;
    self.nameLabelFrame = CGRectZero;

    
    NSMutableAttributedString *attMessage = [LiuqsDecoder decodeWithPlainStr:message.messageContent font:[UIFont systemFontOfSize:17.0f]];
    
    self.attMessage = attMessage;
    
    CGFloat AllMargin = 31;
    
    CGSize maxsize = CGSizeMake(screenW - (margin * 4 + headW * 2) - AllMargin, MAXFLOAT);
    
    // 创建文本容器
    YYTextContainer *container = [YYTextContainer new];
    container.size = maxsize;
    container.maximumNumberOfRows = 0;
    // 生成排版结果
    //FIXME: 输入 带空格的字符串,计算有问题
    YYTextLayout *layout = [YYTextLayout layoutWithContainer:container text:self.attMessage];
    
    CGFloat airX = message.userType == DAMessageUserTypeMe ? screenW - margin * 2 - headW - layout.textBoundingSize.width - AllMargin : margin * 2 + headW;
    
    CGFloat textHight = layout.textBoundingSize.height > 25 ? layout.textBoundingSize.height : 25;
    self.airViewFrame = CGRectMake(airX, 10, layout.textBoundingSize.width + 31, textHight + 16);
    
    CGFloat contentX = message.userType == DAMessageUserTypeMe ? screenW - margin * 2 - headW - layout.textBoundingSize.width - 18 : margin * 2 + headW + 20;
    
    self.messageLabelFrame = CGRectMake(contentX, 43-25, layout.textBoundingSize.width, textHight);
    
    switch (message.messageBodyType) {
        case DAMessageContentTypeText: {
            self.cellHeight = CGRectGetMaxY(self.messageLabelFrame) + margin * 2;
            break;
        }
        case DAMessageContentTypeDateTime: {
            self.cellHeight = 40;
            break;
        }
        default:
            break;
    }

    
    
}

@end
