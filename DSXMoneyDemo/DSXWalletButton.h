//
//  DSXWalletButton.h
//  DSXMoneyDemo
//
//  Created by LQ on 2017/10/25.
//  Copyright © 2017年 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSXWalletButton : UIButton
- (instancetype)initWithFrame:(CGRect)frame Click:(void(^)())clickBlock;
@end
