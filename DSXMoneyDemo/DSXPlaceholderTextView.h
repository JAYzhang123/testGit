//
//  DSXPlaceholderTextView.h
//  善信
//
//  Created by 刘敏 on 16/7/7.
//  Copyright © 2016年 LM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSXPlaceholderTextView : UITextView
/** 
 *占位文字 
 */
@property (nonatomic, copy) NSString *placeholder;
/** 
 *占位文字颜色 
 */
@property (nonatomic, strong) UIColor *placeholderColor;

 /**
  设置占位文字的x,默认为5
  */
 @property (nonatomic,assign) CGFloat placeholderX;

@end
