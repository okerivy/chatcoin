//
//  AppDelegate.h
//  chatcoin
//
//  Created by okerivy on 2017/2/3.
//  Copyright © 2017年 okerivy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
/** 网络是否连接 */
@property (nonatomic, assign) BOOL  isNetworkConnect;
/** 是否是4G网 */
@property (nonatomic, assign) BOOL  isNetwork4G;

@end

