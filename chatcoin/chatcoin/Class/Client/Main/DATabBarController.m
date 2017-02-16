//
//  DATabBarController.m
//  chatcoin
//
//  Created by okerivy on 2017/2/5.
//  Copyright © 2017年 okerivy. All rights reserved.
//

#import "DATabBarController.h"
#import "DAConversationViewController.h"
#import "DAContractViewController.h"
#import "DAProfilesViewController.h"
#import "DANavigationController.h"




@interface DATabBarController ()

@end

@implementation DATabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UITabBar appearance] setBarTintColor:kLLBackgroundColor_Tabbar];
    [UITabBar appearance].translucent = NO;
    // 1.初始化子控制器
    DAConversationViewController *home = [[DAConversationViewController alloc] init];
    [self addChildVc:home title:@"聊天" image:@"tabbar_mainframe" selectedImage:@"tabbar_mainframeHL"];
    
    DAContractViewController *contract = [[DAContractViewController alloc] init];
    [self addChildVc:contract title:@"通讯录" image:@"tabbar_contacts" selectedImage:@"tabbar_contactsHL"];
    
    DAProfilesViewController *profile = [[DAProfilesViewController alloc] init];
    [self addChildVc:profile title:@"我的" image:@"tabbar_me" selectedImage:@"tabbar_meHL"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字
    childVc.title = title; // 同时设置tabbar和navigationBar的文字
    // 设置子控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = ZKColor_Var(123, 123, 123);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = ZKColor_Black;
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    childVc.view.backgroundColor = kLLBackgroundColor_Default;
    
    // 先给外面传进来的小控制器 包装 一个导航控制器
    DANavigationController *nav = [[DANavigationController alloc] initWithRootViewController:childVc];
    // 添加为子控制器
    [self addChildViewController:nav];
}


@end
