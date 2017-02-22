//
//  DAChatBalanceCell.m
//  chatcoin
//
//  Created by okerivy on 2017/2/22.
//  Copyright © 2017年 okerivy. All rights reserved.
//

#import "DAChatBalanceCell.h"


@interface DAChatBalanceCell ()
@property (nonatomic, strong) UIView *bigView;
@property (nonatomic, strong) UILabel *accountLabel;
/** copy */
@property (nonatomic, strong) UIButton *zCopyBtn;

/** copy */
@property (nonatomic, strong) UIButton *zQcodeBtn;

@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UIImageView *moneyImageView;
/** copy */
@property (nonatomic, strong) UIButton *sentBtn;



@end

@implementation DAChatBalanceCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        
        CGFloat bigViewWidth = screenWidth - 20;
        _bigView = [[UIView alloc] initWithFrame:CGRectMake(10, 2, bigViewWidth, 170)];
        _bigView.backgroundColor = ZKColor_Var(116, 151, 241);
        _bigView.clipsToBounds = YES;
        _bigView.layer.cornerRadius = 3;
        _bigView.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.2].CGColor;
        _bigView.layer.borderWidth = 0.5;
        
        [self addSubview:_bigView];
        
        
        _accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, bigViewWidth- 15- 15 -30, 30)];
        _accountLabel.text = @"4GSONFWNF93JOENMNGGKENGE";
        _accountLabel.textColor = ZKColor_White;

        _accountLabel.font = [UIFont systemFontOfSize:20];
        
        [_bigView addSubview:_accountLabel];
        
        _zCopyBtn = [[UIButton alloc] initWithFrame:CGRectMake(bigViewWidth - 5 -30, 20, 30, 30)];
        [_zCopyBtn setImage:[UIImage imageNamed:@"复制"] forState:UIControlStateNormal];
        [_zCopyBtn addTarget:self action:@selector(zCopyAcount:) forControlEvents:UIControlEventTouchUpInside];
        
        [_bigView addSubview:_zCopyBtn];
        
        CGFloat zQcodeBtnY = 20 + 30 + 20;
        _zQcodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, zQcodeBtnY, 80, 80)];
        [_zQcodeBtn setBackgroundImage:[UIImage imageNamed:@"avatar1"] forState:UIControlStateNormal];
        [_zQcodeBtn addTarget:self action:@selector(zQcode:) forControlEvents:UIControlEventTouchUpInside];
        _zQcodeBtn.clipsToBounds = YES;
        _zQcodeBtn.layer.cornerRadius = 0.1;
        _zQcodeBtn.layer.borderColor = ZKColor_Var(158, 182, 245).CGColor;
        _zQcodeBtn.layer.borderWidth = 2;
        
        
        [_bigView addSubview:_zQcodeBtn];
        
        CGFloat sentBtnX = 50 + 80 + 10;
        CGFloat sentBtnY = 20 + 30 + 20 + 40;
        CGFloat sentBtnWidth = bigViewWidth - sentBtnX -50;


        _sentBtn = [[UIButton alloc] initWithFrame:CGRectMake(sentBtnX, sentBtnY, sentBtnWidth, 40)];
        [_sentBtn setTitle:@"转账" forState:UIControlStateNormal];
        [_sentBtn setTitleColor:ZKColor_Var(65, 61, 107) forState:UIControlStateNormal];
        _sentBtn.backgroundColor = ZKColor_Var(200, 214, 250);
        _sentBtn.clipsToBounds = YES;
        _sentBtn.layer.cornerRadius = 3;
        _sentBtn.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.2].CGColor;
        _sentBtn.layer.borderWidth = 0.5;
        [_sentBtn addTarget:self action:@selector(sentMoney:) forControlEvents:UIControlEventTouchUpInside];
        [_bigView addSubview:_sentBtn];
        
        
        
        NSString *moneyLabelStr = @"88.88";
        UIFont *moneyLabelFont = [UIFont boldSystemFontOfSize:26];
        CGFloat moneyLabelWidth = [moneyLabelStr sizeWithTextFont:moneyLabelFont].width;
        CGFloat moneyImageWidth = 20;

        // 计算图片起点
        CGFloat moneyImageX = sentBtnX + (sentBtnWidth - moneyImageWidth - moneyLabelWidth - 5)/2 ;
        
        _moneyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(moneyImageX, zQcodeBtnY, moneyImageWidth, 30)];
        _moneyImageView.contentMode = UIViewContentModeScaleAspectFit;
        _moneyImageView.image = [UIImage imageNamed:@"聊天币余额"];
        [_bigView addSubview:_moneyImageView];
        

        
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(moneyImageX + moneyImageWidth + 5, zQcodeBtnY, moneyLabelWidth +5, 30)];
        _moneyLabel.textColor = ZKColor_Var(254, 214, 49);
        _moneyLabel.text = moneyLabelStr;
        _moneyLabel.font = moneyLabelFont;
        
        [_bigView addSubview:_moneyLabel];
        
        
        
               
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
