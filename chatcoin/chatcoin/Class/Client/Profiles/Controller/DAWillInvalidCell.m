//
//  DAWillInvalidCell.m
//  chatcoin
//
//  Created by okerivy on 2017/2/22.
//  Copyright © 2017年 okerivy. All rights reserved.
//

#import "DAWillInvalidCell.h"


@interface DAWillInvalidCell ()
@property (nonatomic, strong) UIView *bigView;
@property (nonatomic, strong) UILabel *accountLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UIImageView *moneyImageView;

@property (nonatomic, strong) UIView *blankView;


@end

@implementation DAWillInvalidCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        
        CGFloat bigViewWidth = screenWidth;
        CGFloat bigViewHight = 56;

        _bigView = [[UIView alloc] initWithFrame:CGRectMake(0, 2, bigViewWidth, bigViewHight)];
        _bigView.backgroundColor = ZKColor_White;
        
        [self addSubview:_bigView];
        
        
        _accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, bigViewHight)];
        _accountLabel.text = @"1 小时内失效";
        _accountLabel.font = [UIFont systemFontOfSize:18];
        
        [_bigView addSubview:_accountLabel];
        
        NSString *moneyLabelStr = @"88988";
        UIFont *moneyLabelFont = [UIFont systemFontOfSize:20];
        CGSize moneyLabelSize = [moneyLabelStr sizeWithTextFont:moneyLabelFont];
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(bigViewWidth - 15 - moneyLabelSize.width, 0, moneyLabelSize.width +5, bigViewHight)];
        _moneyLabel.text = moneyLabelStr;
        _moneyLabel.font = moneyLabelFont;
        
        [_bigView addSubview:_moneyLabel];
        
        
        _moneyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_moneyLabel.frame)-20, 0, 15, bigViewHight)];
        _moneyImageView.contentMode = UIViewContentModeScaleAspectFit;
        _moneyImageView.image = [UIImage imageNamed:@"流量币"];
        [_bigView addSubview:_moneyImageView];
        
        _blankView = [[UIView alloc] initWithFrame:CGRectMake(0, 56, bigViewWidth, 10)];
        _blankView.backgroundColor = kLLBackgroundColor_Default;
        [self addSubview:_blankView];
        
        
        self.backgroundColor = ZKColor_Clear;
        self.containView.backgroundColor = ZKColor_Clear;
        
    }
    return self;
}


- (void)zCopyAcount:(UIButton *)btn
{
    ZLog(@"%@", btn);
}



@end
