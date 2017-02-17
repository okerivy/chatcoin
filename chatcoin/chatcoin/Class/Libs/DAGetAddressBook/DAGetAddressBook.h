//
//  DAGetAddressBook.h
//  DAGetAddressBook
//
//  Created by okerivy on 2017/2/17.
//  Copyright © 2017年 okerivy. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "DAPersonModel.h"

/**
 *  获取按A~Z顺序排列的所有联系人的Block
 *
 *  @param addressBookDict 装有所有联系人的字典->每个字典key对应装有多个联系人模型的数组->每个模型里面包含着用户的相关信息.
 *  @param personOrderArray 装有所有排序后的联系人的模型数组
 *  @param nameKeys   联系人姓名的大写首字母的数组
 */
typedef void(^AddressBookDictBlock)(NSDictionary<NSString *,NSArray *> *addressBookDict,NSMutableArray *personOrderArray,NSArray *nameKeys);



@interface DAGetAddressBook : NSObject


/**
 *  获取按A~Z顺序排列的所有联系人
 *
 *  @param addressBookInfo 装着A~Z排序的联系人字典Block回调
 */
+ (void)getOrderAddressBook:(AddressBookDictBlock)addressBookInfo fromArray:(NSMutableArray *)persons;


@end
