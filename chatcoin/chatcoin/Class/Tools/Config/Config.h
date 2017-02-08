//
//  Config.h
//  chatcoin
//
//  Created by okerivy on 2017/2/4.
//  Copyright © 2017年 okerivy. All rights reserved.
//

#ifndef Config_h
#define Config_h

//1.获取屏幕宽度与高度
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 // 当前Xcode支持iOS8及以上

#define SCREEN_WIDTH ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.width)

#define SCREEN_HEIGHT ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.height)

#define SCREEN_SIZE ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?CGSizeMake([UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale,[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale):[UIScreen mainScreen].bounds.size)

#else

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

#endif


//2.获取通知中心
#define LRNotificationCenter [NSNotificationCenter defaultCenter]


//3.常用颜色------------------------------------------------------------------

// 常用颜色 可变色
#define ZKColor_Var(r, g, b) (ZKColor_VarA(r, g, b,1.0))// RGB 不透明颜色
// 常用颜色 随机色 不透明
#define ZKColor_Random (ZKColor_Var(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256)))


// RGBA 透明颜色
#define ZKColor_VarA(r, g, b,a) [UIColor colorWithRed: r/255.0 green: g/255.0 blue:b/255.0 alpha:a/1.0]
// 常用颜色 灰色颜色
#define ZKColor_VarGrayA(r, a) (ZKColor_VarA(r, r, r, a))// 灰色透明颜色
#define ZKColor_VarGray(r) (ZKColor_VarGrayA(r, 1.0)) // 灰色 不透明颜色


// 常用颜色 固定色
#define ZKColor_Clear [UIColor clearColor] // 透明色
#define ZKColor_White [UIColor whiteColor] // 白色
#define ZKColor_Black [UIColor blackColor] // 黑色
#define ZKColor_Red [UIColor redColor] // 红色

// 系统控件默认高度

#define ZKStatusBarH (20.f) //电源所在的状态栏
#define ZKTopBarH (44.f) //NavigationBar的高度
#define ZKBottomBarH (49.f) //Tabbar的高度
#define ZKNavH (64.f) //状态栏 ＋ 导航栏 高度

#define kCellDefaultHeight (44.f) //UITableViewCell 的默认高度
#define kEnglishKeyboardHeight (216.f)//英语键盘的默认高度
#define kChineseKeyboardHeight (252.f)//汉语键盘的默认高度
#define ZKKeyboardTime (0.25f)//键盘弹出的时间


//5.自定义高效率的 NSLog

#ifdef DEBUG
# define ZLog(fmt, ...) NSLog((@"\n" "    函数名:%s\n" "    行号:%d \n" fmt), __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define ZLog(...);
# define NSLog(...);
#endif

//6.弱引用/强引用
#define ZKWeakSelf(type)  __weak typeof(type) weak##type = type;
#define ZKStrongSelf(type)  __strong typeof(type) type = weak##type;

//7.设置 view 圆角和边框
#define LRViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

//8.由角度转换弧度 由弧度转换角度
#define LRDegreesToRadian(x) (M_PI * (x) / 180.0)
#define LRRadianToDegrees(radian) (radian*180.0)/(M_PI)

//9.设置加载提示框（第三方框架：Toast）


//10.设置加载提示框（第三方框架：MBProgressHUD）


//11.获取图片资源

#define kGetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]


//12.获取当前语言
#define LRCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])



//14.判断当前的iPhone设备/系统版本
//判断是否为iPhone
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

//判断是否为iPad
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//判断是否为ipod
#define IS_IPOD ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])

// 判断是否为 iPhone 5SE
#define iPhone5SE [[UIScreen mainScreen] bounds].size.width == 320.0f && [[UIScreen mainScreen] bounds].size.height == 568.0f

// 判断是否为iPhone 6/6s
#define iPhone6_6s [[UIScreen mainScreen] bounds].size.width == 375.0f && [[UIScreen mainScreen] bounds].size.height == 667.0f

// 判断是否为iPhone 6Plus/6sPlus
#define iPhone6Plus_6sPlus [[UIScreen mainScreen] bounds].size.width == 414.0f && [[UIScreen mainScreen] bounds].size.height == 736.0f

//获取系统版本
#define IOS_SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

//判断 iOS 8 或更高的系统版本
#define IOS_VERSION_8_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0)? (YES):(NO))

//15.判断是真机还是模拟器
#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif

//16.沙盒目录文件
//获取temp
#define kPathTemp NSTemporaryDirectory()

//获取沙盒 Document
#define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

//获取沙盒 Cache
#define kPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]




#endif /* Config_h */
