//
//  DAProfilesCell.m
//  chatcoin
//
//  Created by okerivy on 2017/2/19.
//  Copyright © 2017年 okerivy. All rights reserved.
//

#import "DAProfilesCell.h"

@interface DAProfilesCell ()

/** 横线 */
//@property (nonatomic, strong) UIView *lineView;
@property (nonatomic,strong)UIImageView *selectIcon;
@end

@implementation DAProfilesCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 50, 50)];
        [_iconImageView setImage:[UIImage imageNamed:@"center_Wallet"]];
        _iconImageView.contentMode = UIViewContentModeCenter;
        [self addSubview:_iconImageView];
        
        _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_iconImageView.frame) + 10, 0, 200, 50)];
        _userNameLabel.text =@"账号";

        [self addSubview:_userNameLabel];
        
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        
        //图片
        self.selectIcon=[[UIImageView alloc]initWithFrame:CGRectMake(screenWidth-9-14,98/2/2-11/2 , 7, 11)];
        //    selectI.backgroundColor=[UIColor redColor];
        self.selectIcon.image=[UIImage imageNamed:@"scanResult_moreDetail"];
        [self addSubview:self.selectIcon];
        self.selectIcon.userInteractionEnabled=YES;
        
    }
    return self;
}


@end

