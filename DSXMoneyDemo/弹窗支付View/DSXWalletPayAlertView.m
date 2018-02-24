//
//  DSXWalletPayAlertView.m
//  DSXMoneyDemo
//
//  Created by LQ on 2017/10/27.
//  Copyright © 2017年 ZJ. All rights reserved.
//

#import "DSXWalletPayAlertView.h"
#import "DSXWalletPasswordView.h"
#import "DSXWalletButton.h"
#import "UIView+Extension.h"



@interface DSXWalletPayAlertView()<DSXWalletPasswordViewDelegate>
//支付的费用文字
@property (nonatomic, strong) UILabel *moneyLabel;

//余额文字
@property (nonatomic, strong) UILabel *balanceMoneyLabel;

//密码框
@property (nonatomic, strong) DSXWalletPasswordView *passwordView;

//支付按钮
@property (nonatomic, strong) DSXWalletButton *payButton;

@end
@implementation DSXWalletPayAlertView
+(instancetype)alert{
    
    DSXWalletPayAlertView *alertView = [[DSXWalletPayAlertView alloc] init];
    alertView.alertStyle = DSXAlertStyleAlert;
    alertView.isBgViewClick = NO;
    
    
    return alertView;
    
}
- (void)setup{

    //*********背景************/
    
    CGFloat height = 255 * SCREEN_SCALE;
    self.contentView.x = 50 * SCREEN_SCALE;
    self.contentView.y = ((SCREEN_HEIGHT - 64)/2 - height/2) * SCREEN_SCALE;
    self.contentView.width = SCREEN_WIDTH - self.contentView.x * 2;
    self.contentView.height = height;
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    //*********删除按钮************/
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteBtn setImage:[UIImage imageNamed:@"icon_guan1_red"] forState:UIControlStateNormal];
    deleteBtn.x = 15;
    deleteBtn.y = 23;
    deleteBtn.size = deleteBtn.imageView.image.size;
    [deleteBtn addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:deleteBtn];
    
    //*********标题************/
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 20, self.contentView.width - 80, 17* SCREEN_SCALE)];
    titleLabel.text = @"支付";
    titleLabel.textColor = DSXTextColor;
    titleLabel.font = [UIFont systemFontOfSize:17* SCREEN_SCALE];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:titleLabel];
    
    //*********金额************/
    self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, titleLabel.bottom, self.contentView.width, 100 * SCREEN_SCALE)];
    self.moneyLabel.text = @"￥190";
    self.moneyLabel.textColor = DSXTextColor;
    self.moneyLabel.font = [UIFont boldSystemFontOfSize:40* SCREEN_SCALE];
    self.moneyLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.moneyLabel];
    
    
    //*********余额************/
    
    UIView *balanceMoneyView = [[UIView alloc] initWithFrame:CGRectMake(15, self.moneyLabel.bottom, self.contentView.width - 30, 45* SCREEN_SCALE)];
    [self.contentView addSubview:balanceMoneyView];
    
    self.balanceMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, balanceMoneyView.width - 10, balanceMoneyView.height)];
    self.balanceMoneyLabel.text = @"善信钱包 (余额18.99)";
    self.balanceMoneyLabel.textColor = DSXColor(155, 155, 155, 1);
    self.balanceMoneyLabel.font = [UIFont systemFontOfSize:17 *SCREEN_SCALE];
    [balanceMoneyView addSubview:self.balanceMoneyLabel];
    
    
    UIView *toplineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, balanceMoneyView.width, DSXSeperatorLineHeight)];
    toplineView.backgroundColor = DSXSeparatorColor;
    
    [balanceMoneyView addSubview:toplineView];
    
    UIView *bottomlineView = [[UIView alloc] initWithFrame:CGRectMake(0, balanceMoneyView.height - DSXSeperatorLineHeight *2, balanceMoneyView.width, DSXSeperatorLineHeight)];
    bottomlineView.backgroundColor = DSXSeparatorColor;
    
    [balanceMoneyView addSubview:bottomlineView];
    
    //*********按钮或者密码框************/
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, balanceMoneyView.bottom , self.contentView.width, self.contentView.height - balanceMoneyView.bottom)];
    bottomView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:bottomView];
    
    
    DSXWeakSelf
    switch (self.payType) {
        case DSXWalletPayType_needPassword:
        {
            //密码输入
            self.passwordView = [[DSXWalletPasswordView alloc] initWithFrame:bottomView.bounds];
            self.passwordView.backgroundColor = [UIColor whiteColor];
            self.passwordView.passWordNum = 6;
            self.passwordView.squareWidth = 40* SCREEN_SCALE;
            self.passwordView.rectColor = DSXColor(178, 178, 178, 1);
            self.passwordView.delegate = self;
            self.passwordView.pointRadius = 4* SCREEN_SCALE;
            self.passwordView.pointColor = DSXTextColor;
           
            [bottomView addSubview:self.passwordView];
            
          
        
        }
            break;
        case DSXWalletPayType_noNeedPassword:
        {
            //无需密码  立即支付
            CGFloat h = 45 *SCREEN_SCALE;
            CGFloat x = 15;
            CGFloat y = bottomView.height / 2 - h/2;
            CGFloat w = bottomView.width - x*2;
            self.payButton = [[DSXWalletButton alloc] initWithFrame:CGRectMake(x, y , w, h) Click:^{
                
            [weakSelf dismiss];
            [weakSelf showAlertWithTitle:nil message:@"立即支付" confirmHandler:nil];
            }];
            [self.payButton setTitle:@"立即支付" forState:UIControlStateNormal];
            self.payButton.titleLabel.font = [UIFont systemFontOfSize:18*SCREEN_SCALE];
            [bottomView addSubview:self.payButton];
            
        }
            break;
        case DSXWalletPayType_notEnoughMoney:
        {
            //余额不足
            
            CGFloat h = 45 *SCREEN_SCALE;
            CGFloat x = 15;
            CGFloat y = bottomView.height / 2 - h/2;
            CGFloat w = bottomView.width - x*2;
            self.payButton = [[DSXWalletButton alloc] initWithFrame:CGRectMake(x, y , w, h) Click:^{
                
                [weakSelf dismiss];
                [weakSelf showAlertWithTitle:nil message:@"余额不足, 去充值" confirmHandler:nil];
            }];
            [self.payButton setTitle:@"余额不足, 去充值" forState:UIControlStateNormal];
            self.payButton.titleLabel.font = [UIFont systemFontOfSize:18*SCREEN_SCALE];
            [bottomView addSubview:self.payButton];

            
        }
            break;
            
        default:
            break;
    }
    
}
-(void)setPayType:(DSXWalletPayType)payType{

    _payType = payType;
    [self setup];
}
- (void)deleteClick{

    [self dismiss];
}

#pragma mark - 密码输入的回调
-(void)passWordDidChange:(DSXWalletPasswordView *)passWord{

    NSLog(@"改变%@",passWord.textStore);
}
-(void)passWordBeginInput:(DSXWalletPasswordView *)passWord{

    NSLog(@"开始%@",passWord.textStore);
}
-(void)passWordCompleteInput:(DSXWalletPasswordView *)passWord{

    NSLog(@"结束%@",passWord.textStore);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
