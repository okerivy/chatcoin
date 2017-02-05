//
//  LYHomeCell.m
//  LYSideslipCellDemo
//
//  Created by Louis on 16/7/5.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "LYHomeCell.h"

@interface LYHomeCell ()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *lastMessageLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@end

@implementation LYHomeCell

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
        [self addSubview:_userNameLabel];
        
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        _lastMessageLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_userNameLabel.frame), CGRectGetMaxY(_userNameLabel.frame), screenWidth - CGRectGetMinX(_userNameLabel.frame) - 10, 25)];
        _lastMessageLabel.textColor = [UIColor grayColor];
        _lastMessageLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_lastMessageLabel];
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth - 200 - 10, 10, 200, 25)];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_timeLabel];
    }
    return self;
}


- (void)setModel:(LYHomeCellModel *)model {
    _model = model;
    
    _iconImageView.image = [UIImage imageNamed:model.iconName];
    
    _userNameLabel.text = model.userName;
    
    _lastMessageLabel.text = model.lastMessage;
    
    _timeLabel.text = model.timeString;
}
@end
