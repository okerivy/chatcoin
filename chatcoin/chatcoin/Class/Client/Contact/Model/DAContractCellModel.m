//
//  DAContractCellModel.m
//  chatcoin
//
//  Created by okerivy on 2017/2/16.
//  Copyright © 2017年 okerivy. All rights reserved.
//

#import "DAContractCellModel.h"

@implementation DAContractCellModel


- (void)setUserName:(NSString *)userName
{
    _userName = userName;
    if ([self isBlankString:_remarkName]) {
        self.showName = _remarkName;
    } else if ([self isBlankString:_userName]) {
        self.showName = _userName;
    } else {
        self.showName = @"";
    }
}

- (void)setRemarkName:(NSString *)remarkName
{
    _remarkName = remarkName;
    if ([self isBlankString:_remarkName]) {
        self.showName = _remarkName;
    } else if ([self isBlankString:_userName]) {
        self.showName = _userName;
    } else {
        self.showName = @"";
    }
}

//判断字符串是否为空字符的方法
- (NSString *) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return nil;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return nil;
    }
    NSString *str = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([str length]!=0) {
        return str;
    }
    return nil;
}

+ (NSMutableArray *)requestDataArray {
    //模拟网络请求接收到的数组对象 Person数组
//    NSArray *images = @[@"icon0", @"icon1", @"icon2", @"icon3", @"icon4"];
    NSArray *images = @[@"鸣人", @"路飞"];

    NSArray *names = [NSArray arrayWithObjects:
                            @"李白",@"张三",
                            @"hello",@"千珏",
                            @"调节",@"重庆",
                            @"小白",@"肯德基",@"重量",
                            @"黄家驹", @"鼠标",@"调用",@"多美丽",@"小明",@"##",@"搜狗",@"百度",@"",@"     ",
                            nil];
    

    NSArray *autographs = @[@"今天是个好天气!", @"今天天气很好啊, 是不是?, 是不是?, 是不是?, 是不是?, 是不是?, 是不是?, 是不是?, 是不是?, 是不是?", @"我是百度我无耻", @"情人节过去了", @"What can i do for you?"];
    NSMutableArray *mArray = [NSMutableArray array];
    
    NSInteger count = names.count;
    NSArray *arr = [self randomArray:[self orderArray:count]];
    
    
    for (int i = 0; i < count; i++) {
        DAContractCellModel *model = [DAContractCellModel new];
        model.iconName = images[arc4random()%2];
        model.userName = names[i];
        model.autograph = autographs[arc4random()%5];
        model.messageType = DAContractCellTypeMessage;
        model.messageUserId = [NSString stringWithFormat:@"%@%@",@"137112233",arr[i]];
        model.conversationId = [NSString stringWithFormat:@"%@%@",@"conversationId",model.messageUserId];
        
        if (i == 3) {
            model.messageType = DAContractCellTypePubliction;
            model.iconName = @"add_friend_icon_offical";
        }
        if (i == 5) {
            model.messageType = DAContractCellTypeSubscription;
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
