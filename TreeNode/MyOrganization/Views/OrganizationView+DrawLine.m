//
//  GraphicsMutiView+DrawLine.m
//  TimeDBModule
//
//  Created by 杨永强 on 2020/1/19.
//

#import "OrganizationView+DrawLine.h"
#import "LineModel.h"
#import <objc/runtime.h>

@interface OrganizationView ()
@property (nonatomic,strong)LineView *tempLineView;
@end


@implementation OrganizationView (DrawLine)
@dynamic superview;

- (NSMutableArray<LineView *> *)subLineViews
{
    NSMutableArray *arr = objc_getAssociatedObject(self, _cmd);
    if (!arr) {
        self.subLineViews = [NSMutableArray array];
    }
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setSubLineViews:(NSMutableArray<LineView *> *)subLineViews
{
    objc_setAssociatedObject(self, @selector(subLineViews), subLineViews, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(LineView *)tempLineView
{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setTempLineView:(LineModel *)tempLineView
{
    objc_setAssociatedObject(self, @selector(tempLineView), tempLineView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)addLineToview:(OrganizationView *)toView fromView:(OrganizationView *)fromView
{
    LineView *lineView = [LineView new];
    [self removeRepetitiveLine:lineView];//移除已有画线
    [lineView drawLineFromView:fromView to:toView needShow:YES];
    
    [self.subLineViews insertObject:lineView atIndex:0];
}
- (void)removeLine:(LineView *)lineView
{
    if (!lineView) {
        return;
    }
    [lineView removeLine];
    [self.subLineViews removeObject:lineView];
}

- (void)removeAllSubLines
{
    for (LineView *view in self.subLineViews) {
        [view removeLine];
    }
}

- (void)deleteRelateLinesWithView:(OrganizationView *)delView; //删除delView相关线条
{
    for (LineView *view in self.subLineViews) {
        LineModel *model = view.lineModel;
        NSString *isDtr = [NSString stringWithFormat:@"%p",delView];
        if ([model.to isEqualToString:isDtr]) {
            [self removeLine:view];
            break;
        }
    }
    
    [self reDrawRelateLinesWhenPaning];
}

- (void)reDrawRelateLinesWhenPaning
{
    for (LineView *view in self.subLineViews) {
        LineModel *model = view.lineModel;
        OrganizationView *toView = [OrganizationView findGraphicsViewWithID:model.to fromView:self];
        
        OrganizationView *fromView = [OrganizationView findGraphicsViewWithID:model.from fromView:self];
        [view drawLineFromView:fromView to:toView needShow:NO];
    }
    
    if ([self.superview isKindOfClass:[OrganizationView class]]) {
        for (LineView *view in self.superview.subLineViews) {
            LineModel *model = view.lineModel;
            OrganizationView *toView = [OrganizationView findGraphicsViewWithID:model.to fromView:self.superview];
            
            OrganizationView *fromView = [OrganizationView findGraphicsViewWithID:model.from fromView:self.superview];
            [view drawLineFromView:fromView to:toView needShow:NO];
        }
    }
}

+ (OrganizationView *)findGraphicsViewWithID:(NSString *)idString fromView:(OrganizationView *)view
{
    if ([view isKindOfClass:[OrganizationView class]]) {
        NSString *idStr = [NSString stringWithFormat:@"%p",view];
        if ([idStr isEqualToString:idString]) {
            return view;
        }
    }
    for (OrganizationView *subView in view.subviews) {
        if ([subView isKindOfClass:[OrganizationView class]]) {
            NSString *idStr = [NSString stringWithFormat:@"%p",subView];
            if ([idStr isEqualToString:idString]) {
                return subView;
            }
        }
    }
    return nil;
}

- (void)removeRepetitiveLine:(LineView *)lineView
{
    NSMutableArray *needDeleteArr = self.subLineViews.mutableCopy;
    for (LineView *view in needDeleteArr) {
        LineModel *model = view.lineModel;
        if (([model.from isEqualToString:lineView.lineModel.from] && [model.to isEqualToString:lineView.lineModel.to]) ||
            ([model.from isEqualToString:lineView.lineModel.to] && [model.to isEqualToString:lineView.lineModel.from])) {
            [view removeLine];
            [self.subLineViews removeObject:view];
        }
    }
}
@end
