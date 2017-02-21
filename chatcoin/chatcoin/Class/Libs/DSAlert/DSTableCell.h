//  chatcoin
//
//  Created by okerivy on 2017/2/21.
//  Copyright © 2017年 okerivy. All rights reserved.
//



#import <UIKit/UIKit.h>

static NSString *DSASCellIdentifier = @"DSTableCell";

@interface DSTableCell : UITableViewCell

/*! 自定义图片 */
@property (weak, nonatomic) IBOutlet UIImageView  *customImageView;
/*! 自定义title */
@property (weak, nonatomic) IBOutlet UILabel      *customTextLabel;


@end
