//
//  AppDelegate.m
//  chatcoin
//
//  Created by okerivy on 2017/2/3.
//  Copyright © 2017年 okerivy. All rights reserved.
//

#import "AppDelegate.h"
#import "DATabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self listenNetWorkingStatus]; //监听网络是否可用

    [self initUIAppearance];

    
    // 1.创建窗口
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    // 2.设置根控制器
    self.window.rootViewController = [[DATabBarController alloc] init];

    // 3.显示窗口
    [self.window makeKeyAndVisible];

    return YES;
}



- (void)initUIAppearance {
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    [UINavigationBar appearance].barTintColor = kLLBackgroundColor_Nav;

    [UINavigationBar appearance].barStyle = UIBarStyleBlack;
//    [UINavigationBar appearance].translucent = NO;

    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16]} forState:UIControlStateNormal];
    
    //设置返回按钮
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, -1, 0);
    UIImage *image = [UIImage imageNamed:@"barbuttonicon_back"];
    UIImage *backArrowImage = [image imageWithAlignmentRectInsets:insets];
    
    [UINavigationBar appearance].backIndicatorImage = backArrowImage;
    [UINavigationBar appearance].backIndicatorTransitionMaskImage = [UIImage imageWithColor:[UIColor clearColor] size:backArrowImage.size];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-4, 0) forBarMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [[UINavigationBar appearance] setTranslucent:NO];
    
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark- 监听网络变化

-(void)listenNetWorkingStatus{
    [GLobalRealReachability startNotifier];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkChanged:)
                                                 name:kRealReachabilityChangedNotification
                                               object:nil];
    ReachabilityStatus status = [GLobalRealReachability currentReachabilityStatus];
    [self realNetworkingStatus:status];
}

- (void)networkChanged:(NSNotification *)notification
{
    RealReachability *reachability = (RealReachability *)notification.object;
    ReachabilityStatus status = [reachability currentReachabilityStatus];
    [self realNetworkingStatus:status];
}
-(void)realNetworkingStatus:(ReachabilityStatus)status{
    switch (status)
    {
        case RealStatusUnknown:
        {
            NSLog(@"~~~~~~~~~~~~~RealStatusUnknown");
            self.isNetworkConnect = NO;
            self.isNetwork4G = NO;
            [self showNetworkStatusAlert:@"当前网络不可用"];
            break;
        }
            
        case RealStatusNotReachable:
        {
            NSLog(@"~~~~~~~~~~~~~RealStatusNotReachable");
            self.isNetworkConnect = NO;
            self.isNetwork4G = NO;
            [self showNetworkStatusAlert:@"无网络,请检查网络链接"];
            break;
        }
            
        case RealStatusViaWWAN:
        {
            NSLog(@"~~~~~~~~~~~~~RealStatusViaWWAN");
            self.isNetworkConnect = YES;
            self.isNetwork4G = YES;
            [self showNetworkStatusAlert:@"流量上网"];
            break;
        }
        case RealStatusViaWiFi:
        {
            NSLog(@"~~~~~~~~~~~~~RealStatusViaWiFi");
            self.isNetworkConnect = YES;
            self.isNetwork4G = NO;
            [self showNetworkStatusAlert:@"WIFI上网,尽情挥霍吧小宝贝~"];
            break;
        }
        default:
            break;
    }
}

-(void)showNetworkStatusAlert:(NSString *)str{
    //我这里是网络变化弹出一个警报框，由于不知道怎么让widow加载UIAlertController，所以这里用UIAlertView替代了
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}



#pragma mark- 系统方法



#pragma mark- 初始化方法



#pragma mark- set方法



#pragma mark- 监听方法



#pragma mark- 代理方法 Delegate



#pragma mark- 其他方法





#pragma mark- 懒加载




@end
