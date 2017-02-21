//  chatcoin
//
//  Created by okerivy on 2017/2/21.
//  Copyright © 2017年 okerivy. All rights reserved.
//




#import <UIKit/UIKit.h>

#define SCREENWIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT   [UIScreen mainScreen].bounds.size.height

#define DSWeak         __weak __typeof(self) weakSelf = self

typedef NS_ENUM(NSInteger, DSCustomActionSheetStyle) {
    /*!
     *  普通样式
     */
    DSCustomActionSheetStyleNormal = 1,
    /*!
     *  带标题样式
     */
    DSCustomActionSheetStyleTitle,
    /*!
     *  带图片和标题样式
     */
    DSCustomActionSheetStyleImageAndTitle,
    /*!
     *  带图片样式
     */
    DSCustomActionSheetStyleImage,
};

typedef void(^ButtonActionBlock)(NSInteger index);

@interface DSActionSheet : UIView

/*!
 *
 *  @param style             样式
 *  @param contentArray      选项数组(NSString数组)
 *  @param imageArray        图片数组(UIImage数组)
 *  @param redIndex          特别颜色的下标数组(NSNumber数组)
 *  @param title             标题内容(可空)
 *  @param clikckButtonIndex block回调点击的选项
 */
+ (void)ds_showActionSheetWithStyle:(DSCustomActionSheetStyle)style
                       contentArray:(NSArray<NSString *> *)contentArray
                         imageArray:(NSArray<UIImage *> *)imageArray
                           redIndex:(NSInteger)redIndex
                              title:(NSString *)title
                      configuration:(void (^)(DSActionSheet *tempView)) configuration
                  ClikckButtonIndex:(ButtonActionBlock)clikckButtonIndex;

/*!
 *  隐藏 DSActionSheet
 */
- (void)ds_dismissDSActionSheet;

@end
