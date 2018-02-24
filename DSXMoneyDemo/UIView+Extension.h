//
//  UIView+Extension.h
//  SmartLock
//
//  Created by 江欣华 on 2016/10/25.
//  Copyright © 2016年 工程锁. All rights reserved.
//

#import <UIKit/UIKit.h>
/* define */
/** self的弱引用 */
#define DSXWeakSelf __weak typeof(self) weakSelf = self;
/** self的强引用 */
#define DSXStrongSelf __strong typeof(self) strongSelf = weakSelf;
/** self的强引用 */
#define DCHStrongSelf __strong typeof(self) self = weakSelf;
// 设备宽高
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define DSXColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define DSXMySeparatorColor  DSXColor(221,221,221, 1)
#define DSX178GrayColor DSXColor(178,178,178,1)
#define DSXTextColor DSXColor(51,51,51,1)
#define DSXSeparatorColor  DSXColor(221,221,221, 1)
//适配比例
#define SCREEN_SCALE (SCREEN_HEIGHT/667)
/**
 *  分割线高度
 */
#define DSXSeperatorLineHeight 0.5
@interface UIView (Extension)

/**  起点x坐标  */
@property (nonatomic, assign) CGFloat x;
/**  起点y坐标  */
@property (nonatomic, assign) CGFloat y;
/**  中心点x坐标  */
@property (nonatomic, assign) CGFloat centerX;
/**  中心点y坐标  */
@property (nonatomic, assign) CGFloat centerY;
/**  宽度  */
@property (nonatomic, assign) CGFloat width;
/**  高度  */
@property (nonatomic, assign) CGFloat height;
/**  顶部  */
@property (nonatomic, assign) CGFloat top;
/**  底部  */
@property (nonatomic, assign) CGFloat bottom;
/**  左边  */
@property (nonatomic, assign) CGFloat left;
/**  右边  */
@property (nonatomic, assign) CGFloat right;
/**  size  */
@property (nonatomic, assign) CGSize size;
/**  origin */
@property (nonatomic, assign) CGPoint origin;


/**  设置圆角  */
- (void)rounded:(CGFloat)cornerRadius;

/**  设置圆角和边框  */
- (void)rounded:(CGFloat)cornerRadius width:(CGFloat)borderWidth color:(UIColor *)borderColor;

/**  设置边框  */
- (void)border:(CGFloat)borderWidth color:(UIColor *)borderColor;

/**   给哪几个角设置圆角  */
-(void)round:(CGFloat)cornerRadius RectCorners:(UIRectCorner)rectCorner;

/**  设置阴影  */
-(void)shadow:(UIColor *)shadowColor opacity:(CGFloat)opacity radius:(CGFloat)radius offset:(CGSize)offset;

- (UIViewController *)viewController;

+ (CGFloat)getLabelHeightByWidth:(CGFloat)width Title:(NSString *)title font:(UIFont *)font;




/**
 返回一个固定的弹窗
 
 @param title 标题
 @param message 内容
 @param handler 回调
 */
- (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
            confirmHandler:(void(^)(UIAlertAction *confirmAction))handler;


/**
 返回一个自定义确定按钮的弹窗
 
 @param title 标题
 @param message 内容
 @param confirmTitle 按钮名称
 @param handler 回调
 */
- (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
              confirmTitle:(NSString *)confirmTitle
            confirmHandler:(void(^)(UIAlertAction *confirmAction))handler;


/**
  返回一个自定义取消 确定按钮的弹窗

 @param title 标题
 @param message 内容
 @param cancelTitle 取消按钮
 @param confirmTitle 取消按钮
 @param cancelhandler 回调
 @param handler 回调
 */
- (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
               cancelTitle:(NSString *)cancelTitle
              confirmTitle:(NSString *)confirmTitle
             cancelHandler:(void(^)(UIAlertAction *cancelAction))cancelhandler
            confirmHandler:(void(^)(UIAlertAction *confirmAction))handler;

/**
 返回一个渐变色的view

 @param view 需要添加渐变色图层的view
 @return 图层
 */
- (CAGradientLayer *)setGradualChangingColor:(UIView *)view;
#pragma mark -获取一条横线
-(void)getLineViewwithPoint:(CGPoint)point;
@end
