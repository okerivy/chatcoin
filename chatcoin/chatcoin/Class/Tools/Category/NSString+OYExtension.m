//
//  NSString+OYExtension.m
//
//  Created by okerivy on 10/23/13.
//  Copyright (c) 2013 OY. All rights reserved.
//

#import "NSString+OYExtension.h"

@implementation NSString (OYExtension)



/** 吧一个datestring 变成一个datestring 换格式 yyyy-MM-dd  HH:mm  */
- (NSString *)stringByDateString_S
{
   return  [self stringByDateString:@"yyyy-MM-dd  HH:mm:ss"];
}

/** 吧一个datestring 变成一个datestring 换格式 yyyy-MM-dd  HH:mm  */
- (NSString *)stringByDateString_M
{
   return  [self stringByDateString:@"yyyy-MM-dd  HH:mm"];
}

/** 吧一个datestring 变成一个datestring 换格式  */
- (NSString *)stringByDateString:(NSString *)dateFormatAfter
{

    if (self) {
        
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.S";
        NSDate *date =[dateFormatter dateFromString:self];
        
        NSString *newString;

        if (date) {
            dateFormatter.dateFormat = dateFormatAfter;
            newString = [dateFormatter stringFromDate:date];
        }
        
        if (!newString) {
            
            dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            date =[dateFormatter dateFromString:self];
            
            if (date) {
                dateFormatter.dateFormat = dateFormatAfter;
                newString = [dateFormatter stringFromDate:date];
            }
        }
        
        if (!newString) {
            
            dateFormatter.dateFormat = @"yyyy\/MM\/dd HH:mm:ss";
            date =[dateFormatter dateFromString:self];
            
            if (date) {
                dateFormatter.dateFormat = dateFormatAfter;
                newString = [dateFormatter stringFromDate:date];
            }
        }
        
        if (newString) {
            return newString;
        }
    }
    
    
    return self;
}

/**
 *  根据字体返回单行字符串的尺寸
 *
 *  @return 字符串的size
 */
- (CGSize)sizeWithTextFont:(UIFont *)TextFont
{
    return [self sizeWithTextFont:TextFont maxWidth:MAXFLOAT];
}

/**
 *  根据字体和指定宽度返回字符串的尺寸
 *  @param font  字体
 *  @param width 最大宽度
 *
 *  @return 字符串的size
 */
- (CGSize)sizeWithTextFont:(UIFont *)textFont maxWidth:(CGFloat)width
{
    if (!self) {
        return CGSizeZero;
    }
 
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSDictionary *attributes = @{NSFontAttributeName:textFont,
                                 NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize sizeTemp = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    CGSize sizeReal = CGSizeMake(sizeTemp.width, sizeTemp.height + 4);
   return sizeReal;
}

/**
 *  判断是否包含某个字符串
 *  @return 是否包含
 */
- (BOOL)contains:(NSString *)string
{
    return [self rangeOfString:string].length;
}

/**
 *  将字符串进行翻转
 */
- (NSString *)reverseString
{
    NSMutableString *str = [NSMutableString string];
    for (NSInteger i = self.length -1; i >= 0; i--) {
        unichar ch = [self characterAtIndex:i];
        
        [str appendString:[NSMutableString stringWithFormat:@"%c",ch]];
    }
    return str;
}

/**
 *  去除字符串首尾的空格
 */
- (NSString *)trim
{
    NSInteger start = 0;
    NSString *str = [[NSString alloc] init];
    for (NSInteger i = 0; i < self.length; i++) {
        unichar ch = [self characterAtIndex:i];
        if (ch == ' ') {
            start++;
        }else{
            break;
        }
    }
    str = [self substringFromIndex:start];
    NSInteger end = str.length;
    
    for (NSInteger i = str.length - 1; i >= 0; i--) {
        unichar ch = [str characterAtIndex:i];
        if (ch == ' ') {
            end--;
        }else{
            break;
        }
    }
    
    return [str substringToIndex:end];
}

/** 判断字符串是否为空 */
- (NSString *)judgeNullString
{
    if (self == nil || self == NULL || [self isEqual:@"<null>"]) {
        return @"";
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return self;
}

/** 时间转换  毫秒转为日期 */
-(NSString*)conversionTime
{
    long long time=[self longLongValue];
    NSDate *mydate=[NSDate dateWithTimeIntervalSince1970:time/1000];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";

    
    return [dateFormatter stringFromDate:mydate];
}

/** 字符串转 NSNuber (整数) */
- (id)numberInt
{
    id result;
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    result=[f numberFromString:self];
    if(!(result))
    {
        result=self;
        NSLog(@"无法成功转换为 NSNuber");
    }
    return result;
}

//
///**
// *  过滤表情
// */
//- (NSString *)isContainsEmoji:(NSString *)string {
//    __block BOOL isEomji = NO;
//     __block NSString *tempStr = [[NSString alloc] init];
//    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
//        const unichar hs = [substring characterAtIndex:0];
//        // surrogate pair
//        if (0xd800 <= hs && hs <= 0xdbff) {
//            if (substring.length > 1) {
//                const unichar ls = [substring characterAtIndex:1];
//                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
//                if (0x1d000 <= uc && uc <= 0x1f77f) {
//                    isEomji = YES;
//                   tempStr = [self getTitleStr:substring imageRange:substringRange];
//                }
//            }
//        } else {
//            // non surrogate
//            if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
//                isEomji = YES;
//                tempStr = [self getTitleStr:substring imageRange:substringRange];
//            } else if (0x2B05 <= hs && hs <= 0x2b07) {
//                isEomji = YES;
//                tempStr = [self getTitleStr:substring imageRange:substringRange];
//            } else if (0x2934 <= hs && hs <= 0x2935) {
//                isEomji = YES;
//                tempStr = [self getTitleStr:substring imageRange:substringRange];
//            } else if (0x3297 <= hs && hs <= 0x3299) {
//                isEomji = YES;
//                tempStr = [self getTitleStr:substring imageRange:substringRange];
//            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
//                isEomji = YES;
//                tempStr = [self getTitleStr:substring imageRange:substringRange];
//            }
//            if (!isEomji && substring.length > 1) {
//                const unichar ls = [substring characterAtIndex:1];
//                if (ls == 0x20e3) {
//                    isEomji = YES;
//                    tempStr = [self getTitleStr:substring imageRange:substringRange];
//                }
//            }
//        }
//        
//        
//    }];
//    
//    
//    
//    return tempStr;
//}
//
//
//-(NSString *)getTitleStr:(NSString *)string imageRange:(NSRange)range
//{
//    //    [self.titleStr stringByReplacingCharactersInRange:range withString:@""];
//    NSString *sss= [self stringByReplacingOccurrencesOfString:string withString:@""];
//    return sss;
//    
//}
//
//
@end
