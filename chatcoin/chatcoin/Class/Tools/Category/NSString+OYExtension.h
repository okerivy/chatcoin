//
//  NSString+OYExtension.h
//
//  Created by okerivy on 10/23/13.
//  Copyright (c) 2013 OY. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSString (OYExtension)


/** 吧一个datestring 变成一个datestring 换格式 yyyy-MM-dd  HH:mm  */
- (NSString *)stringByDateString_M;

/** 吧一个datestring 变成一个datestring 换格式 yyyy-MM-dd  HH:mm:ss  */
- (NSString *)stringByDateString_S;

/**
 *  根据字体返回单行字符串的尺寸
 *
 *  @return 字符串的size
 */
- (CGSize)sizeWithTextFont:(UIFont *)TextFont;

/**
 *  根据字体和指定宽度返回字符串的尺寸
 *  @param font  字体
 *  @param width 最大宽度
 *
 *  @return 字符串的size
 */
- (CGSize)sizeWithTextFont:(UIFont *)TextFont maxWidth:(CGFloat)width;

/**
 *  判断是否包含某个字符串
 *  @return 是否包含
 */
- (BOOL)contains:(NSString *)string;

/**
 *  将字符串进行翻转
 */
- (NSString *)reverseString;

/**
 *  去除字符串首尾的空格
 */
- (NSString *)trim;


/** 判断字符串是否为空 */
- (NSString *)judgeNullString;

/** 时间转换  毫秒转为日期 */
-(NSString*)conversionTime;

/** 字符串转 NSNuber (整数) */
-(id)numberInt;


///**
// *  过滤表情
// */
//- (NSString *)isContainsEmoji:(NSString *)string;

@end
