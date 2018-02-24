//
//  DSXSendNomalRedpacketViewController.m
//  DSXMoneyDemo
//
//  Created by LQ on 2017/10/26.
//  Copyright © 2017年 ZJ. All rights reserved.
//

#import "DSXSendNomalRedpacketViewController.h"
#import "UIView+Extension.h"
#import "DSXPlaceholderTextView.h"
#import "DSXWalletButton.h"
#import "DSXWalletPayAlertView.h"

#define DSXRedPacketRedColor  DSXColor(249,80,67, 1)
@interface DSXSendNomalRedpacketViewController ()<UITextViewDelegate,UITextFieldDelegate>
//金额输入框
@property (nonatomic, strong) UITextField *moneyTextFeild;
//随喜赞叹
@property (nonatomic, strong) DSXPlaceholderTextView *textView;
//超出金额提示文字
@property (nonatomic, strong) UILabel *limitTipLabel;
//金额
@property (nonatomic, strong) UILabel *moneyLabel;
//发红包按钮
@property (nonatomic, strong) DSXWalletButton *sendButton;
@end

@implementation DSXSendNomalRedpacketViewController

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
    
    //**********金额textFeild********************/
    self.moneyTextFeild = [[UITextField alloc] initWithFrame:CGRectMake(leftPadding, topPadding,SCREEN_WIDTH - leftPadding*2 , 60)];
    [self.moneyTextFeild rounded:5 width:0.5 color:DSXSeparatorColor];
    self.moneyTextFeild.backgroundColor = [UIColor whiteColor];
    self.moneyTextFeild.font = [UIFont systemFontOfSize:17];
    self.moneyTextFeild.textColor = DSXTextColor;
    self.moneyTextFeild.textAlignment = NSTextAlignmentRight;
    self.moneyTextFeild.keyboardType = UIKeyboardTypeDecimalPad;
    self.moneyTextFeild.placeholder = @"请填写金额";
    self.moneyTextFeild.delegate = self;
    
    [self.moneyTextFeild addTarget:self action:@selector(textFeildDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 55, self.moneyTextFeild.height)];
    leftLabel.font = [UIFont systemFontOfSize:17];
    leftLabel.textColor = DSXTextColor;
    leftLabel.text = @"金额";
    leftLabel.textAlignment = NSTextAlignmentCenter;
    self.moneyTextFeild.leftView = leftLabel;
    self.moneyTextFeild.leftViewMode = UITextFieldViewModeAlways;
    
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 35, self.moneyTextFeild.height)];
    rightLabel.font = [UIFont systemFontOfSize:17];
    rightLabel.textColor = DSXTextColor;
    rightLabel.text = @"元";
    rightLabel.textAlignment = NSTextAlignmentCenter;
    self.moneyTextFeild.rightView = rightLabel;
    self.moneyTextFeild.rightViewMode = UITextFieldViewModeAlways;
    
    [self.view addSubview:self.moneyTextFeild];
 
    //**********超出金额提示********************/
    
    UIView *tipView = [[UIView alloc] initWithFrame:CGRectMake(self.moneyTextFeild.x, self.moneyTextFeild.bottom, self.moneyTextFeild.width, 20)];
    tipView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tipView];
    
    self.limitTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tipView.width, tipView.height)];
    self.limitTipLabel.textColor = DSXRedPacketRedColor;
    self.limitTipLabel.text = @"单个红包金额不可超过800";
    self.limitTipLabel.font = [UIFont systemFontOfSize:12];
    self.limitTipLabel.textAlignment = NSTextAlignmentCenter;
    self.limitTipLabel.hidden = YES;
    [tipView addSubview:self.limitTipLabel];
    
     //**********随喜文案********************/
    
    self.textView = [[DSXPlaceholderTextView alloc] initWithFrame:CGRectMake(self.moneyTextFeild.x, tipView.bottom, self.moneyTextFeild.width, 70)];
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

    
    DSXWeakSelf
    self.sendButton = [[DSXWalletButton alloc] initWithFrame:CGRectMake(45, self.moneyLabel.bottom + 35, SCREEN_WIDTH - 90, 45) Click:^{
        
        [weakSelf.view endEditing:YES];
        
        DSXWalletPayAlertView *payAlert = [DSXWalletPayAlertView alert];
        payAlert.payType = DSXWalletPayType_needPassword;
        [payAlert show];
        
    }];
    self.sendButton.enabled = NO;
    [self.sendButton setTitle:@"塞钱进红包" forState:UIControlStateNormal];
    [self.view addSubview:self.sendButton];
}


#pragma mark - textField和textView的代理方法
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{

    return textView.text.length + (text.length - range.length) <= 30;//限制字数30
}
- (void)textFeildDidChange:(UITextField *)textFeild{

    NSString *money = [NSString stringWithFormat:@"￥%.2f",[textFeild.text floatValue]];
    self.moneyLabel.attributedText = [self changeFont:[UIFont boldSystemFontOfSize:25] str:money];
    if ([textFeild.text floatValue] > 0 && [textFeild.text floatValue] <=800) {
        
        self.sendButton.enabled = YES;
        self.limitTipLabel.hidden = YES;
        self.moneyTextFeild.textColor = DSXTextColor;
        
        
    }else if([textFeild.text intValue] <= 0){
    
        self.sendButton.enabled = NO;
        self.limitTipLabel.hidden = YES;
        self.moneyTextFeild.textColor = DSXTextColor;
        
    }else{
    
        self.sendButton.enabled = NO;
        self.limitTipLabel.hidden = NO;
        self.moneyTextFeild.textColor = DSXRedPacketRedColor;
    }
    

}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

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
            
            if (textField.text.length > 2) {
                
                return range.location < 3;
            }
        }
    

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
