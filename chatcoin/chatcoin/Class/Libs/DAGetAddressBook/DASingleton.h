
//
//  DASingleton.h
//  DAGetAddressBook
//
//  Created by okerivy on 2017/2/17.
//  Copyright © 2017年 okerivy. All rights reserved.
//

#ifndef DASingleton_h
#define DASingleton_h

// .h文件
#define DASingletonH(className) + (instancetype)shared##className;

// .m文件
#define DASingletonM(className) \
static id _instance; \
 \
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [super allocWithZone:zone]; \
    }); \
    return _instance; \
} \
 \
+ (instancetype)shared##className \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [[self alloc] init]; \
    }); \
    return _instance; \
} \
 \
- (id)copyWithZone:(NSZone *)zone \
{ \
    return _instance; \
}

#endif /* DASingleton_h */
