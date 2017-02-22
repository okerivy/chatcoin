//
//  DATransactionCell.m
//  chatcoin
//
//  Created by okerivy on 2017/2/22.
//  Copyright © 2017年 okerivy. All rights reserved.
//

#import "DATransactionCell.h"


@interface DATransactionCell ()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *lastMessageLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *sentLabel;
@property (nonatomic, strong) UIImageView *sentImageView;

@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UIImageView *moneyImageView;

@end

@implementation DATransactionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        _iconImageView.clipsToBounds = YES;
        _iconImageView.layer.cornerRadius = 6;
        _iconImageView.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.2].CGColor;
        _iconImageView.layer.borderWidth = 0.5;
        _iconImageView.image = [UIImage imageNamed:@"avatar2"];
        [self addSubview:_iconImageView];
        
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        
        _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_iconImageView.frame) + 10, 10, 130, 25)];
        _userNameLabel.text = @"HJEBLONJENL38J4ODJLENF3N33";
        _userNameLabel.font = [UIFont boldSystemFontOfSize:16];
        
        [self addSubview:_userNameLabel];
        
        NSString *moneyLabelStr = @"+ 234.87";
        UIFont *moneyLabelFont = [UIFont boldSystemFontOfSize:14];
        CGSize moneyLabelSize = [moneyLabelStr sizeWithTextFont:moneyLabelFont];
        _sentLabel = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth - 15 - moneyLabelSize.width, 10, moneyLabelSize.width +5, 25)];
        _sentLabel.text = moneyLabelStr;
        _sentLabel.font = moneyLabelFont;
        _sentLabel.textColor = [UIColor redColor];

        [self addSubview:_sentLabel];
        
        
        _sentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_sentLabel.frame)-5 - 25, 10, 25, 25)];
        _sentImageView.contentMode = UIViewContentModeScaleAspectFit;
        _sentImageView.image = [UIImage imageNamed:@"转账-进行中"];
        [self addSubview:_sentImageView];
        
        
        
        _lastMessageLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_userNameLabel.frame), CGRectGetMaxY(_userNameLabel.frame), 100, 25)];
        _lastMessageLabel.textColor = [UIColor grayColor];
        _lastMessageLabel.font = [UIFont systemFontOfSize:14];
        _lastMessageLabel.text = @"2017-01-13";
        
        [self addSubview:_lastMessageLabel];
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_lastMessageLabel.frame), CGRectGetMaxY(_userNameLabel.frame), 100, 25)];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.textColor = [UIColor grayColor];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.text = @"20:13";
        
        [self addSubview:_timeLabel];
    }
    return self;
}



@end
