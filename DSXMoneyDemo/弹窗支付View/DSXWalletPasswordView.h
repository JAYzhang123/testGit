//
//  DSXWalletPasswordView.h
//  DSXMoneyDemo
//
//  Created by LQ on 2017/10/27.
//  Copyright © 2017年 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DSXWalletPasswordView;

@protocol  DSXWalletPasswordViewDelegate<NSObject>

@optional
/**
 *  监听输入的改变
 */
- (void)passWordDidChange:(DSXWalletPasswordView *)passWord;

/**
 *  监听输入的完成时
 */
- (void)passWordCompleteInput:(DSXWalletPasswordView *)passWord;

/**
 *  监听开始输入
 */
- (void)passWordBeginInput:(DSXWalletPasswordView *)passWord;


@end

IB_DESIGNABLE

@interface DSXWalletPasswordView : UIView<UIKeyInput>

@property (assign, nonatomic) IBInspectable NSUInteger passWordNum;//密码的位数
@property (assign, nonatomic) IBInspectable CGFloat squareWidth;//正方形的大小
@property (assign, nonatomic) IBInspectable CGFloat pointRadius;//黑点的半径
@property (strong, nonatomic) IBInspectable UIColor *pointColor;//黑点的颜色
@property (strong, nonatomic) IBInspectable UIColor *rectColor;//边框的颜色
@property (weak, nonatomic) IBOutlet id<DSXWalletPasswordViewDelegate> delegate;
@property (strong, nonatomic, readonly) NSMutableString *textStore;//保存密码的字符串

@end
