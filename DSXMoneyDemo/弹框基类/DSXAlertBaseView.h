//
//  DSXAlertBaseView.h
//  善信
//
//  Created by ste on 2017/5/31.
//  Copyright © 2017年 LM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, DSXAlertStyle) {
    DSXAlertStyleAlert = 0,//模式是 alert模式
    DSXAlertStyleActionSheet,//底部actionSheet样式
} NS_ENUM_AVAILABLE_IOS(8_0);
@interface DSXAlertBaseView : UIView

/**
 背景视图
 */
@property (nonnull, nonatomic ,strong) UIView *backgroundView;

/**
 内容视图
 */
@property (nonnull, nonatomic, strong) UIView *contentView;


/** 模式 */
@property (nonatomic,assign) DSXAlertStyle alertStyle;

/** 背景是否可以点击,默认可以点击 */
@property (nonatomic,assign) BOOL isBgViewClick;

/**
 直接展示
 */
- (void)show;

/**
 直接隐藏
 */
- (void)dismiss;

/**
 展示后的回调

 @param aCompletion
 */
- (void)showWithCompletion:(nullable dispatch_block_t)aCompletion;

/**
 隐藏后的回调

 @param aCompletion 
 */
- (void)dismissWithCompletion:(nullable dispatch_block_t)aCompletion;
@end
