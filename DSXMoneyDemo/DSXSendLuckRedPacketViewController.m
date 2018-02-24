//
//  DSXSendLuckRedPacketViewController.m
//  DSXMoneyDemo
//
//  Created by LQ on 2017/10/27.
//  Copyright © 2017年 ZJ. All rights reserved.
//

#import "DSXSendLuckRedPacketViewController.h"
#import "UIView+Extension.h"
#import "DSXPlaceholderTextView.h"
#import "DSXWalletButton.h"


#define DSXRedPacketRedColor  DSXColor(249,80,67, 1)
@interface DSXSendLuckRedPacketViewController ()<UITextViewDelegate,UITextFieldDelegate>
//金额输入框
@property (nonatomic, strong) UITextField *moneyTextFeild;
//金额左视图
@property (nonatomic, strong) UIButton *leftButton;


//红包个数输入框
@property (nonatomic, strong) UITextField *numberTextFeild;
//社群所有人文字
@property (nonatomic, strong) UILabel *allpeopleLabel;

//随喜赞叹
@property (nonatomic, strong) DSXPlaceholderTextView *textView;
//超出金额提示文字
@property (nonatomic, strong) UILabel *limitTipLabel;
//金额
@property (nonatomic, strong) UILabel *moneyLabel;
//发红包按钮
@property (nonatomic, strong) DSXWalletButton *sendButton;

//设置红包类型
@property (nonatomic, strong) UITextView *changeRedPacktetTypeTextView;

//是否是普通红包  yes是普通红包  no是拼手气红包  默认是拼手气红包
@property (nonatomic, assign) BOOL isNomalRedPacket;
@end

@implementation DSXSendLuckRedPacketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发红包";
    self.view.backgroundColor = DSXColor(241, 241, 241, 1);
    
    [self setUI];
    // Do any additional setup after loading the view.
}
- (void)setUI{
    
    
    CGFloat leftPadding = 15;
    CGFloat topPadding = 25;

    //**********超出金额提示********************/
    
    UIView *tipView = [[UIView alloc] initWithFrame:CGRectMake(leftPadding, 0, SCREEN_WIDTH - leftPadding*2, topPadding)];
    tipView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tipView];
    
    self.limitTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tipView.width, tipView.height)];
    self.limitTipLabel.textColor = DSXRedPacketRedColor;
    self.limitTipLabel.text = @"单个红包金额不可超过80000";
    self.limitTipLabel.font = [UIFont systemFontOfSize:12];
    self.limitTipLabel.textAlignment = NSTextAlignmentCenter;
    self.limitTipLabel.hidden = YES;
    [tipView addSubview:self.limitTipLabel];

    
    //**********金额textFeild********************/
    self.moneyTextFeild = [[UITextField alloc] initWithFrame:CGRectMake(leftPadding, topPadding,SCREEN_WIDTH - leftPadding*2 , 60)];
    [self.moneyTextFeild rounded:5 width:0.5 color:DSXSeparatorColor];
    self.moneyTextFeild.backgroundColor = [UIColor whiteColor];
    self.moneyTextFeild.font = [UIFont systemFontOfSize:17];
    self.moneyTextFeild.textColor = DSXTextColor;
    self.moneyTextFeild.textAlignment = NSTextAlignmentRight;
    self.moneyTextFeild.keyboardType = UIKeyboardTypeDecimalPad;
    self.moneyTextFeild.placeholder = @"0.00";
    self.moneyTextFeild.delegate = self;
    
    [self.moneyTextFeild addTarget:self action:@selector(textFeildDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 90, self.moneyTextFeild.height)];
    self.leftButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.leftButton setTitle:@"总金额" forState:UIControlStateNormal];
    [self.leftButton setTitleColor:DSXTextColor forState:UIControlStateNormal];
    [self.leftButton setImage:[UIImage imageNamed:@"icon_pin_red"] forState:UIControlStateNormal];
    [self.leftButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -5)];
    self.moneyTextFeild.leftView = self.leftButton;
    self.moneyTextFeild.leftViewMode = UITextFieldViewModeAlways;
    
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 35, self.moneyTextFeild.height)];
    rightLabel.font = [UIFont systemFontOfSize:17];
    rightLabel.textColor = DSXTextColor;
    rightLabel.text = @"元";
    rightLabel.textAlignment = NSTextAlignmentCenter;
    self.moneyTextFeild.rightView = rightLabel;
    self.moneyTextFeild.rightViewMode = UITextFieldViewModeAlways;
    
    [self.view addSubview:self.moneyTextFeild];
    
    //**********切换红包类型********************/
    UIView *changeView = [[UIView alloc] initWithFrame:CGRectMake(leftPadding, self.moneyTextFeild.bottom, SCREEN_WIDTH - leftPadding*2, 22)];
    changeView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:changeView];
    
    self.changeRedPacktetTypeTextView = [[UITextView alloc] initWithFrame:CGRectMake(5, 0, changeView.width - 20, 22)];
    self.changeRedPacktetTypeTextView.textColor = DSXTextColor;
    self.changeRedPacktetTypeTextView.attributedText = [self changeLinkClickStr:@"改为普通红包" str:@"当前为拼手气红包，改为普通红包"];
    self.changeRedPacktetTypeTextView.delegate = self;
    self.changeRedPacktetTypeTextView.scrollEnabled = NO;
    self.changeRedPacktetTypeTextView.editable = NO;
    self.changeRedPacktetTypeTextView.backgroundColor = [UIColor clearColor];
    self.changeRedPacktetTypeTextView.linkTextAttributes = @{NSForegroundColorAttributeName:DSXColor(87, 107, 149, 1)};//设置点击链接的颜色
    [changeView addSubview:self.changeRedPacktetTypeTextView];
    
    //**********红包个数textFeild********************/
    self.numberTextFeild = [[UITextField alloc] initWithFrame:CGRectMake(leftPadding, self.moneyTextFeild.bottom + 30,SCREEN_WIDTH - leftPadding*2 , 60)];
    [self.numberTextFeild rounded:5 width:0.5 color:DSXSeparatorColor];
    self.numberTextFeild.backgroundColor = [UIColor whiteColor];
    self.numberTextFeild.font = [UIFont systemFontOfSize:17];
    self.numberTextFeild.textColor = DSXTextColor;
    self.numberTextFeild.textAlignment = NSTextAlignmentRight;
    self.numberTextFeild.keyboardType = UIKeyboardTypeNumberPad;
    self.numberTextFeild.placeholder = @"填写个数";
    self.numberTextFeild.delegate = self;
    
    [self.numberTextFeild addTarget:self action:@selector(textFeildDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, self.numberTextFeild.height)];
    leftLabel.font = [UIFont systemFontOfSize:17];
    leftLabel.textColor = DSXTextColor;
    leftLabel.text = @"红包个数";
    leftLabel.textAlignment = NSTextAlignmentCenter;
    self.numberTextFeild.leftView = leftLabel;
    self.numberTextFeild.leftViewMode = UITextFieldViewModeAlways;
    
    UILabel *numRightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 35, self.moneyTextFeild.height)];
    numRightLabel.font = [UIFont systemFontOfSize:17];
    numRightLabel.textColor = DSXTextColor;
    numRightLabel.text = @"个";
    numRightLabel.textAlignment = NSTextAlignmentCenter;
    self.numberTextFeild.rightView = numRightLabel;
    self.numberTextFeild.rightViewMode = UITextFieldViewModeAlways;
    
    [self.view addSubview:self.numberTextFeild];
    
    //**********社群人数********************/
    
    UIView *numView = [[UIView alloc] initWithFrame:CGRectMake(leftPadding, self.numberTextFeild.bottom, SCREEN_WIDTH - leftPadding*2, 22)];
    numView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:numView];
    
    self.allpeopleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, numView.width - 20, numView.height)];
    self.allpeopleLabel.textColor = DSXColor(155, 155, 155, 1);
    self.allpeopleLabel.text = @"本群共320人";
    self.allpeopleLabel.font = [UIFont systemFontOfSize:12];
    [numView addSubview:self.allpeopleLabel];
    
    
    //**********随喜文案********************/
    
    self.textView = [[DSXPlaceholderTextView alloc] initWithFrame:CGRectMake(self.moneyTextFeild.x, self.numberTextFeild.bottom + 30, self.moneyTextFeild.width, 70)];
    self.textView.textColor = DSXTextColor;
    self.textView.font = [UIFont systemFontOfSize:17];
    self.textView.placeholder = @"随喜赞叹";
    self.textView.delegate = self;
    [self.view addSubview:self.textView];
    
    
    //**********金额展示********************/
    
    self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.moneyTextFeild.x, self.textView.bottom + 20, self.moneyTextFeild.width, 50)];
    self.moneyLabel.textColor = DSXTextColor;
    self.moneyLabel.font = [UIFont boldSystemFontOfSize:50];
    NSString *money = @"￥0.00";
    self.moneyLabel.attributedText = [self changeFont:[UIFont boldSystemFontOfSize:25] str:money];
    self.moneyLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:self.moneyLabel];
    
    
    //**********塞钱按钮********************/
    
    self.sendButton = [[DSXWalletButton alloc] initWithFrame:CGRectMake(45, self.moneyLabel.bottom + 35, SCREEN_WIDTH - 90, 45) Click:^{
        
        
    }];
    self.sendButton.enabled = NO;
    [self.sendButton setTitle:@"塞钱进红包" forState:UIControlStateNormal];
    [self.view addSubview:self.sendButton];
}


#pragma mark - textField和textView的代理方法
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
   
    
    return textView.text.length + (text.length - range.length) <= 30;//限制字数30
}

//处理富文本点击事件
-(BOOL)textView:(UITextView *)textView shouldInteractWithURL:(nonnull NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction{

    if (textView == self.changeRedPacktetTypeTextView) {
        
        if ([[URL scheme] isEqualToString:@"click"]) {
            
            self.isNomalRedPacket = !self.isNomalRedPacket;
            if (self.isNomalRedPacket) {
                //普通红包
                [self.leftButton setTitle:@"单个金额" forState:UIControlStateNormal];
                [self.leftButton setImage:nil forState:UIControlStateNormal];
                [self.leftButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
                self.changeRedPacktetTypeTextView.attributedText = [self changeLinkClickStr:@"改为拼手气红包" str:@"当前为普通红包，改为拼手气红包"];
                
            }else{
            
                [self.leftButton setTitle:@"总金额" forState:UIControlStateNormal];
                [self.leftButton setImage:[UIImage imageNamed:@"icon_pin_red"] forState:UIControlStateNormal];
                [self.leftButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -5)];
                self.changeRedPacktetTypeTextView.attributedText = [self changeLinkClickStr:@"改为普通红包" str:@"当前为拼手气红包，改为普通红包"];
            }
           
        }
    }
    return YES;
}
- (void)textFeildDidChange:(UITextField *)textFeild{
    
    
    if (textFeild == self.moneyTextFeild) {
        
        NSString *money = [NSString stringWithFormat:@"￥%.2f",[textFeild.text floatValue]];
        self.moneyLabel.attributedText = [self changeFont:[UIFont boldSystemFontOfSize:25] str:money];
        if ([textFeild.text floatValue] > 0 && [textFeild.text floatValue] <=800) {
            
//            self.sendButton.enabled = YES;
            self.limitTipLabel.hidden = YES;
            self.moneyTextFeild.textColor = DSXTextColor;
            
            
        }else if([textFeild.text intValue] <= 0){
            
//            self.sendButton.enabled = NO;
            self.limitTipLabel.hidden = YES;
            self.moneyTextFeild.textColor = DSXTextColor;
            
        }else{
            
//            self.sendButton.enabled = NO;
            self.limitTipLabel.hidden = NO;
            self.limitTipLabel.text = @"单个红包金额不可超过80000";
            self.moneyTextFeild.textColor = DSXRedPacketRedColor;
        }

    }else if (textFeild == self.numberTextFeild){
    
    
        if ([self.numberTextFeild.text intValue] > 100) {
            
            self.limitTipLabel.hidden = NO;
            self.limitTipLabel.text = @"一次最多发100个红包";
            self.numberTextFeild.textColor = DSXRedPacketRedColor;
            
            
        }else if ( [self.numberTextFeild.text intValue] == 0 && self.numberTextFeild.text.length > 0){
        
            self.limitTipLabel.hidden = NO;
            self.limitTipLabel.text = @"请选择红包个数";
            self.numberTextFeild.textColor = DSXRedPacketRedColor;
        }else{
        
            self.limitTipLabel.hidden = YES;
            self.numberTextFeild.textColor = DSXTextColor;
        }
    }
    
    
    //设置可点击状态
    if ([self.numberTextFeild.text intValue] >0 && [self.numberTextFeild.text intValue] <= 100 && [textFeild.text floatValue] > 0 && [textFeild.text floatValue] <=800) {
        
        self.sendButton.enabled = YES;
    }else{
    
        self.sendButton.enabled = NO;
    }
    
    //判断  总金额除以红包个数 是否≥0.01元
    
    if ([self.moneyTextFeild.text floatValue] / [self.numberTextFeild.text floatValue] > 0.01) {
        self.sendButton.enabled = YES;
        self.limitTipLabel.hidden = YES;
        self.numberTextFeild.textColor = DSXTextColor;
        self.moneyTextFeild.textColor = DSXTextColor;
    }else{
    
        self.sendButton.enabled = NO;
        self.limitTipLabel.hidden = NO;
        self.limitTipLabel.text = @"单个红包不可低于0.01";
        self.numberTextFeild.textColor = DSXRedPacketRedColor;
        self.moneyTextFeild.textColor = DSXRedPacketRedColor;
    }
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == self.moneyTextFeild) {
        // 当前输入的字符是'.'
        if ([string isEqualToString:@"."]) {
            
            // 已输入的字符串中已经包含了'.'或者""
            if ([textField.text rangeOfString:@"."].location != NSNotFound || [textField.text isEqualToString:@""]) {
                
                return NO;
            } else {
                
                return YES;
            }
        } else {// 当前输入的不是'.'
            
            // 第一个字符是0时, 第二个不能再输入0
            if (textField.text.length == 1) {
                
                unichar str = [textField.text characterAtIndex:0];
                if (str == '0' && [string isEqualToString:@"0"]) {
                    
                    return NO;
                }
                
                if (str != '0' && str != '1') {// 1xx或0xx
                    
                    return YES;
                } else {
                    
                    if (str == '1') {
                        
                        return YES;
                    } else {
                        
                        if ([string isEqualToString:@""]) {
                            
                            return YES;
                        } else {
                            
                            return NO;
                        }
                    }
                    
                    
                }
            }
            
            // 已输入的字符串中包含'.'
            if ([textField.text rangeOfString:@"."].location != NSNotFound) {
                
                NSMutableString *str = [[NSMutableString alloc] initWithString:textField.text];
                [str insertString:string atIndex:range.location];
                
                if (str.length >= [str rangeOfString:@"."].location + 4) {
                    
                    return NO;
                }
                //            DSXLog(@"str.length = %ld, str = %@, string.location = %ld", str.length, string, range.location);
                
                
            } else {
                
                if (textField.text.length > 5) {
                    
                    return range.location < 6;
                }
            }
            
            
        }

    }else if (textField == self.numberTextFeild){
    
    
        return textField.text.length + (string.length - range.length) <= 3;//限制字数30
    }
    
      return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    [self.view endEditing:YES];
}



-(NSMutableAttributedString *)changeFont:(UIFont *)font str:(NSString *)str{
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:str];
    
    [attr addAttribute:NSFontAttributeName value:font range:[str rangeOfString:@"￥"]];
    //向上偏移
    [attr addAttribute:NSBaselineOffsetAttributeName value:@(15) range:[str rangeOfString:@"￥"]];
    return attr;
    
}
//增加点击事件
-(NSMutableAttributedString *)changeLinkClickStr:(NSString *)clickStr str:(NSString *)str{
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:str];
    
    [attr addAttributes:@{NSLinkAttributeName:@"click://"} range:[str rangeOfString:clickStr]];
    
//    [attr addAttribute:NSLinkAttributeName value:@"click://" range:[str rangeOfString:clickStr]];
//    //颜色
//    [attr addAttribute:NSForegroundColorAttributeName value:DSXColor(87, 107, 149, 1) range:[str rangeOfString:clickStr]];
    return attr;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
