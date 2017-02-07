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

//屏幕宽
#define screenW [UIScreen mainScreen].bounds.size.width
//屏幕高
#define screenH [UIScreen mainScreen].bounds.size.height

/*keyBoard*/
//键盘变化时间
static CGFloat const keyBoardTipTime = 0.3;

@interface DAChatViewController ()<UITableViewDelegate,UITableViewDataSource,ChatKeyBoardDataSource, ChatKeyBoardDelegate>

/** chatkeyBoard */
@property (nonatomic, strong) ChatKeyBoard *chatKeyBoard;


@property(nonatomic, strong) UITableView *chatList;

@property(nonatomic, strong) NSMutableArray *dataSource;


@end

@implementation DAChatViewController

#pragma mark ==== 懒加载 ===

#pragma mark- Static变量



#pragma mark- 系统方法


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.conversationModel.userName;
    self.view.backgroundColor = ZKColor_White;
    
    self.navigationController.navigationBar.translucent = NO;
    
    
    [self addSubviews];
    self.dataSource = [NSMutableArray array];
    for (int i = 0; i < 40; i++) {
        
        [self.dataSource addObject:[NSString stringWithFormat:@"%d",arc4random_uniform(200)]];
    }


    [self initData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = YES;
}

#pragma mark- 初始化方法



- (void)addSubviews
{
    [self.view addSubview:self.chatList];
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn1.frame = CGRectMake(50, 150, 120, 44);
    [btn1 setTitle:@"上去" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor purpleColor];
    [btn1 addTarget:self action:@selector(clickBtnUp:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    
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
    self.chatKeyBoard.allowSwitchBar = NO;
    self.chatKeyBoard.allowVoice = NO;
    self.chatKeyBoard.allowMore = NO;
    self.chatKeyBoard.allowFace = NO;

    
   

    
}


- (void)initData {
    
//    ChatMessageFrame *cellFrame = [[ChatMessageFrame alloc]init];
//    ChatMessage *message = [[ChatMessage alloc]init];
//    message.userType = userTypeMe;
//    message.userId = 0;
//    NSString *Lmessage = @"在村里，Lz辈分比较大，在我还是小屁孩的时候就有大人喊我叔了，这不算糗[委屈]。 成年之后，鼓起勇气向村花二丫深情表白了(当然是没有血缘关系的)[害羞]，结果她一脸淡定的回绝了:“二叔！别闹……”[尴尬]";
//    message.messageContent = Lmessage;
//    cellFrame.message = message;
//    [self.dataSource addObject:cellFrame];
//    
//    NSMutableArray *messageArray = [LiuqsMessageDataBase queryData:nil];
//    [messageArray enumerateObjectsUsingBlock:^(ChatMessage *message, NSUInteger idx, BOOL * _Nonnull stop) {
//        
//        ChatMessageFrame *cellFrame = [[ChatMessageFrame alloc]init];
//        cellFrame.message = message;
//        [self.dataSource addObject:cellFrame];
//    }];
//    [self.chatList reloadData];
//    [self ScrollTableViewToBottom];
}




#pragma mark- set方法



#pragma mark- 监听方法
//重设tabbleview的frame并根据是否在底部来执行滚动到底部的动画（不在底部就不执行，在底部才执行）
- (void)updateChatList {
    
//    CGFloat offSetY = self.chatList.contentSize.height - self.chatList.height_LL;
//    //判断是否需要滚动到底部，给一个误差值
//    if (self.chatList.contentOffset.y > offSetY - 5 || self.chatList.contentOffset.y > offSetY + 5) {
//        
//        self.chatList.height_LL = self.chatKeyBoard.top_LL;
//        [self scrollTableToFoot:YES];
//    }else {
//        
//        self.chatList.height_LL = self.chatKeyBoard.top_LL;
//        [self scrollTableToFoot:YES];
//
//    }
//    NSLog(@"%s------%@-----%@-----%@", __func__,NSStringFromCGRect(self.chatKeyBoard.chatToolBar.frame),NSStringFromCGRect(self.chatKeyBoard.frame),NSStringFromCGRect(self.chatList.frame));
    
    
    //return;
    CGFloat offSetY = self.chatList.contentSize.height - self.chatList.height_LL;
    //判断是否需要滚动到底部，给一个误差值
    if (self.chatList.contentOffset.y > offSetY - 5 || self.chatList.contentOffset.y > offSetY + 5) {
        
        //        self.chatList.height_LL = self.chatKeyBoard.top_LL;
        
        [UIView animateWithDuration:ZKKeyboardTime
                              delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState |
         UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             NSLog(@"%@",NSStringFromUIEdgeInsets(self.chatList.contentInset));
                             
                             self.chatList.contentInset = UIEdgeInsetsMake(0, 0,SCREENH_HEIGHT- self.chatKeyBoard.top_LL - kChatToolBarHeight - 64, 0);
                             NSLog(@"%@",NSStringFromUIEdgeInsets(self.chatList.contentInset));
                             
                             self.chatList.scrollIndicatorInsets = self.chatList.contentInset;
                             
                             
                         } completion:^(BOOL finished) {
                             
                         }];
        
        
        [self scrollTableToFoot:YES];
    }else {
        
        //        self.chatList.height_LL = self.chatKeyBoard.top_LL;
        [UIView animateWithDuration:ZKKeyboardTime
                              delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState |
         UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             NSLog(@"%@",NSStringFromUIEdgeInsets(self.chatList.contentInset));
                             
                             self.chatList.contentInset = UIEdgeInsetsMake(0, 0,SCREENH_HEIGHT- self.chatKeyBoard.top_LL - kChatToolBarHeight - 64, 0);
                             NSLog(@"%@",NSStringFromUIEdgeInsets(self.chatList.contentInset));
                             
                             self.chatList.scrollIndicatorInsets = self.chatList.contentInset;
                             
                         } completion:^(BOOL finished) {
                             
                         }];
        
        [self scrollTableToFoot:YES];
        
    }
    //    ZLog(@"%@-----%@-----%@", NSStringFromCGRect(self.chatKeyBoard.chatToolBar.frame),NSStringFromCGRect(self.chatKeyBoard.frame),NSStringFromCGRect(self.chatList.frame));
    

}

- (void)listTap {
    
//    [self.keyboard hideKeyBoard];
//    UIMenuController *menuController = [UIMenuController sharedMenuController];
//    if (menuController.menuVisible) {
//        [menuController setMenuVisible:NO animated:YES];
//    }
}

- (void)clickBtnUp:(UIButton *)btn
{
    [self.chatKeyBoard keyboardUp];
}

- (void)clickBtnDown:(UIButton *)btn
{
    [self.chatKeyBoard keyboardDown];
}



#pragma mark  - 滑到最底部
- (void)scrollTableToFoot:(BOOL)animated
{

    ZLog(@"%@",@"测试");
    
    
    NSInteger s = [self.chatList numberOfSections];  //有多少组
    if (s<1) return;  //无数据时不执行 要不会crash
    NSInteger r = [self.chatList numberOfRowsInSection:s-1]; //最后一组有多少行
    if (r<1) return;
    NSIndexPath *ip = [NSIndexPath indexPathForRow:r-1 inSection:s-1];  //取最后一行数据
    [self.chatList scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:animated]; //滚动到最后一行
}

#pragma mark- 代理方法 Delegate



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

- (void)keyBoardChanged {
    
//    [UIView animateWithDuration:keyBoardTipTime animations:^{
    
        [self updateChatList];
//    }];
}



#pragma mark ==== tabbleView 代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.textLabel.text= self.dataSource[indexPath.row];
    cell.detailTextLabel.text=[NSString stringWithFormat:@"detale --%d",arc4random_uniform(10)];
    cell.backgroundColor = ZKColor_Red;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 40.0;
}


#pragma mark- 其他方法





#pragma mark- 懒加载


- (UITableView *)chatList {
    
    if (!_chatList) {
        _chatList = [[UITableView alloc]init];
        _chatList.frame = CGRectMake(0, 0, screenW, screenH - kChatToolBarHeight - 64);
        _chatList.backgroundColor = [UIColor greenColor];
        _chatList.tableFooterView = [[UIView alloc]init];
        _chatList.delegate = self;
        _chatList.dataSource = self;
        _chatList.separatorStyle = UITableViewCellSeparatorStyleNone;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(listTap)];
        [_chatList addGestureRecognizer:tap];
    }
    return _chatList;
}


#
@end
