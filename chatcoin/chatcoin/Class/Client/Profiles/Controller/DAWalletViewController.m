//
//  DAWalletViewController.m
//  chatcoin
//
//  Created by okerivy on 2017/2/20.
//  Copyright © 2017年 okerivy. All rights reserved.
//

#import "DAWalletViewController.h"

#import "DANavigationController.h"
#import "LYSideslipCell.h"
#import "DAChatViewController.h"
#import "UIKit+LLExt.h"
#import "DATableView.h"

#import "DAWalletCell.h"

#import "DSAlert.h"


#define kIcon @"kIcon"
#define kName @"kName"
#define kTime @"kTime"
#define kMessage @"kMessage"


//navigationBar右侧按钮距离屏幕边缘的距离
#define NAVIGATION_BAR_RIGHT_MARGIN 5

#define NAVIGATION_BAR_HEIGHT 64

#define MAIN_BOTTOM_TABBAR_HEIGHT 50

#define TABLE_VIEW_CELL_DEFAULT_FONT_SIZE 17

#define TABLE_VIEW_CELL_LEFT_MARGIN 20

#define TABLE_VIEW_CELL_DEFAULT_HEIGHT 44

#define FOOTER_LABEL_FONT_SIZE 14


@interface DAWalletViewController ()
<LYSideslipCellDelegate,
UITableViewDelegate,
UITableViewDataSource,
UINavigationControllerDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) DATableView *tableView;
@property (nonatomic, strong) DSAlert        *alertView4;
@property (nonatomic, strong) DSAlert        *alertView5;


@property (nonatomic, strong) UIView         *viewPwdBgView;
@property (nonatomic, strong) UITextField    *pwdTextField;


@end

@implementation DAWalletViewController



#pragma mark- Static变量



#pragma mark- 系统方法


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账号";
    _dataArray = [NSMutableArray array];
    [self initData];
    
    self.view.backgroundColor = kLLBackgroundColor_Default;
    self.tableView = [[DATableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    self.tableView.backgroundColor = kLLBackgroundColor_Default;
    
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 8, 0, 0);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 200;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
   
    
    
}



#pragma mark- 初始化方法


- (void)initData
{
    for (int i = 0; i<6; i++) {
        [self.dataArray addObject:[NSString stringWithFormat:@"测试--%zd",i]];
    }
    
    
}


#pragma mark- set方法



#pragma mark- 监听方法


- (void)deleteAcount
{
    if (self.dataArray.count > 0) {
        [self.dataArray removeLastObject];
        [self.tableView reloadData];
    }
    
}

- (void)copyAcount
{
    
}

#pragma mark- 代理方法 Delegate



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

// 第一组没有索引
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return 1;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"聊天币";
    }
    return @"流量币";
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 30;
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = ZKColor_Clear;
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.contentView.backgroundColor= kLLBackgroundColor_Default;
    header.textLabel.textAlignment=NSTextAlignmentLeft;
    header.textLabel.font=[UIFont systemFontOfSize:12];
    if (section == 0) {
        [header.textLabel setTextColor:ZKColor_Var(116, 151, 241)];
    }else {
        [header.textLabel setTextColor:ZKColor_Var(148, 142, 157)];

    }
    
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DAWalletCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(DAWalletCell.class)];
    if (!cell) {
        cell = [[DAWalletCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(DAWalletCell.class)];
        cell.delegate = self;
    }
    // 取消 cell 的选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self alert5];
    return;
}




#pragma mark - LYSideslipCellDelegate
- (void)sideslipCell:(LYSideslipCell *)sideslipCell rowAtIndexPath:(NSIndexPath *)indexPath didSelectedAtIndex:(NSInteger)index {
    NSLog(@"选中了: %ld", index);
}

- (BOOL)sideslipCell:(LYSideslipCell *)sideslipCell canSideslipRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
    
    if (indexPath.row == 4) {
        return NO;
    }
    return YES;
}


#pragma mark- 其他方法




- (void)alert5
{
    /*! 5、完全自定义alert */
    [self setViewPwdBgView];
    
    DSWeak;
    [DSAlert ds_showCustomView:self.viewPwdBgView configuration:^(DSAlert *tempView) {
        //        tempView.isTouchEdgeHide = YES;
        tempView.animatingStyle = DSAlertAnimatingStyleScale;
        weakSelf.alertView5 = tempView;
    }];
    
    
}


- (void)setViewPwdBgView
{
    //    if (!_viewPwdBgView)
    //    {
    _viewPwdBgView                         = [UIView new];
    _viewPwdBgView.frame                   = CGRectMake(30, 100, SCREENWIDTH - 60, 280);
    
    _viewPwdBgView.backgroundColor         = [UIColor whiteColor];
    _viewPwdBgView.layer.masksToBounds     = YES;
    _viewPwdBgView.layer.cornerRadius      = 10.0f;
    
    CGFloat buttonWith                     = (SCREENWIDTH - 60)/2 - 0.5;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 76, 76)];
    imageView.centerX_LL = _viewPwdBgView.frame.size.width/2.0;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.image = [UIImage imageNamed:@"dailog密码_icon"];
    [_viewPwdBgView addSubview:imageView];
    
    UILabel *tipLable1 = [UILabel new];
    tipLable1.frame  = CGRectMake(0, CGRectGetMaxY(imageView.frame)+10, _viewPwdBgView.frame.size.width, 20);
    tipLable1.text = @"提示密码非常重要";
    tipLable1.textColor = [UIColor redColor];
    
    tipLable1.textAlignment = NSTextAlignmentCenter;
    tipLable1.font = [UIFont systemFontOfSize:14];
    tipLable1.backgroundColor = [UIColor clearColor];
    [_viewPwdBgView addSubview:tipLable1];
    
    
    UILabel *tipLable2 = [UILabel new];
    tipLable2.frame  = CGRectMake(0, CGRectGetMaxY(tipLable1.frame)+3, _viewPwdBgView.frame.size.width, 20);
    tipLable2.text = @"如果密码丢失或忘记, 钱包的币也会丢失";
    tipLable2.textColor = [UIColor blackColor];
    tipLable2.textAlignment = NSTextAlignmentCenter;
    tipLable2.font = [UIFont systemFontOfSize:14];
    tipLable2.backgroundColor = [UIColor clearColor];
    [_viewPwdBgView addSubview:tipLable2];
    
    
    
    _pwdTextField                          = [UITextField new];
    _pwdTextField.frame                    = CGRectMake(40, CGRectGetMaxY(tipLable2.frame)+ 15, _viewPwdBgView.frame.size.width - 80, 50);
    //    _pwdTextField.borderStyle              = UITextBorderStyleRoundedRect;
    _pwdTextField.secureTextEntry          = YES;
    _pwdTextField.textAlignment            = NSTextAlignmentCenter;
    _pwdTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _pwdTextField.font = [UIFont systemFontOfSize:18];
    _pwdTextField.backgroundColor = ZKColor_Var(237, 237, 244);
    _pwdTextField.placeholder = @"密码设置最少为六位";
    
    _pwdTextField.clipsToBounds = YES;
    _pwdTextField.layer.cornerRadius = 20;
    _pwdTextField.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.2].CGColor;
    _pwdTextField.layer.borderWidth = 0.5;
    
    [_pwdTextField becomeFirstResponder];
    [_viewPwdBgView addSubview:_pwdTextField];
    
    
    UIView *lineView2                      = [UIView new];
    lineView2.frame                        = CGRectMake(0, _viewPwdBgView.frame.size.height - 51, _viewPwdBgView.frame.size.width, 0.5);
    lineView2.backgroundColor              = [UIColor lightGrayColor];
    
    UIButton *sureButton                 = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView2.frame), buttonWith, 50)];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton setBackgroundColor:[UIColor clearColor]];
    [sureButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(cancleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineView3                      = [UIView new];
    lineView3.frame                        = CGRectMake(buttonWith, CGRectGetMinY(sureButton.frame), 0.5, 50);
    lineView3.backgroundColor              = [UIColor lightGrayColor];
    
    UIButton *cancleButton                   = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lineView3.frame), CGRectGetMinY(sureButton.frame), buttonWith, 50)];
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton setBackgroundColor:[UIColor clearColor]];
    [cancleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancleButton addTarget:self action:@selector(cancleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    cancleButton.tag                       = 1;
    sureButton.tag                         = 2;
    
    
    [_viewPwdBgView addSubview:_pwdTextField];
    [_viewPwdBgView addSubview:lineView2];
    [_viewPwdBgView addSubview:cancleButton];
    [_viewPwdBgView addSubview:lineView3];
    [_viewPwdBgView addSubview:sureButton];
    
    
}


- (void)cancleButtonAction:(UIButton *)sender
{
    if (sender.tag == 1)
    {
        NSLog(@"点击了取消按钮！");
        /*! 隐藏alert */
        [_alertView5 ds_dismissAlertView];
        [_pwdTextField resignFirstResponder];
    }
    else
    {
        NSLog(@"点击了确定按钮！密码：%@", _pwdTextField.text);
        
        //        WEAKSELF;
        if (_pwdTextField.text.length < 4 || _pwdTextField.text.length > 8 )
        {
            self.pwdTextField.text = @"";
            [DSAlert ds_showAlertWithTitle:@"温馨提示：" message:@"请输入正确的密码！" image:nil buttonTitles:@[@"确定"] buttonTitlesColor:@[[UIColor redColor], [UIColor cyanColor]] configuration:^(DSAlert *tempView) {
                //                weakSelf.alert2 = tempView;
            } actionClick:^(NSInteger index) {
                if (1 == index)
                {
                    return;
                }
            }];
            return;
        }
        /*! 隐藏alert */
        [_alertView5 ds_dismissAlertView];
        [_pwdTextField resignFirstResponder];
    }
}


#pragma mark- 懒加载



@end
