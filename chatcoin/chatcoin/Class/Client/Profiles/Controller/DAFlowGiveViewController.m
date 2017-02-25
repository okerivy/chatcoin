//
//  DAFlowGiveViewController.m
//  chatcoin
//
//  Created by okerivy on 2017/2/25.
//  Copyright © 2017年 okerivy. All rights reserved.
//

#import "DAFlowGiveViewController.h"



@interface DAFlowGiveViewController ()
<UITextFieldDelegate>

/** 上面的余额 view */
@property (nonatomic, strong) UIView *balanceView;
@property (nonatomic, strong) UITextField *balanceTextF;

/** 下面的 view */
@property (nonatomic, strong) UIView *bigView;
/** 二维码 btn */
@property (nonatomic, strong) UIButton *qcodeBtn;
/** 联系人 btn */
@property (nonatomic, strong) UIButton *peopleBtn;


/** 金额 view */
@property (nonatomic, strong) UITextField *moneyTextF;

/** 密码 view */
@property (nonatomic, strong) UITextField *passTextF;

/** 确认转账 btn */
@property (nonatomic, strong) UIButton *sureBtn;

@end

@implementation DAFlowGiveViewController

#pragma mark- Static变量
#define ViewHeight 52.0
#define myDotNumbers     @"0123456789.\n"
#define myNumbers          @"0123456789\n"

#pragma mark- 系统方法

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"捐赠";
    [self initView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark- 初始化方法

- (void)initView
{
    self.view.backgroundColor = kLLBackgroundColor_Default;
    
    [self balanceViewInit];
    [self bigViewInit];
    [self sureBtnInit];
}

- (void)balanceViewInit
{
    
    
    
    _balanceView = [[UIView alloc] initWithFrame:CGRectMake(0, 15, SCREEN_WIDTH, ViewHeight)];
    _balanceView.backgroundColor = ZKColor_White;
    
    [self.view addSubview:_balanceView];
    
    
    UILabel *accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 42, ViewHeight)];
    accountLabel.text = @"余额";
    accountLabel.font = [UIFont systemFontOfSize:18];
    
    [_balanceView addSubview:accountLabel];
    
    NSString *moneyLabelStr = @"9876";
    UIFont *moneyLabelFont = [UIFont systemFontOfSize:20];
    CGSize moneyLabelSize = [moneyLabelStr sizeWithTextFont:moneyLabelFont];
    UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - moneyLabelSize.width, 0, moneyLabelSize.width +5, ViewHeight)];
    moneyLabel.text = moneyLabelStr;
    moneyLabel.font = moneyLabelFont;
    
    [_balanceView addSubview:moneyLabel];
    
    
    UIImageView *moneyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(moneyLabel.frame)-20, 0, 15, ViewHeight)];
    moneyImageView.contentMode = UIViewContentModeScaleAspectFit;
    moneyImageView.image = [UIImage imageNamed:@"流量币"];
    [_balanceView addSubview:moneyImageView];
    
}

- (void)bigViewInit
{
    CGFloat bigViewY = 10 + ViewHeight + 30;
    
    CGFloat bigViewH = ViewHeight * 2 + 1;
    _bigView = [[UIView alloc] initWithFrame:CGRectMake(0, bigViewY, SCREEN_WIDTH, bigViewH)];
    _bigView.backgroundColor = ZKColor_White;
    
    [self.view addSubview:_bigView];

    UILabel *accountLabel02 = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 42, ViewHeight)];
    accountLabel02.text = @"数量";
    accountLabel02.font = [UIFont systemFontOfSize:18];
    
    [_bigView addSubview:accountLabel02];
    
    CGFloat addrTextFX = accountLabel02.right_LL;

    self.moneyTextF = [self cusTextFiledWithFrame:CGRectMake(addrTextFX, 0, 230, ViewHeight) placeholder:@"最多 1334"];
    self.moneyTextF.keyboardType = UIKeyboardTypeDecimalPad;
    
    [_bigView addSubview:self.moneyTextF];
    
    UIView *line02 = [[UIView alloc] initWithFrame:CGRectMake(10, self.moneyTextF.bottom_LL, SCREEN_WIDTH - 10, 0.5)];
    line02.backgroundColor = ZKColor_VarGray(224);
    [_bigView addSubview:line02];
    
    UILabel *accountLabel03 = [[UILabel alloc] initWithFrame:CGRectMake(15,ViewHeight + 1, 42, ViewHeight)];
    accountLabel03.text = @"密码";
    accountLabel03.font = [UIFont systemFontOfSize:18];
    
    [_bigView addSubview:accountLabel03];
    
    self.passTextF = [self cusTextFiledWithFrame:CGRectMake(addrTextFX, ViewHeight + 1 , 230, ViewHeight) placeholder:@"钱包密码"];
    self.passTextF.secureTextEntry = YES;
    self.passTextF.keyboardType = UIKeyboardTypeAlphabet;
    
    
    [_bigView addSubview:self.passTextF];
    
    
    
}

- (void)sureBtnInit
{
    
    CGFloat sureBtnY = 10 + ViewHeight + 30 + ViewHeight * 2 + 1 + 30;
    
    self.sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, sureBtnY, SCREEN_WIDTH - 20, 45)];
    [self.sureBtn setTitle:@"确认捐赠" forState:UIControlStateNormal];
    self.sureBtn.backgroundColor = ZKColor_Var(79, 150, 150);
    self.sureBtn.clipsToBounds = YES;
    self.sureBtn.layer.cornerRadius = 3;
    self.sureBtn.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.2].CGColor;
    self.sureBtn.layer.borderWidth = 0.5;
    [self.sureBtn addTarget:self action:@selector(sureTransform:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sureBtn];
}

- (UITextField *)cusTextFiledWithFrame:(CGRect)frame placeholder:(NSString *)placeholder
{
    UITextField *textFiled = [[UITextField alloc] initWithFrame:frame];
    textFiled.delegate = self;
    
    textFiled.textAlignment            = NSTextAlignmentLeft;
    textFiled.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textFiled.font = [UIFont systemFontOfSize:15];
    textFiled.placeholder = placeholder;

    return textFiled;
    
}

#pragma mark- set方法



#pragma mark- 监听方法

- (void)sureTransform:(UIButton *)btn
{
    ZLog(@"%@", btn);
}




#pragma mark- 代理方法 Delegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == self.moneyTextF) {
        
        // 判断是否输入内容，或者用户点击的是键盘的删除按钮
        if (![string isEqualToString:@""]) {
            NSCharacterSet *cs;
            // 小数点在字符串中的位置 第一个数字从0位置开始
            
            NSInteger dotLocation = [textField.text rangeOfString:@"."].location;
            
            // 判断字符串中是否有小数点，并且小数点不在第一位
            
            // NSNotFound 表示请求操作的某个内容或者item没有发现，或者不存在
            
            // range.location 表示的是当前输入的内容在整个字符串中的位置，位置编号从0开始
            
            if (dotLocation == NSNotFound && range.location != 0) {
                
                // 取只包含“myDotNumbers”中包含的内容，其余内容都被去掉
                
                /* [NSCharacterSet characterSetWithCharactersInString:myDotNumbers]的作用是去掉"myDotNumbers"中包含的所有内容，只要字符串中有内容与"myDotNumbers"中的部分内容相同都会被舍去在上述方法的末尾加上invertedSet就会使作用颠倒，只取与“myDotNumbers”中内容相同的字符
                 */
                cs = [[NSCharacterSet characterSetWithCharactersInString:myDotNumbers] invertedSet];
                if (range.location >= 9) {
                    NSLog(@"单笔金额不能超过亿位");
                    if ([string isEqualToString:@"."] && range.location == 9) {
                        return YES;
                    }
                    return NO;
                }
            }else {
                
                cs = [[NSCharacterSet characterSetWithCharactersInString:myNumbers] invertedSet];
                
            }
            // 按cs分离出数组,数组按@""分离出字符串
            
            NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
            
            BOOL basicTest = [string isEqualToString:filtered];
            
            if (!basicTest) {
                
                NSLog(@"只能输入数字和小数点");
                
                return NO;
                
            }
            
            if (dotLocation != NSNotFound && range.location > dotLocation + 8) {
                
                NSLog(@"小数点后最多八位");
                
                return NO;
            }
            if (textField.text.length > 17) {
                
                return NO;
                
            }
        }
        return YES;
        
    }else if (textField == self.passTextF) {
        //        NSUInteger lengthOfString = string.length;  //lengthOfString的值始终为1
        //        for (NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++) {
        //            unichar character = [string characterAtIndex:loopIndex]; //将输入的值转化为ASCII值（即内部索引值），可以参考ASCII表
        //            // 48-57;{0,9};65-90;{A..Z};97-122:{a..z}
        //            if (character < 48) return NO; // 48 unichar for 0
        //            if (character > 57 && character < 65) return NO; //
        //            if (character > 90 && character < 97) return NO;
        //            if (character > 122) return NO;
        //
        //        }
        // Check for total length
        NSUInteger proposedNewLength = textField.text.length - range.length + string.length;
        if (proposedNewLength > 16) {
            return NO;//限制长度
        }
        return YES;
        
    }
    return YES;
}

#pragma mark- 其他方法





#pragma mark- 懒加载


@end
