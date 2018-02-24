//
//  DSXWalletPayAlertView.h
//  DSXMoneyDemo
//
//  Created by LQ on 2017/10/27.
//  Copyright © 2017年 ZJ. All rights reserved.
//

#import "DSXAlertBaseView.h"


/**
 钱包支付的几种情况
 */
typedef NS_ENUM(NSInteger,DSXWalletPayType) {
    /**余额不足*/
    DSXWalletPayType_notEnoughMoney = 0,
    /**需要密码*/
    DSXWalletPayType_needPassword = 1,

    /**不需要密码*/
    DSXWalletPayType_noNeedPassword = 2,


};
@interface DSXWalletPayAlertView : DSXAlertBaseView
/**
 *支付情况
 */
@property (nonatomic, assign) DSXWalletPayType payType;
+(instancetype)alert;
@end
