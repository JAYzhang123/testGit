//
//  DSXWalletCellView.m
//  DSXMoneyDemo
//
//  Created by LQ on 2017/10/25.
//  Copyright © 2017年 ZJ. All rights reserved.
//

#import "DSXWalletCellView.h"
#import "UIView+Extension.h"
#import "DSXWalletHiglightView.h"
@interface DSXWalletCellView()

// 箭头所指位置
@property (nonatomic, assign) CGPoint arrowPoint;

@property (nonatomic, strong) UIView *topColorView;//上部颜色view
@property (nonatomic, strong) UIView *bottomLabelView;//下部分白色View

@property (nonatomic, strong) UIView *midLineView;//盖住圆角用


@property (nonatomic, strong) UIImageView *redPacketImageView;//红包图片
@property (nonatomic, strong) UILabel *topLabel;//上部分文字
@property (nonatomic, strong) UILabel *detailLabel;//下部分文字


@property (nonatomic, strong) DSXWalletHiglightView *highlightedView;//高亮显示
@end
@implementation DSXWalletCellView
static CGFloat arrowHeigth = 5 ;
+(instancetype)shareWalletCellViewWithPoint:(CGPoint)point{

    DSXWalletCellView *walletView = [[DSXWalletCellView alloc] initWithFrame:CGRectMake(point.x, point.y, 235, 85)];
    
    return walletView;

}
-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        self.enabled = YES;
        [self setUI];
        
    }
    return self;

}
- (void)setUI{

    //***上半部分渐变颜色的view***/
    self.topColorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height - 20)];
    self.topColorView.backgroundColor = DSXColor(205, 132, 79, 1);
    [self.topColorView.layer insertSublayer:[self setGradualChangingColor:self.topColorView] atIndex:0];
    self.topColorView.userInteractionEnabled = NO;
    [self.topColorView rounded:5];
    
    [self addSubview:self.topColorView];
    
    self.redPacketImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_red1_chat_n"]];
    self.redPacketImageView.x = 13;
    self.redPacketImageView.centerY = self.topColorView.centerY;
    self.redPacketImageView.size = self.redPacketImageView.image.size;
    [self.topColorView addSubview:self.redPacketImageView];
    
    self.topLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.redPacketImageView.right + 15, self.redPacketImageView.top + 3, self.width - 80, 16)];
    self.topLabel.font = [UIFont systemFontOfSize:16];
    self.topLabel.textColor = [UIColor whiteColor];
    self.topLabel.text = @"随喜赞叹随喜赞叹随喜赞叹";
    [self.topColorView addSubview:self.topLabel];
    
    
    self.detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.redPacketImageView.right + 15, self.redPacketImageView.bottom - 3 - 12, self.width - 80, 12)];
    self.detailLabel.font = [UIFont systemFontOfSize:12];
    self.detailLabel.textColor = [UIColor whiteColor];
    self.detailLabel.text = @"查看红包";
    [self.topColorView addSubview:self.detailLabel];
    
    
    
    
    //***下部分文字view***/
    self.bottomLabelView = [[UIView alloc] initWithFrame:CGRectMake(0, self.topColorView.bottom - 5, self.width, 25)];
    self.bottomLabelView.backgroundColor =[UIColor whiteColor];
    [self.bottomLabelView rounded:5 width:0.5 color:DSXMySeparatorColor];
    [self addSubview:self.bottomLabelView];
    self.bottomLabelView.userInteractionEnabled = NO;
    
    UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, self.width - 90, 20)];
    bottomLabel.font = [UIFont systemFontOfSize:10];
    bottomLabel.textColor = DSXColor(155, 155, 155, 1);
    bottomLabel.text = @"善信红包";
    [self.bottomLabelView addSubview:bottomLabel];
    
    
    //***以下是取巧  用一个view盖住上下圆角***/
    self.midLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.topColorView.bottom - 5, self.width, 5)];
    self.midLineView.userInteractionEnabled = NO;
    [self addSubview:self.midLineView];
    
    
    
   

}
#pragma mark -箭头方向
-(void)setIsLeftArrow:(BOOL)isLeftArrow{

    _isLeftArrow = isLeftArrow;
    if (isLeftArrow) {
        
        self.arrowPoint = CGPointMake(1, 20);
        self.topColorView.x = 5;
        self.bottomLabelView.x = 5;
        self.midLineView.x = 5;
        self.topColorView.width -=5;
        self.bottomLabelView.width -=5;
        self.midLineView.width -=5;
        [self.midLineView.layer insertSublayer:[self setGradualChangingColor:self.midLineView] atIndex:0];
    }else{
    
        self.arrowPoint = CGPointMake(234, 20);
        self.topColorView.width -=5;
        self.bottomLabelView.width -=5;
        self.midLineView.width -=5;
        [self.midLineView.layer insertSublayer:[self setGradualChangingColor:self.midLineView] atIndex:0];
        
    }

    [self setNeedsDisplay];//重绘
}
#pragma mark -是否可以点击
-(void)setIsEnabled:(BOOL)isEnabled{

    _isEnabled = isEnabled;
    
    if (isEnabled) {
        [self.highlightedView removeFromSuperview];

    }else{
    
        [self addSubview:self.highlightedView];
        self.highlightedView.selectType = DSXWalletHiglightViewSelectType_enabled;

    }

}
#pragma mark - 高亮
-(void)setHighlighted:(BOOL)highlighted{
    
    [super setHighlighted:highlighted];
    
    if (highlighted == YES) {
        
        [self addSubview:self.highlightedView];
        self.highlightedView.selectType = DSXWalletHiglightViewSelectType_highight;
        self.redPacketImageView.image = [UIImage imageNamed:@"icon_red3_chat"];
        
    }else{
        
        [self.highlightedView removeFromSuperview];
        self.redPacketImageView.image = [UIImage imageNamed:@"icon_red1_chat_n"];
    }
}
-(UIView *)highlightedView{
    
    if (_highlightedView == nil) {
        
        _highlightedView = [[DSXWalletHiglightView alloc] initWithFrame:self.bounds];
        _highlightedView.userInteractionEnabled = NO;
        _highlightedView.isLeftArrow = self.isLeftArrow;
    }
    return _highlightedView;
    
}
/*
 Only override drawRect: if you perform custom drawing.
 An empty implementation adversely affects performance during animation.
*/
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
        line_1_x = origin_x + arrowHeigth  ;
        line_1_y = origin_y - arrowHeigth  ;
        // 左上角
        line_2_x = line_1_x;
        line_2_y = 1;
        //第三条线的位置坐标 --- 右上角
        line_3_x = rect.size.width - 1;
        line_3_y = line_2_y;
        //第四条线的位置坐标 -- 右下角
        line_4_x = line_3_x;
        line_4_y = rect.size.height - 1;
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
        line_1_x = origin_x - arrowHeigth  ;
        line_1_y = origin_y - arrowHeigth  ;
        // 左上角
        line_2_x = line_1_x;
        line_2_y = 1;
        //第三条线的位置坐标 --- 右上角
        line_3_x = 1;
        line_3_y = line_2_y;
        //第四条线的位置坐标 -- 右下角
        line_4_x = line_3_x;
        line_4_y = rect.size.height + 1;
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
    if (self.isLeftArrow) {
        costomColor = DSXColor(253, 130, 55, 1);
    }else{
    
        costomColor = DSXColor(249, 80, 67, 1);
    }
    CGContextSetFillColorWithColor(ctx, costomColor.CGColor);
    CGContextSetStrokeColorWithColor(ctx, DSXMySeparatorColor.CGColor);
    CGContextSetLineWidth(ctx, 0.5);
 ;
    
    // 同时描边和填充
    CGContextDrawPath(ctx, kCGPathFillStroke);

    
}


@end
