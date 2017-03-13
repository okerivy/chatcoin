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

#import "ChatMessageCell.h"
#import "DAChatMessageRes.h"
#import "DAChatMessageDateCell.h"
//屏幕宽
#define screenW [UIScreen mainScreen].bounds.size.width
//屏幕高
#define screenH [UIScreen mainScreen].bounds.size.height

//聊天界面，需要单独显示消息时间的时间间隔
#define CHAT_CELL_TIME_INTERVEL 90.0


@interface DAChatViewController ()<UITableViewDelegate,UITableViewDataSource,ChatKeyBoardDataSource, ChatKeyBoardDelegate>

/** chatkeyBoard */
@property (nonatomic, strong) ChatKeyBoard *chatKeyBoard;


@property(nonatomic, strong) UITableView *chatList;
// 数据库原始的数据
@property(nonatomic, strong) NSMutableArray<DAChatMessageRes *> *messageBank;

// 添加日期的数据
@property(nonatomic, strong) NSMutableArray<ChatMessageFrame *> *dataSource;

/** <#describe#> */
@property (nonatomic, assign) BOOL keyBoardStatus;


@end

@implementation DAChatViewController {

    UITapGestureRecognizer *tapGesture;

    
}


#pragma mark ==== 懒加载 ===

#pragma mark- Static变量



#pragma mark- 系统方法


- (void)viewDidLoad {
    [super viewDidLoad];
    self.keyBoardStatus = NO;
    self.title = self.conversationModel.userName;
    self.view.backgroundColor = kLLBackgroundColor_lightGray;
    
    [self addSubviews];
    self.messageBank = [NSMutableArray array];

    self.dataSource = [NSMutableArray array];
//    for (int i = 0; i < 40; i++) {
//        
//        [self.dataSource addObject:[NSString stringWithFormat:@"%d",arc4random_uniform(200)]];
//    }

    
    UIButton *btn01 = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 60, 40)];
    btn01.backgroundColor = ZKColor_Random;
    [btn01 setTitle:@"插入" forState:UIControlStateNormal];
    [btn01 addTarget:self action:@selector(insertTable:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn01];
    
    UIButton *btn02 = [[UIButton alloc] initWithFrame:CGRectMake(130, 100, 60, 40)];
    btn02.backgroundColor = ZKColor_Random;
    [btn02 setTitle:@"查询" forState:UIControlStateNormal];
    [btn02 addTarget:self action:@selector(queryTable:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn02];
    
    [self initData];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

}

#pragma mark- 初始化方法

- (void)insertTable:(UIButton *)btn
{
    BOOL isExistsTable = [[DAChatDatabaseManager sharedDAChatDatabaseManager] isExistsTable:self.conversationModel.conversationId];
    if (isExistsTable) {
        ZLog(@"数据库已经存在这张表了,不用再初始化了");
        return;
    }
    
    ZLog(@"没有找到这个表,加载假数据 初始化");
    [[DAChatDatabaseManager sharedDAChatDatabaseManager] insertMessages:self.messageBank toTable:self.conversationModel.conversationId];

}

- (void)queryTable:(UIButton *)btn
{
    // 取出最前面的
    NSArray *messageArray = [[DAChatDatabaseManager sharedDAChatDatabaseManager] loadMoreMessagesFromId:@"1" fromTable:self.conversationModel.conversationId offset:0 limit:10];
    
    ZLog(@"%@", messageArray);
}



- (void)addSubviews
{
    [self.view addSubview:self.chatList];
//    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
//    btn1.frame = CGRectMake(50, 150, 120, 44);
//    [btn1 setTitle:@"上去" forState:UIControlStateNormal];
//    btn1.backgroundColor = [UIColor purpleColor];
//    [btn1 addTarget:self action:@selector(clickBtnUp:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn1];
//    
//    
//    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
//    btn2.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 170, 150, 120, 44);
//    [btn2 setTitle:@"让键盘下去" forState:UIControlStateNormal];
//    btn2.backgroundColor = [UIColor purpleColor];
//    [btn2 addTarget:self action:@selector(clickBtnDown:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn2];
    
    
    
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
    
    BOOL isExistsTable = [[DAChatDatabaseManager sharedDAChatDatabaseManager] isExistsTable:self.conversationModel.conversationId];
    if (isExistsTable) {
        ZLog(@"数据库已经存在这张表了,不用再初始化了,可以从 数据库中取出数据");
        
        // 从数据库中取出数据
        self.messageBank = [[[DAChatDatabaseManager sharedDAChatDatabaseManager] loadMoreMessagesFromId:@"0" fromTable:self.conversationModel.conversationId offset:0 limit:10] mutableCopy];
        
    } else {
         ZLog(@"数据库没有这张表了,证明没有数据, 需要先填充假数据");
        // 从数据库或网络加载 原始的消息数据model
        [self initFillOriginalMessageData];
        
      
        // 写到数据库中
        [[DAChatDatabaseManager sharedDAChatDatabaseManager] insertMessages:self.messageBank toTable:self.conversationModel.conversationId];
        
    }

    

    
    // 把原始的消息数据model 转成 frame model
    [self transToMessageFrameData];
 
    [self.chatList reloadData];
    [self scrollTableToFoot:YES];
}

- (void)initFillOriginalMessageData {
    
    
    for (int i = 0; i<20; i++) {
        if (i %3 == 0) {
            DAChatMessageRes *message = [[DAChatMessageRes alloc]init];
            //          mes  NSString *Lmessage = @"在村里，Lz辈分比较大，在我还是小屁孩的时候就有大人喊我叔了，这不算糗[委屈]。 成年之后，鼓起勇气向村花二丫深情表白了(当然是没有血缘关系的)[害羞]，结果她一脸淡定的回绝了:“二叔！别闹……”[尴尬]";
            NSString *Lmessage = @"在村里，Lz辈分比较大，在我还是小屁孩的时候就有大人喊我叔了，这不算糗。 成年之后，鼓起勇气向村花二丫深情表白了(当然是没有血缘关系的)，结果她一脸淡定的回绝了:“二叔！别闹……”";
            message.messageContent = [NSString stringWithFormat:@"%@   %zd",Lmessage,i];
            message.timestamp = 1486893134.0 + i * 60;
            message.messageBodyType = DAMessageContentTypeText;
            message.conversationId = self.conversationModel.conversationId;
            message.fromId = self.conversationModel.messageUserId;
            message.loginId = myUserId;
            message.messageId = [NSString stringWithFormat:@"%zd", arc4random() / 10000 + 1000];

            message.senderUserIconName = self.conversationModel.iconName;
            message.senderUserName = self.conversationModel.userName;
            
 
            [self.messageBank addObject:message];
            
        } else if (i %3 == 1) {
            DAChatMessageRes *message = [[DAChatMessageRes alloc]init];
            NSString *Lmessage = @"这是我的消息，这是我的消息。这是我的消息，这是我的消息。这是我的消息，这是我的消息。这是我的消息，这是我的消息。这是我的消息，这是我的消息。这是我的消息，这是我的消息。这是我的消息，这是我的消息。";
            message.messageContent = [NSString stringWithFormat:@"%@   %zd",Lmessage,i];
            message.timestamp = 1486893134.0 + i * 70;
            message.messageBodyType = DAMessageContentTypeText;
            message.conversationId = self.conversationModel.conversationId;
            message.fromId = myUserId;
            message.loginId = myUserId;
            message.messageId = [NSString stringWithFormat:@"%zd", arc4random() / 10000 + 1000];

            message.senderUserIconName = myUserIconName;
            message.senderUserName = myUserName;
            
            
            [self.messageBank addObject:message];
            
        }else if (i %3 == 2) {
            DAChatMessageRes *message = [[DAChatMessageRes alloc]init];
            NSString *Lmessage = @"这是我的消息";
            message.messageContent = [NSString stringWithFormat:@"%@   %zd",Lmessage,i];
            message.timestamp = 1486893134.0 + i * 80;
            message.messageBodyType = DAMessageContentTypeText;
            message.conversationId = self.conversationModel.conversationId;
            message.fromId = myUserId;
            message.loginId = myUserId;
            message.messageId = [NSString stringWithFormat:@"%zd", arc4random() / 10000 + 1000];
            
            message.senderUserIconName = myUserIconName;
            message.senderUserName = myUserName;

            [self.messageBank addObject:message];
            
        }
    }
    
    
    
}


- (void)transToMessageFrameData {
    
    
    // 按照聊天记录 添加日期模型
    for (NSInteger i = 0, count = self.messageBank.count; i < count; i++) {
        // 从消息模型数组中取出数据
        DAChatMessageRes *messageModel = self.messageBank[i];
        
        // fram模型数组中 最后一个元素
        DAChatMessageRes *lastMessage = [self.dataSource lastObject].message;
        
        // 先添加日期模型
        if (messageModel.timestamp - lastMessage.timestamp > CHAT_CELL_TIME_INTERVEL) {
            
            ChatMessageFrame *dateCellFrame = [[ChatMessageFrame alloc]init];
            DAChatMessageRes *dateModel = [[DAChatMessageRes alloc] init];
            
            dateModel.messageBodyType = DAMessageContentTypeDateTime;
            dateModel.timestamp = messageModel.timestamp;
            dateCellFrame.message = dateModel;
            
            [self.dataSource addObject:dateCellFrame];
        }
        
        // 再添加消息模型
        ChatMessageFrame *messageCellFrame = [[ChatMessageFrame alloc]init];
        
        // 由于数据库没有存储头像和昵称,所以需要手动添加上
        if (messageModel.userType == DAMessageUserTypeOther) {
            messageModel.senderUserIconName = self.conversationModel.iconName;
            messageModel.senderUserName = self.conversationModel.userName;
        } else {
            messageModel.senderUserIconName = myUserIconName;
            messageModel.senderUserName = myUserName;
        }

        messageCellFrame.message = messageModel;
        [self.dataSource addObject:messageCellFrame];
    }
    
    // 清空 消息数组,方便加载下次的消息
    [self.messageBank removeAllObjects];
    
}


#pragma mark- set方法



#pragma mark- 监听方法
//重设tabbleview的frame并根据是否在底部来执行滚动到底部的动画（不在底部就不执行，在底部才执行）
- (void)updateChatList:(LLKeyboardShowHideInfo)keyboardInfo {

    
    CGFloat offSetY = self.chatList.contentSize.height - self.chatList.height_LL;
    

    
    BOOL needScrollToBottom = YES;
    switch (keyboardInfo.KeyboardChangeType) {
        case LLKeyboardChangeTypeShow:
            needScrollToBottom = YES;
            self.keyBoardStatus = YES;
            break;
        case LLKeyboardChangeTypeHidden:
            needScrollToBottom = NO;
            self.keyBoardStatus = NO;
            break;
        case LLKeyboardChangeTypeSwitch:
            needScrollToBottom = YES;
            self.keyBoardStatus = YES;
            break;
            
        default:
            break;
    }
    

    
    [UIView animateWithDuration:ZKKeyboardTime animations:^{
//        self.chatList.contentInset = UIEdgeInsetsMake(0, 0,SCREEN_HEIGHT- self.chatKeyBoard.top_LL - kChatToolBarHeight - ZKNavH, 0);
        self.chatList.contentInset = UIEdgeInsetsMake(0, 0,SCREEN_HEIGHT- self.chatKeyBoard.top_LL - kChatToolBarHeight - ZKNavH, 0);

        //FIXME:试图解决 增加一条消息后,键盘下落 cell yylable 闪烁的问题,发现并没有什么卵用.
//        self.chatList.contentInset = UIEdgeInsetsMake(-(SCREEN_HEIGHT- self.chatKeyBoard.top_LL - kChatToolBarHeight - ZKNavH), 0,SCREEN_HEIGHT- self.chatKeyBoard.top_LL - kChatToolBarHeight - ZKNavH, 0);

        self.chatList.scrollIndicatorInsets = self.chatList.contentInset;
        
    } completion:^(BOOL finished) {
//        if (self.keyBoardStatus) {
//            ZLog(@"键盘已经显示");
//            self.chatList.scrollEnabled = NO;
//        } else {
//            ZLog(@"键盘已经隐藏");
//            self.chatList.scrollEnabled = YES;
//        }
        
        
    }];
    
    if (needScrollToBottom) {
        [self scrollTableToFoot:YES];
//        ZLog(@"@@@@@@@@@@@--允许滚动到底部");
    }
    

}

- (void)tapHandler:(UITapGestureRecognizer *)tap {
    [self.chatKeyBoard keyboardDown];
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

- (void)keyBoardChanged:(LLKeyboardShowHideInfo)keyboardInfo {
    
    
    [self updateChatList:keyboardInfo];
}



#pragma mark -- 发送文本
- (void)chatKeyBoardSendText:(NSString *)text
{
    NSString *string = [self isBlankString:text];
    if (!string) return;
    [self sendTextMessage:string];
}


//判断字符串是否为空字符的方法
- (NSString *) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return nil;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return nil;
    }
    NSString *str = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([str length]!=0) {
        return str;
    }
    return nil;
}


- (void)sendTextMessage:(NSString *)text
{
    
    
    DAChatMessageRes *message = [[DAChatMessageRes alloc]init];
    message.messageContent = [NSString stringWithFormat:@"%@   %zd",text,self.dataSource.count];
    message.timestamp = [NSDate date].timeIntervalSince1970;
    message.messageBodyType = DAMessageContentTypeText;
    message.conversationId = self.conversationModel.conversationId;
    message.fromId = myUserId;
    message.loginId = myUserId;

    message.messageId = [NSString stringWithFormat:@"%zd", arc4random() / 10000 + 1000];
    
    [self.messageBank addObject:message];
    
    // 写入数据库
    [[DAChatDatabaseManager sharedDAChatDatabaseManager] insertMessages:self.messageBank toTable:self.conversationModel.conversationId];
    
    
    // 按照聊天记录 添加日期模型
    [self transToMessageFrameData];
    

    [self addTableRowWithModel:[self.dataSource lastObject] withRowAnimation:UITableViewRowAnimationNone];
    [self scrollTableToFoot:YES];

}


- (void)addTableRowWithModel:(ChatMessageFrame *)model withRowAnimation:(UITableViewRowAnimation)animation {
    NSInteger index = [self.dataSource indexOfObject:model];
    NSMutableArray<NSIndexPath *> *deleteIndexPaths = [NSMutableArray array];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [deleteIndexPaths addObject:indexPath];
    
    if (self.dataSource[index-1].message.messageBodyType == DAMessageContentTypeDateTime) {
        [deleteIndexPaths addObject:[NSIndexPath indexPathForRow:index-1 inSection:0]];
    }
    [self.chatList beginUpdates];
    [self.chatList insertRowsAtIndexPaths:deleteIndexPaths withRowAnimation:animation];
    [self.chatList endUpdates];

    WEAK_SELF;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf loadMoreMessagesAfterDeletionIfNeeded];
    });
}



#pragma mark ==== tabbleView 代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ZLog(@"%zd", self.dataSource.count);
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatMessageFrame *cellFrame = [self.dataSource objectAtIndex:indexPath.row];
    DAChatMessageRes *cellModel = cellFrame.message;
    
    UITableViewCell *_cell;

    
    switch (cellModel.messageBodyType) {
        case DAMessageContentTypeText: {
            ChatMessageCell *cell = [ChatMessageCell cellWithTableView:tableView];
            cell.MessageFrame = cellFrame;
            
            __weak typeof (self) weakSelf = self;
            [cell setDeleteMessage:^(ChatMessageFrame *MessageFrame) {
//                NSUInteger index = [self.dataSource indexOfObject:MessageFrame];
//                [weakSelf.dataSource removeObject:MessageFrame];
//                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
//                [weakSelf.chatList deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                [weakSelf deleteTableRowWithModel:MessageFrame withRowAnimation:UITableViewRowAnimationFade];
            }];

            _cell = cell;
            break;
        }
        case DAMessageContentTypeDateTime: {
            DAChatMessageDateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DAChatMessageDateCell"];
            if (!cell) {
                cell = [[DAChatMessageDateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DAChatMessageDateCell"];
            }
            cell.MessageFrame = cellFrame;

            
//            [messageModel setNeedsUpdateForReuse];
            _cell = cell;
            break;
        }
        default:
            break;
    }
    // 取消 cell 的选中效果
    _cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return _cell;

//    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
//    cell.textLabel.text= self.dataSource[indexPath.row];
//    cell.detailTextLabel.text=[NSString stringWithFormat:@"detale --%d",arc4random_uniform(10)];
//    cell.backgroundColor = kLLBackgroundColor_lightGray;
//    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ChatMessageFrame *cellFrame = [self.dataSource objectAtIndex:indexPath.row];
    return cellFrame.cellHeight;
//    return 40.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


- (void)deleteTableRowWithModel:(ChatMessageFrame *)model withRowAnimation:(UITableViewRowAnimation)animation {
    
    // 先从数据库中删除 
    if (![[DAChatDatabaseManager sharedDAChatDatabaseManager] deleteMessageFromId:model.message.messageId  fromTable:self.conversationModel.conversationId]) return;
    
    NSInteger index = [self.dataSource indexOfObject:model];
    NSMutableArray<NSIndexPath *> *deleteIndexPaths = [NSMutableArray array];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.dataSource removeObjectAtIndex:index];
    [deleteIndexPaths addObject:indexPath];
    
    if (self.dataSource[index-1].message.messageBodyType == DAMessageContentTypeDateTime &&
        ((index == self.dataSource.count) || (self.dataSource[index].message.messageBodyType == DAMessageContentTypeDateTime))) {
        [self.dataSource removeObjectAtIndex:index - 1];
        [deleteIndexPaths addObject:[NSIndexPath indexPathForRow:index-1 inSection:0]];
    }
    
    [self.chatList deleteRowsAtIndexPaths:deleteIndexPaths withRowAnimation:animation];
    WEAK_SELF;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf loadMoreMessagesAfterDeletionIfNeeded];
    });
}

- (void)loadMoreMessagesAfterDeletionIfNeeded {
//    if (self.chatList.tableHeaderView && !isLoading &&!isPulling && self.tableView.contentOffset.y <= 20 - self.tableView.contentInset.top) {
//        UIActivityIndicatorView *indicator = self.refreshView.subviews[0];
//        if (![indicator isAnimating]) {
//            [indicator startAnimating];
//        }
//        [self pullToRefresh];
//    }
}



// 隐藏键盘
- (void)scrollViewWillBeginDragging:(UITableView *)scrollView
{
    [self.chatKeyBoard keyboardDown];
}

#pragma mark- 其他方法





#pragma mark- 懒加载


- (UITableView *)chatList {
    
    if (!_chatList) {
        _chatList = [[UITableView alloc]init];
        _chatList.frame = CGRectMake(0, 0, screenW, screenH - kChatToolBarHeight - 64);
        _chatList.backgroundColor = kLLBackgroundColor_lightGray;
        _chatList.tableFooterView = [[UIView alloc]init];
        _chatList.delegate = self;
        _chatList.dataSource = self;
        _chatList.separatorStyle = UITableViewCellSeparatorStyleNone;

        tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];
        tapGesture.cancelsTouchesInView = NO;
        tapGesture.cancelsTouchesInView = NO;
        tapGesture.numberOfTapsRequired = 1;
        tapGesture.numberOfTouchesRequired = 1;
        [_chatList addGestureRecognizer:tapGesture];
        
        _chatList.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;

        

    }
    return _chatList;
}


@end
