//
//  DSXWalletHiglightView.m
//  DSXMoneyDemo
//
//  Created by LQ on 2017/10/26.
//  Copyright © 2017年 ZJ. All rights reserved.
//

#import "DSXWalletHiglightView.h"
#import "UIView+Extension.h"
@implementation DSXWalletHiglightView
static CGFloat arrowHeigth = 5 ;
-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        [self rounded:5];
    }
    return self;

}
#pragma mark -箭头方向
-(void)setIsLeftArrow:(BOOL)isLeftArrow{
    
    _isLeftArrow = isLeftArrow;
    if (isLeftArrow) {
        
        self.arrowPoint = CGPointMake(1, 20);
      
    }else{
        
        self.arrowPoint = CGPointMake(234, 20);
        
    }
    
    [self setNeedsDisplay];//重绘
}
-(void)setSelectType:(DSXWalletHiglightViewSelectType)selectType{

    _selectType = selectType;
    
    if (selectType == DSXWalletHiglightViewSelectType_enabled) {
        
        self.alpha = 0.6;
    }else{
    
        self.alpha = 0.2;
    }
    
    [self setNeedsDisplay];//重绘

}
- (void)drawRect:(CGRect)rect {
    
    CGRect frame = rect;
    frame.size.height = frame.size.height -arrowHeigth   ;
    rect = frame;
    // 获取当前图形，视图推入堆栈的图形，相当于你所要绘制图形的图纸
    CGContextRef ctx =UIGraphicsGetCurrentContext();
    // 创建一个新的空图形路径。
    CGContextBeginPath(ctx);
    //启始位置坐标x，y
    CGFloat origin_x;
    CGFloat origin_y ;
    //第一条线的位置坐标
    CGFloat line_1_x;
    CGFloat line_1_y;
    //第二条线的位置坐标
    CGFloat line_2_x;
    CGFloat line_2_y ;
    //第三条线的位置坐标
    CGFloat line_3_x;
    CGFloat line_3_y ;
    //尖角的顶点位置坐标
    CGFloat line_4_x ;
    CGFloat line_4_y ;
    //第五条线位置坐标
    CGFloat line_5_x;
    CGFloat line_5_y ;
    //第六条线位置坐标
    CGFloat line_6_x ;
    CGFloat line_6_y ;
    
    
    if (self.isLeftArrow) {
        
        //启始位置坐标x，y --- 尖角的顶点位置坐标
        origin_x = self.arrowPoint.x;
        origin_y = self.arrowPoint.y ;
        //第一条线的位置坐标
        line_1_x = origin_x + arrowHeigth - 1;
        line_1_y = origin_y - arrowHeigth  ;
        // 左上角
        line_2_x = line_1_x - 1;
        line_2_y = 0;
        //第三条线的位置坐标 --- 右上角
        line_3_x = rect.size.width ;
        line_3_y = line_2_y;
        //第四条线的位置坐标 -- 右下角
        line_4_x = line_3_x;
        line_4_y = rect.size.height + arrowHeigth;
        //第五条线位置坐标 - 左下角
        line_5_x = line_1_x;
        line_5_y = line_4_y;
        //第六条线位置坐标
        line_6_x = line_1_x;
        line_6_y = self.arrowPoint.y + arrowHeigth  ;
    }else{
        
        //启始位置坐标x，y --- 尖角的顶点位置坐标
        origin_x = self.arrowPoint.x;
        origin_y = self.arrowPoint.y ;
        //第一条线的位置坐标
        line_1_x = origin_x - arrowHeigth + 1  ;
        line_1_y = origin_y - arrowHeigth  ;
        // 左上角
        line_2_x = line_1_x + 1;
        line_2_y = 0;
        //第三条线的位置坐标 --- 右上角
        line_3_x = 0;
        line_3_y = line_2_y;
        //第四条线的位置坐标 -- 右下角
        line_4_x = line_3_x;
        line_4_y = rect.size.height + arrowHeigth;
        //第五条线位置坐标 - 左下角
        line_5_x = line_1_x;
        line_5_y = line_4_y;
        //第六条线位置坐标
        line_6_x = line_1_x;
        line_6_y = self.arrowPoint.y + arrowHeigth  ;
        
    }
    
    
    
    //先移到p1点
    // CGContextMoveToPoint(ctx, p[0].x, p[0].y);
    //  //从p1点开始画弧线，圆弧和p1-p2相切;p2-p3和弧线相切,圆弧的半径是20
    // CGContextAddArcToPoint(ctx, p[1].x, p[1].y, p[2].x, p[2].y, 20.0);
    
    
    CGContextMoveToPoint(ctx, origin_x, origin_y);
    
    CGContextAddLineToPoint(ctx, line_1_x, line_1_y);
    
    CGContextAddArcToPoint(ctx, line_2_x, line_2_y, line_3_x, line_3_y, 5.0);
    CGContextAddArcToPoint(ctx, line_3_x, line_3_y, line_4_x, line_4_y, 5.0);
    CGContextAddArcToPoint(ctx, line_4_x, line_4_y, line_5_x, line_5_y, 5.0);
    CGContextAddArcToPoint(ctx, line_5_x, line_5_y, line_6_x, line_6_y, 5.0);
    
    CGContextAddLineToPoint(ctx, line_6_x, line_6_y);
    
    
    CGContextClosePath(ctx);
    
    
    UIColor *costomColor ;
    if (self.selectType == DSXWalletHiglightViewSelectType_enabled) {
        
        costomColor = [UIColor whiteColor];
        
    }else{
        
        costomColor = [UIColor blackColor];
    }
    
    
    CGContextSetFillColorWithColor(ctx, costomColor.CGColor);
    CGContextSetStrokeColorWithColor(ctx, DSXMySeparatorColor.CGColor);
    CGContextSetLineWidth(ctx, 0.5);
    //    CGContextSetShadow(ctx, CGSizeMake(5, 5), 5);
    // CGContextFillPath(ctx);
    //    CGContextStrokePath(ctx);
    
    // 同时描边和填充
    CGContextDrawPath(ctx, kCGPathFillStroke);
    
    
}



@end
