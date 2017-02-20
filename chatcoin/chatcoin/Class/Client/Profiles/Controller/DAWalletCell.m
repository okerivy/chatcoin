//
//  DAWalletCell.m
//  chatcoin
//
//  Created by okerivy on 2017/2/20.
//  Copyright © 2017年 okerivy. All rights reserved.
//

#import "DAWalletCell.h"

@interface DAWalletCell ()
@property (nonatomic, strong) UIView *bigView;
@property (nonatomic, strong) UILabel *accountLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UIImageView *moneyImageView;
/** copy */
@property (nonatomic, strong) UIButton *zCopyBtn;

@property (nonatomic, strong) UIView *sentView;
@property (nonatomic, strong) UILabel *sentLabel;
@property (nonatomic, strong) UIImageView *sentImageView;


@end

@implementation DAWalletCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        
        CGFloat bigViewWidth = screenWidth - 20;
        _bigView = [[UIView alloc] initWithFrame:CGRectMake(10, 2, bigViewWidth, 196)];
        _bigView.backgroundColor = ZKColor_White;
        _bigView.clipsToBounds = YES;
        _bigView.layer.cornerRadius = 3;
        _bigView.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.2].CGColor;
        _bigView.layer.borderWidth = 0.5;

        [self addSubview:_bigView];

        
        _accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 30, 170, 30)];
        _accountLabel.text = @"JDSHGSHGJS398E4HSHGS3323";
        _accountLabel.font = [UIFont systemFontOfSize:23];
        
        [_bigView addSubview:_accountLabel];
        
        NSString *moneyLabelStr = @"88.88";
        UIFont *moneyLabelFont = [UIFont systemFontOfSize:23];
        CGSize moneyLabelSize = [moneyLabelStr sizeWithTextFont:moneyLabelFont];
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(bigViewWidth - 15 - moneyLabelSize.width, 30, moneyLabelSize.width +5, 30)];
        _moneyLabel.text = moneyLabelStr;
        _moneyLabel.font = moneyLabelFont;
        
        [_bigView addSubview:_moneyLabel];
        
        
        _moneyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_moneyLabel.frame)-20, 40, 14, 14)];
        _moneyImageView.contentMode = UIViewContentModeScaleAspectFill;
        _moneyImageView.image = [UIImage imageNamed:@"聊天币"];
        [_bigView addSubview:_moneyImageView];
        
        _zCopyBtn = [[UIButton alloc] initWithFrame:CGRectMake(7, 80, 44, 44)];
        [_zCopyBtn setImage:[UIImage imageNamed:@"复制"] forState:UIControlStateNormal];
        [_zCopyBtn addTarget:self action:@selector(zCopyAcount:) forControlEvents:UIControlEventTouchUpInside];

        [_bigView addSubview:_zCopyBtn];

        // 80 +44 + 12 = 136;
        _sentView = [[UIView alloc] initWithFrame:CGRectMake(0, 136, bigViewWidth, 60)];
        _sentView.backgroundColor = ZKColor_VarGray(251);
        [_bigView addSubview:_sentView];
        
        _sentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 30, 30)];
        _sentImageView.contentMode = UIViewContentModeCenter;
        _sentImageView.image = [UIImage imageNamed:@"转账-进行中"];
        [_sentView addSubview:_sentImageView];

        
       
        _sentLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 15, 200, 30)];
        _sentLabel.text = @"+ 11.66";
        _sentLabel.font = [UIFont systemFontOfSize:14];
        _sentLabel.textColor = [UIColor redColor];
        [_sentView addSubview:_sentLabel];
        
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
