//
//  DAContactStaicCell.m
//  chatcoin
//
//  Created by okerivy on 2017/2/17.
//  Copyright © 2017年 okerivy. All rights reserved.
//

#import "DAContactStaicCell.h"

@interface DAContactStaicCell ()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *lastMessageLabel;
@end

@implementation DAContactStaicCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        _iconImageView.clipsToBounds = YES;
        _iconImageView.layer.cornerRadius = 6;
        _iconImageView.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.2].CGColor;
        _iconImageView.layer.borderWidth = 0.5;
        [self addSubview:_iconImageView];
        
        _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_iconImageView.frame) + 10, 10, 200, 25)];
        _userNameLabel.centerY_LL = _iconImageView.centerY_LL;

        [self addSubview:_userNameLabel];
        
        
        _iconImageView.image = [UIImage imageNamed:@"add_friend_icon_offical"];
        
        _userNameLabel.text = @"添加通讯录";
        
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        _lastMessageLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_userNameLabel.frame), CGRectGetMaxY(_userNameLabel.frame), screenWidth - CGRectGetMinX(_userNameLabel.frame) - 10, 25)];
        _lastMessageLabel.textColor = [UIColor grayColor];
        _lastMessageLabel.font = [UIFont systemFontOfSize:14];
//        [self addSubview:_lastMessageLabel];
        
    }
    return self;
}



@end
