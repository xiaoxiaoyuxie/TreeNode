//
//  GraphicsBaseView+Style.m
//  TimeDBModule
//
//  Created by 杨永强 on 2020/1/3.
//

#import "ContentButton+Style.h"
#import "YYCategories.h"
#import "ContentButton+Action.h"
#import <objc/runtime.h>

@interface ContentButton()
@property (nonatomic,assign)CGFloat normalBorderWidth;
@end

@implementation ContentButton (Style)

-(CGFloat)normalBorderWidth
{
    NSNumber *number = objc_getAssociatedObject(self, _cmd);
    return number.floatValue;
}

-(void)setNormalBorderWidth:(CGFloat)normalBorderWidth
{
    objc_setAssociatedObject(self, @selector(normalBorderWidth), @(normalBorderWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setSelectedStyle:(BOOL)selected;
{
    if (selected) {
        self.layer.borderColor = [UIColor blueColor].CGColor;
        self.layer.borderWidth = 4;
        self.addBtn.hidden = NO;
        self.addBtn.center = self.center;
        [UIView animateWithDuration:0.3 animations:^{
            self.addBtn.centerX = self.centerX - 50;
            self.addBtn.top = self.bottom + 10;
        }];
    }else
    {
        self.layer.borderColor = [UIColor colorWithRed:50/255.0 green:115/255.0 blue:115/255.0 alpha:1].CGColor;
        self.layer.borderWidth = self.normalBorderWidth;
        self.addBtn.hidden = YES;
    }
}

- (void)removeStyleSubView
{
    [self.addBtn removeFromSuperview];
}

-(void)drawRect:(CGRect)rect
{
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    [[UIColor colorWithRed:50/255.0 green:115/255.0 blue:115/255.0 alpha:1] setStroke];
    [[UIColor colorWithRed:220/255.0 green:239/255.0 blue:240/255.0 alpha:1] setFill];
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 1;
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(width, 0)];
    [path addLineToPoint:CGPointMake(width, height)];
    [path addLineToPoint:CGPointMake(0, height)];
    [path addLineToPoint:CGPointMake(0, 0)];
    [path closePath];
    [path stroke];
    [path fill];
}

@end

