//
//  LYHomeCellModel.m
//  LYSideslipCellDemo
//
//  Created by Louis on 16/7/5.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "LYHomeCellModel.h"


@implementation LYHomeCellModel


+ (NSArray *)requestDataArray {
    NSArray *images = @[@"icon0", @"icon1", @"icon2", @"icon3", @"icon4"];
    NSArray *names = @[@"Louis", @"老帅哥", @"iOS Coder", @"iOS Developer", @"Joe"];
    NSArray *time = @[@"13:14", @"23:45", @"昨天", @"星期五", @"15/10/19"];
    NSArray *lastMessage = @[@"你个傻×, 快回消息!", @"今天天气很好啊, 是不是?, 是不是?, 是不是?, 是不是?, 是不是?, 是不是?, 是不是?, 是不是?, 是不是?", @"http://www.louisly.com 我的博客哦", @"hello?", @"What can i do for you?"];
    NSMutableArray *mArray = [NSMutableArray array];
    
    NSInteger count = 20;
    NSArray *arr = [self randomArray:[self orderArray:count]];

    
    for (int i = 0; i < count; i++) {
        LYHomeCellModel *model = [LYHomeCellModel new];
        model.iconName = images[arc4random()%5];
        model.userName = names[arc4random()%5];
        model.timeString = time[arc4random()%5];
        model.lastMessage = lastMessage[arc4random()%5];
        model.messageType = 0;
        model.messageUserId = [NSString stringWithFormat:@"%@%@",@"137112233",arr[i]];
        model.conversationId = [NSString stringWithFormat:@"%@%@",@"conversationId",model.messageUserId];

        if (i == 3) {
            model.messageType = 1;
            model.iconName = @"add_friend_icon_offical";
        }
        if (i == 5) {
            model.messageType = 2;
            model.iconName = @"ReadVerified_icon";
        }
        [mArray addObject:model];
    }
    
    
    return mArray;
}

//生成顺序数组
+ (NSArray *)orderArray:(NSInteger)count
{
    NSMutableArray *array =[NSMutableArray array];
    
    for (int i= 1; i<=count; i++) {
        [array addObject:[NSString stringWithFormat:@"%02zd",i]];
        
    }
    return array;
}

//生成不重复随机数
+ (NSArray *)randomArray:(NSArray *)array
{
    //随机数从这里边产生
    NSMutableArray *startArray=[NSMutableArray arrayWithArray:array];
    //随机数产生结果
    NSMutableArray *resultArray=[[NSMutableArray alloc] initWithCapacity:0];
    //随机数个数
    NSInteger m= array.count;
    for (int i=0; i<m; i++) {
        int t=arc4random()%startArray.count;
        resultArray[i]=startArray[t];
        startArray[t]=[startArray lastObject]; //为更好的乱序，故交换下位置
        [startArray removeLastObject];
    }
    return resultArray;
}

@end
