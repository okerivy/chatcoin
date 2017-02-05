//
//  DAChatViewController.m
//  chatcoin
//
//  Created by okerivy on 2017/2/5.
//  Copyright © 2017年 okerivy. All rights reserved.
//

#import "DAChatViewController.h"
#import "ChatKeyBoard.h"
#import "MoreItem.h"
#import "ChatToolBarItem.h"
#import "FaceSourceManager.h"
#import "FaceThemeModel.h"


@interface DAChatViewController ()<UITableViewDelegate,UITableViewDataSource,ChatKeyBoardDataSource, ChatKeyBoardDelegate>

/** chatkeyBoard */
@property (nonatomic, strong) ChatKeyBoard *chatKeyBoard;


@end

@implementation DAChatViewController

#pragma mark ==== 懒加载 ===


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.conversationModel.userName;
    self.view.backgroundColor = JYUnvColor_White;
    
    self.navigationController.navigationBar.translucent = NO;

    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn1.frame = CGRectMake(50, 150, 120, 44);
    [btn1 setTitle:@"上去" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor purpleColor];
    [btn1 addTarget:self action:@selector(clickBtnUp:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    return;
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn2.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 170, 150, 120, 44);
    [btn2 setTitle:@"让键盘下去" forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor purpleColor];
    [btn2 addTarget:self action:@selector(clickBtnDown:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    
    
    self.chatKeyBoard = [ChatKeyBoard keyBoardWithNavgationBarTranslucent:NO];
    
    self.chatKeyBoard.delegate = self;
    self.chatKeyBoard.dataSource = self;
    
    self.chatKeyBoard.placeHolder = @"";
    [self.view addSubview:self.chatKeyBoard];

//    [self addSubviews];
//    self.dataSource = [NSMutableArray array];
    
//    [self initData];
}

- (void)clickBtnUp:(UIButton *)btn
{
    [self.chatKeyBoard keyboardUp];
}

- (void)clickBtnDown:(UIButton *)btn
{
    [self.chatKeyBoard keyboardDown];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = YES;
}

#pragma mark -- ChatKeyBoardDataSource
- (NSArray<MoreItem *> *)chatKeyBoardMorePanelItems
{
    MoreItem *item1 = [MoreItem moreItemWithPicName:@"sharemore_location" highLightPicName:nil itemName:@"位置"];
    MoreItem *item2 = [MoreItem moreItemWithPicName:@"sharemore_pic" highLightPicName:nil itemName:@"图片"];
    MoreItem *item3 = [MoreItem moreItemWithPicName:@"sharemore_video" highLightPicName:nil itemName:@"拍照"];
    MoreItem *item4 = [MoreItem moreItemWithPicName:@"sharemore_location" highLightPicName:nil itemName:@"位置"];
    MoreItem *item5 = [MoreItem moreItemWithPicName:@"sharemore_pic" highLightPicName:nil itemName:@"图片"];
    MoreItem *item6 = [MoreItem moreItemWithPicName:@"sharemore_video" highLightPicName:nil itemName:@"拍照"];
    MoreItem *item7 = [MoreItem moreItemWithPicName:@"sharemore_location" highLightPicName:nil itemName:@"位置"];
    MoreItem *item8 = [MoreItem moreItemWithPicName:@"sharemore_pic" highLightPicName:nil itemName:@"图片"];
    MoreItem *item9 = [MoreItem moreItemWithPicName:@"sharemore_video" highLightPicName:nil itemName:@"拍照"];
    return @[item1, item2, item3, item4, item5, item6, item7, item8, item9];
}
- (NSArray<ChatToolBarItem *> *)chatKeyBoardToolbarItems
{
    ChatToolBarItem *item1 = [ChatToolBarItem barItemWithKind:kBarItemFace normal:@"face" high:@"face_HL" select:@"keyboard"];
    
    ChatToolBarItem *item2 = [ChatToolBarItem barItemWithKind:kBarItemVoice normal:@"voice" high:@"voice_HL" select:@"keyboard"];
    
    ChatToolBarItem *item3 = [ChatToolBarItem barItemWithKind:kBarItemMore normal:@"more_ios" high:@"more_ios_HL" select:nil];
    
    ChatToolBarItem *item4 = [ChatToolBarItem barItemWithKind:kBarItemSwitchBar normal:@"switchDown" high:nil select:nil];
    
    return @[item1, item2, item3, item4];
}

- (NSArray<FaceThemeModel *> *)chatKeyBoardFacePanelSubjectItems
{
    return [FaceSourceManager loadFaceSource];
}


- (void)addSubviews {

    
}

#
@end
