//
//  DSXAlertBaseView.m
//  善信
//
//  Created by ste on 2017/5/31.
//  Copyright © 2017年 LM. All rights reserved.
//

#import "DSXAlertBaseView.h"
@interface DSXAlertBaseView ()

@end

@implementation DSXAlertBaseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        CGRect bounds = [UIScreen mainScreen].bounds;
        
        _backgroundView = [[UIView alloc]initWithFrame:bounds];
        //背景颜色
        _backgroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        //添加背景点击事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didClickBackgroundView)];
        [_backgroundView addGestureRecognizer:tap];
        [self addSubview:_backgroundView];
        
        CGRect frame = (CGRect){0,CGRectGetHeight(bounds),CGRectGetWidth(bounds),0};
        _contentView = [[UIView alloc]initWithFrame:frame];
        _contentView.layer.cornerRadius = 5;
        _contentView.clipsToBounds = YES;
        _contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_contentView];
    }
    return self;
}

-(void)didClickBackgroundView
{
    [self dismiss];
}
-(void)setAlertStyle:(DSXAlertStyle)alertStyle
{
    _alertStyle = alertStyle;
    if (alertStyle == DSXAlertStyleActionSheet) {
        self.contentView.layer.cornerRadius = 0;
    }
}
-(void)setIsBgViewClick:(BOOL)isBgViewClick
{
    _isBgViewClick = isBgViewClick;
    self.backgroundView.userInteractionEnabled = isBgViewClick;
}

- (void)show
{
    [self showWithCompletion:nil];
}

- (void)showWithCompletion:(dispatch_block_t)aCompletion
{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (window == nil) {
        window = [UIApplication sharedApplication].windows[0];
    }
    [window addSubview:self];
    
    if (self.alertStyle == DSXAlertStyleAlert) {
        
        self.contentView.transform = CGAffineTransformMakeScale(0.5, 0.5);
        [UIView animateWithDuration:0.25 animations:^{
            self.contentView.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
            if (aCompletion) {
                aCompletion();
            }
        }];
    }else
    {

//        self.backgroundView.alpha = 0;
//        CGRect frame = CGRectMake(0, self.bounds.size.height - self.contentView.frame.size.height,self.bounds.size.width, self.contentView.frame.size.height);
//        [UIView animateWithDuration:0.25 animations:^{
//            self.contentView.frame = frame;
//            self.backgroundView.alpha = 1.0;
//        } completion:^(BOOL finished) {
//            if (aCompletion) {
//                aCompletion();
//            }
//        }];
        
        
        CGRect frame = self.contentView.frame;
        
        [UIView animateWithDuration:0.25 animations:^{
            
            self.contentView.transform =  CGAffineTransformMakeTranslation(0,-CGRectGetHeight(frame));
            
        } completion:^(BOOL finished) {
            if (aCompletion) {
                aCompletion();
            }
        }];
    }
    

}


- (void)dismiss
{
    [self dismissWithCompletion:nil];
}

- (void)dismissWithCompletion:(dispatch_block_t)aCompletion
{
    
    if (self.alertStyle == DSXAlertStyleAlert) {
        
        
        [UIView animateWithDuration:0.2 animations:^{
            self.contentView.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.25 animations:^{
                self.contentView.transform = CGAffineTransformMakeScale(0.5, 0.5);
                self.contentView.alpha = 0;
            } completion:^(BOOL finished) {
                if (aCompletion) {
                    aCompletion();
                }
                [self removeFromSuperview];
            }];
        }];
        
    }else
    {
        
//        
//        CGRect frame = CGRectMake(0, self.bounds.size.height,self.bounds.size.width, self.contentView.frame.size.height);
//        [UIView animateWithDuration:0.25 animations:^{
//            self.contentView.frame = frame;
//            self.backgroundView.alpha = 0;
//            
//        } completion:^(BOOL finished) {
//            if (aCompletion) {
//                aCompletion();
//            }
//            [self.showWindow resignKeyWindow];
//            [self removeFromSuperview];
//        }];

        
        [UIView animateWithDuration:0.25 animations:^{
            self.contentView.transform =  CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            self.alpha = 0.0;
            if (aCompletion) {
                aCompletion();
            }
            
            [self removeFromSuperview];
        }];
    }

}



@end
