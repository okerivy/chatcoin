//
//  DAChatBalanceCell.h
//  chatcoin
//
//  Created by okerivy on 2017/2/22.
//  Copyright © 2017年 okerivy. All rights reserved.
//

#import "LYSideslipCell.h"

typedef void (^clickTransMoneyBlock)();

@interface DAChatBalanceCell : LYSideslipCell

@property (nonatomic ,strong ) clickTransMoneyBlock transMoneyBlock ;

@end



