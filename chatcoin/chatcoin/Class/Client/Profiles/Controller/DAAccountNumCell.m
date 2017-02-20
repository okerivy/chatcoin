//
//  DAAccountNumCell.m
//  chatcoin
//
//  Created by okerivy on 2017/2/20.
//  Copyright © 2017年 okerivy. All rights reserved.
//

#import "DAAccountNumCell.h"


@interface DAAccountNumCell ()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *lastMessageLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@end

@implementation DAAccountNumCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        _iconImageView.clipsToBounds = YES;
        _iconImageView.layer.cornerRadius = 6;
        _iconImageView.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.2].CGColor;
        _iconImageView.layer.borderWidth = 0.5;
        _iconImageView.image = [UIImage imageNamed:@"ReadVerified_icon"];
        [self addSubview:_iconImageView];
        
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;

        _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_iconImageView.frame) + 10, 10, screenWidth - CGRectGetMaxX(_iconImageView.frame) - 10-20, 25)];
        _userNameLabel.text = @"JDSHGSHGSKHSKHKSJS398E4HSHGS3323";
        _userNameLabel.font = [UIFont systemFontOfSize:15];

        [self addSubview:_userNameLabel];
        
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
