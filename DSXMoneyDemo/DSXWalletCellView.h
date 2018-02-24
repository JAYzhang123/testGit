//
//  DSXWalletCellView.h
//  DSXMoneyDemo
//
//  Created by LQ on 2017/10/25.
//  Copyright © 2017年 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSXWalletCellView : UIButton
/**
 *YES 左边尖角   NO 右边尖角
 */
@property (nonatomic, assign)  BOOL isLeftArrow;
/**
 *是否可以点击
 */
@property (nonatomic, assign) BOOL isEnabled;
+(instancetype)shareWalletCellViewWithPoint:(CGPoint)point;
@end
