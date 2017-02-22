//
//  DAFlowBalanceCell.m
//  chatcoin
//
//  Created by okerivy on 2017/2/22.
//  Copyright © 2017年 okerivy. All rights reserved.
//

#import "DAFlowBalanceCell.h"


@interface DAFlowBalanceCell ()
@property (nonatomic, strong) UIView *bigView;
@property (nonatomic, strong) UILabel *accountLabel;
/** copy */
@property (nonatomic, strong) UIButton *zCopyBtn;

/** copy */
@property (nonatomic, strong) UIButton *zQcodeBtn;

@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UIImageView *moneyImageView;
/** copy */
@property (nonatomic, strong) UILabel *donateLabel;



@end

@implementation DAFlowBalanceCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        
        CGFloat bigViewWidth = screenWidth - 20;
        _bigView = [[UIView alloc] initWithFrame:CGRectMake(10, 2, bigViewWidth, 170)];
        _bigView.backgroundColor = ZKColor_Var(79, 150, 150);
        _bigView.clipsToBounds = YES;
        _bigView.layer.cornerRadius = 3;
        _bigView.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.2].CGColor;
        _bigView.layer.borderWidth = 0.5;
        
        [self addSubview:_bigView];
        
        
        _accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, bigViewWidth- 15- 15 -30, 30)];
        _accountLabel.text = @"SNWONO474NG04IMVJRNFKNRK3";
        _accountLabel.textColor = ZKColor_White;
        
        _accountLabel.font = [UIFont systemFontOfSize:20];
        
        [_bigView addSubview:_accountLabel];
        
        _zCopyBtn = [[UIButton alloc] initWithFrame:CGRectMake(bigViewWidth - 5 -30, 20, 30, 30)];
        [_zCopyBtn setImage:[UIImage imageNamed:@"复制"] forState:UIControlStateNormal];
        [_zCopyBtn addTarget:self action:@selector(zCopyAcount:) forControlEvents:UIControlEventTouchUpInside];
        
        [_bigView addSubview:_zCopyBtn];
        
        CGFloat zQcodeBtnY = 20 + 30 + 20;
        _zQcodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, zQcodeBtnY, 80, 80)];
        [_zQcodeBtn setBackgroundImage:[UIImage imageNamed:@"avatar3"] forState:UIControlStateNormal];
        [_zQcodeBtn addTarget:self action:@selector(zQcode:) forControlEvents:UIControlEventTouchUpInside];
        _zQcodeBtn.clipsToBounds = YES;
        _zQcodeBtn.layer.cornerRadius = 0.1;
        _zQcodeBtn.layer.borderColor = ZKColor_Var(133, 176, 176).CGColor;
        _zQcodeBtn.layer.borderWidth = 2;
        
        
        [_bigView addSubview:_zQcodeBtn];
        
        CGFloat moneyImageX = 50 + 80 + 20;
        CGFloat moneyImageY = zQcodeBtnY + 10;
        CGFloat moneyImageWidth = 20;
        
        _moneyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(moneyImageX, moneyImageY, moneyImageWidth, 30)];
        _moneyImageView.contentMode = UIViewContentModeScaleAspectFit;
        _moneyImageView.image = [UIImage imageNamed:@"聊天币余额"];
        [_bigView addSubview:_moneyImageView];
        
        NSString *moneyLabelStr = @"8749.7";
        UIFont *moneyLabelFont = [UIFont boldSystemFontOfSize:26];
        CGFloat moneyLabelWidth = [moneyLabelStr sizeWithTextFont:moneyLabelFont].width;
        
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(moneyImageX + moneyImageWidth + 5, moneyImageY, moneyLabelWidth +5, 30)];
        _moneyLabel.textColor = ZKColor_White;
        _moneyLabel.text = moneyLabelStr;
        _moneyLabel.font = moneyLabelFont;
        
        [_bigView addSubview:_moneyLabel];
        
        CGFloat donateLabelY = moneyImageY + 30 + 5;
        _donateLabel = [[UILabel alloc] initWithFrame:CGRectMake(moneyImageX, donateLabelY, 200, 20)];
        _donateLabel.textColor = ZKColor_Var(227, 236, 237);
        _donateLabel.text = @"捐赠量: 33455";
        _donateLabel.font = [UIFont systemFontOfSize:15];
        
        [_bigView addSubview:_donateLabel];

        
        
        
        self.backgroundColor = ZKColor_Clear;
        self.containView.backgroundColor = ZKColor_Clear;
        
    }
    return self;
}

- (void)sentMoney:(UIButton *)btn
{
    ZLog(@"%@", btn);
}


- (void)zQcode:(UIButton *)btn
{
    ZLog(@"%@", btn);
}


- (void)zCopyAcount:(UIButton *)btn
{
    ZLog(@"%@", btn);
}



@end
