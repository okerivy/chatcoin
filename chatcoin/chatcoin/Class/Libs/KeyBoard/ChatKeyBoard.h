//
//  ChatKeyBoard.h
//  FaceKeyboard
//
//  Company：     SunEee
//  Blog:        devcai.com
//  Communicate: 2581502433@qq.com

//  Created by ruofei on 16/3/29.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ChatKeyBoardMacroDefine.h"

#import "ChatToolBar.h"
#import "FacePanel.h"
#import "MorePanel.h"

#import "MoreItem.h"
#import "ChatToolBarItem.h"
#import "FaceThemeModel.h"

typedef NS_ENUM(NSInteger, LLKeyboardType) {
    kLLKeyboardTypeDefault = 0, //系统默认键盘
    kLLKeyboardTypeEmotion,     //表情输入键盘
    kLLKeyboardTypePanel,       //提供照片、视频等功能的Panel
    kLLKeyboardTypeRecord,      //按住说话
    kLLKeyboardTypeNone         //当前没有显示键盘
};

typedef NS_ENUM(NSInteger, LLKeyboardChangeType) {
    LLKeyboardChangeTypeShow = 0, //系统默认键盘
    LLKeyboardChangeTypeHidden,     //表情输入键盘
    LLKeyboardChangeTypeSwitch      //提供照片、视频等功能的Panel
};

struct LLKeyboardShowHideInfo {
    LLKeyboardChangeType KeyboardChangeType; // 键盘切换类型
    NSInteger keyboardHeight;        //键盘高度
    //    LLKeyboardType fromKeyboardType;  //当前显示的键盘类型
    LLKeyboardType toKeyboardType;    //需要显示/隐藏的键盘类型
    //    BOOL animated;              //是否需要动画效果
    UIViewAnimationOptions curve;
    CGFloat duration;
};

typedef struct LLKeyboardShowHideInfo LLKeyboardShowHideInfo;


typedef NS_ENUM(NSInteger, KeyBoardStyle)
{
    KeyBoardStyleChat = 0,
    KeyBoardStyleComment
};

@class ChatKeyBoard;
@protocol ChatKeyBoardDelegate <NSObject>
@optional

/*
 * 发送按钮的代理事件
 * 参数PlainStr: 转码后的textView的普通字符串
 */
- (void)sendButtonEventsWithPlainString:(NSString *)PlainStr;

/*
 * 代理方法：键盘改变的代理事件
 * 用来更新父视图的UI，比如跟随键盘改变的列表高度
 */
- (void)keyBoardChanged:(LLKeyboardShowHideInfo) keyboardInfo;


/**
 *  语音状态
 */
- (void)chatKeyBoardDidStartRecording:(ChatKeyBoard *)chatKeyBoard;
- (void)chatKeyBoardDidCancelRecording:(ChatKeyBoard *)chatKeyBoard;
- (void)chatKeyBoardDidFinishRecoding:(ChatKeyBoard *)chatKeyBoard;
- (void)chatKeyBoardWillCancelRecoding:(ChatKeyBoard *)chatKeyBoard;
- (void)chatKeyBoardContineRecording:(ChatKeyBoard *)chatKeyBoard;

/**
 *  输入状态
 */
- (void)chatKeyBoardTextViewDidBeginEditing:(UITextView *)textView;
- (void)chatKeyBoardSendText:(NSString *)text;
- (void)chatKeyBoardTextViewDidChange:(UITextView *)textView;

/**
 * 表情
 */
- (void)chatKeyBoardAddFaceSubject:(ChatKeyBoard *)chatKeyBoard;
- (void)chatKeyBoardSetFaceSubject:(ChatKeyBoard *)chatKeyBoard;

/**
 *  更多功能
 */
- (void)chatKeyBoard:(ChatKeyBoard *)chatKeyBoard didSelectMorePanelItemIndex:(NSInteger)index;

@end

/**
 *  数据源
 */
@protocol ChatKeyBoardDataSource <NSObject>

@required
- (NSArray<MoreItem *> *)chatKeyBoardMorePanelItems;
- (NSArray<ChatToolBarItem *> *)chatKeyBoardToolbarItems;
- (NSArray<FaceThemeModel *> *)chatKeyBoardFacePanelSubjectItems;
@end

@interface ChatKeyBoard : UIView

/**
 *  默认是导航栏透明，或者没有导航栏
 */
+ (instancetype)keyBoard;

/**
 *  当导航栏不透明时（强制要导航栏不透明）
 *
 *  @param translucent 是否透明
 *
 *  @return keyboard对象
 */
+ (instancetype)keyBoardWithNavgationBarTranslucent:(BOOL)translucent;


/**
 *  直接传入父视图的bounds过来
 *
 *  @param bounds 父视图的bounds，一般为控制器的view
 *
 *  @return keyboard对象
 */
+ (instancetype)keyBoardWithParentViewBounds:(CGRect)bounds;

/**
 *
 *  设置关联的表
 */
@property (nonatomic, weak) UITableView *associateTableView;


@property (nonatomic, weak) id<ChatKeyBoardDataSource> dataSource;
@property (nonatomic, weak) id<ChatKeyBoardDelegate> delegate;

@property (nonatomic, readonly, strong) ChatToolBar *chatToolBar;
@property (nonatomic, readonly, strong) FacePanel *facePanel;
@property (nonatomic, readonly, strong) MorePanel *morePanel;

/**
 *  设置键盘的风格
 *
 *  默认是 KeyBoardStyleChat
 */
@property (nonatomic, assign) KeyBoardStyle keyBoardStyle;

/**
 *  placeHolder内容
 */
@property (nonatomic, copy) NSString * placeHolder;
/**
 *  placeHolder颜色
 */
@property (nonatomic, strong) UIColor *placeHolderColor;

/**
 *  是否开启语音, 默认开启
 */
@property (nonatomic, assign) BOOL allowVoice;
/**
 *  是否开启表情，默认开启
 */
@property (nonatomic, assign) BOOL allowFace;
/**
 *  是否开启更多功能，默认开启
 */
@property (nonatomic, assign) BOOL allowMore;
/**
 *  是否开启切换工具条的功能，默认关闭
 */
@property (nonatomic, assign) BOOL allowSwitchBar;

/**
 *  键盘弹出
 */
- (void)keyboardUp;

/**
 *  键盘收起
 */
- (void)keyboardDown;


/************************************************************************************************
 *  如果设置键盘风格为 KeyBoardStyleComment 则可以使用下面两个方法
 *  开启评论键盘
 */
- (void)keyboardUpforComment;

/**
 *  隐藏评论键盘
 */
- (void)keyboardDownForComment;

@end










