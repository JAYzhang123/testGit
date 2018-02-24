//
//  DSXWalletButton.m
//  DSXMoneyDemo
//
//  Created by LQ on 2017/10/25.
//  Copyright © 2017年 ZJ. All rights reserved.
//

#import "DSXWalletButton.h"
#import "UIView+Extension.h"
typedef void(^ClickBlock)();
@interface DSXWalletButton()
@property (nonatomic, strong) UIView *highlightedView;

@property (nonatomic, copy) ClickBlock clickBlock;
@end
@implementation DSXWalletButton

-(instancetype)initWithFrame:(CGRect)frame Click:(void (^)())clickBlock{

    if (self = [super initWithFrame:frame]) {
        
        self.clickBlock = clickBlock;
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:18];
        self.backgroundColor = DSXColor(205, 132, 79, 1);
        [self.layer insertSublayer:[self setGradualChangingColor:self] atIndex:0];
        [self rounded:5];
        [self addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;

}
- (void)click{

    if (self.clickBlock) {
        
        self.clickBlock();
    }

}

-(void)setEnabled:(BOOL)enabled{
    [super setEnabled:enabled];
    
    if (enabled == YES) {
        
        self.alpha = 1;
        
    }else{
    
        self.alpha = 0.6;
    }
}
-(void)setHighlighted:(BOOL)highlighted{

    [super setHighlighted:highlighted];
    
    if (highlighted == YES) {
        
        [self addSubview:self.highlightedView];
        
    }else{
        
        [self.highlightedView removeFromSuperview];
    }
}
-(UIView *)highlightedView{

    if (_highlightedView == nil) {
        
        _highlightedView = [[UIView alloc] initWithFrame:self.bounds];
        _highlightedView.backgroundColor = [UIColor blackColor];
        _highlightedView.alpha = 0.2;
    }
    return _highlightedView;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
