//
//  DAChatEnum.h
//  chatcoin
//
//  Created by okerivy on 2017/2/14.
//  Copyright © 2017年 okerivy. All rights reserved.
//

#ifndef DAChatEnum_h
#define DAChatEnum_h

//消息是谁的
typedef NS_ENUM(NSInteger, DAMessageUserType) {
    DAMessageUserTypeMe = 0,
    DAMessageUserTypeOther,
    
};

//内容类型:1.文字 2.图片 3.语音 4.小视频
typedef NS_ENUM(NSInteger, DAMessageContentType) {
    DAMessageContentTypeText = 1,
    DAMessageContentTypeImage,
    DAMessageContentTypeVoice,
    DAMessageContentTypeVideo,
    DAMessageContentTypeDateTime,
};



#endif /* DAChatEnum_h */
