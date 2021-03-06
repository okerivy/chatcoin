//  chatcoin
//
//  Created by okerivy on 2017/2/21.
//  Copyright © 2017年 okerivy. All rights reserved.
//



#import "DSTableCell.h"

@implementation DSTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    
    CGContextFillRect(context, rect);
    
    //下分割线
    
    CGContextSetStrokeColorWithColor(context,[UIColor colorWithWhite:0.8 alpha:1].CGColor);
    
    CGContextStrokeRect(context,CGRectMake(0, rect.size.height, rect.size.width, 0.5f));
}

@end
