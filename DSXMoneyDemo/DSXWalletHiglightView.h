//
//  DSXWalletHiglightView.h
//  DSXMoneyDemo
//
//  Created by LQ on 2017/10/26.
//  Copyright © 2017年 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,DSXWalletHiglightViewSelectType){

    /**是否可以点击遮罩*/
    DSXWalletHiglightViewSelectType_enabled = 0,
    /**是否高亮遮罩*/
    DSXWalletHiglightViewSelectType_highight
};
@interface DSXWalletHiglightView : UIView
/**
 *YES 左边尖角   NO 右边尖角
 */
@property (nonatomic, assign)  BOOL isLeftArrow;

// 箭头所指位置
@property (nonatomic, assign) CGPoint arrowPoint;

//哪个类型的遮罩
@property (nonatomic, assign) DSXWalletHiglightViewSelectType selectType;

@end
