
//
//  SearchUtils.h
//  chatcoin
//
//  Created by okerivy on 2017/2/8.
//  Copyright © 2017年 okerivy. All rights reserved.
//

#ifndef SearchUtils_h
#define SearchUtils_h

#define SAFE_SEND_MESSAGE(obj, msg) if ((obj) && [(obj) respondsToSelector:@selector(msg)])
//默认动画时间，单位秒
#define DEFAULT_DURATION 0.25

#endif /* SearchUtils_h */
