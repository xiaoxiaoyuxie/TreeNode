//
//  LineView.m
//  TimeDBModule
//
//  Created by 杨永强 on 2020/1/4.
//

#import "LineView.h"
#import "OrganizationView.h"
#import "YYCategories.h"

@interface LineView ()
@property (nonatomic,strong,nullable)CAShapeLayer * lineLayer;
@property (nonatomic,weak,nullable)OrganizationView * fromView;
@property (nonatomic,weak,nullable)OrganizationView * toView;
@end

@implementation LineView
{
    CAShapeLayer *_arrowLayer;
    UIBezierPath * _mainPath;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.lineModel = [LineModel new];
        _lineLayer = [CAShapeLayer layer];
        _lineLayer.lineCap = kCALineCapRound;
        _lineLayer.lineJoin = kCALineJoinBevel;
        _lineLayer.lineWidth = kLineWidth;
        _lineLayer.fillColor = [UIColor clearColor].CGColor;
        _lineLayer.strokeColor = [UIColor blackColor].CGColor;
        
        _arrowLayer = [CAShapeLayer layer];
        [_lineLayer addSublayer:_arrowLayer];
    }
    return self;
}

-(void)setSelected:(BOOL)selected
{
    _selected = selected;
    if (selected) {
        _arrowLayer.fillColor = self.lineLayer.strokeColor = [UIColor blueColor].CGColor;
    }else
    {
        _arrowLayer.fillColor = self.lineLayer.strokeColor = [UIColor blackColor].CGColor;
    }
}

- (void)drawLineFromView:(OrganizationView *)from to:(OrganizationView *)toView;
{
    _fromView = (OrganizationView *)from;
    _toView = (OrganizationView *)toView;
    self.lineModel.from = [NSString stringWithFormat:@"%p",from];
    self.lineModel.to = [NSString stringWithFormat:@"%p",toView];
    _mainPath = [self buildPathWithView:from to:toView];
    self.lineLayer.path = _mainPath.CGPath;
    [toView.superview.layer insertSublayer:self.lineLayer atIndex:0];
}

- (void)drawLineFromView:(OrganizationView *)from to:(OrganizationView *)toView needShow:(BOOL)needShow;
{
    [self drawLineFromView:from to:toView];
    if (needShow) {
        [toView.superview.layer insertSublayer:self.lineLayer atIndex:0];
    }
}

- (void)removeLine;
{
    [self.lineLayer removeFromSuperlayer];
}

- (UIBezierPath *)buildPathWithView:(OrganizationView *)from to:(OrganizationView *)to
{
    return [self layoutOriganViews:from to:to];
}

- (void)drawArrowLayerWithEndPoint:(CGPoint)toPoint direction:(UIPopoverArrowDirection)direction
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    switch (direction) {
        case UIPopoverArrowDirectionRight:
            [path moveToPoint:CGPointMake(0, 0)];
            [path addLineToPoint:CGPointMake(-kArrowWidth, -(kArrowWidth/2))];
            [path addLineToPoint:CGPointMake(-kArrowWidth, (kArrowWidth/2))];
            [path addLineToPoint:CGPointMake(0, 0)];
            break;
        case UIPopoverArrowDirectionLeft:
            [path moveToPoint:CGPointMake(0, 0)];
            [path addLineToPoint:CGPointMake(kArrowWidth, -(kArrowWidth/2))];
            [path addLineToPoint:CGPointMake(kArrowWidth, kArrowWidth/2)];
            [path addLineToPoint:CGPointMake(0, 0)];
            break;
        case UIPopoverArrowDirectionDown:
            [path moveToPoint:CGPointMake(0, 0)];
            [path addLineToPoint:CGPointMake(-(kArrowWidth/2), -kArrowWidth)];
            [path addLineToPoint:CGPointMake(kArrowWidth/2, -kArrowWidth)];
            [path addLineToPoint:CGPointMake(0, 0)];
            break;
        case UIPopoverArrowDirectionUp:
            [path moveToPoint:CGPointMake(0, 0)];
            [path addLineToPoint:CGPointMake(-(kArrowWidth/2), kArrowWidth)];
            [path addLineToPoint:CGPointMake((kArrowWidth/2), kArrowWidth)];
            [path addLineToPoint:CGPointMake(0, 0)];
            break;
        default:
            break;
    }
    [path closePath];
    _arrowLayer.path = path.CGPath;
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    _arrowLayer.left = toPoint.x;
    _arrowLayer.top = toPoint.y;
    [CATransaction commit];
}

//组织视图布局
- (UIBezierPath *)layoutOriganViews:(OrganizationView *)from to:(OrganizationView *)to
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint fromPoint = CGPointMake(from.centerX, from.bottom);
    if (from == to.superview) {
        fromPoint = CGPointMake(from.cButton.centerX, from.cButton.bottom);
    }
    [path moveToPoint:fromPoint];

    CGPoint toPoint = CGPointMake(to.centerX, to.top);

    CGPoint point = CGPointMake(fromPoint.x, fromPoint.y+(toPoint.y - fromPoint.y)/2);
    [path addLineToPoint:point];
    CGPoint point2 = CGPointMake(toPoint.x, fromPoint.y+(toPoint.y - fromPoint.y)/2);
    [path addLineToPoint:point2];

    [path addLineToPoint:toPoint];
    
    [self drawArrowLayerWithEndPoint:toPoint direction:UIPopoverArrowDirectionDown];

    return path;
}
@end
