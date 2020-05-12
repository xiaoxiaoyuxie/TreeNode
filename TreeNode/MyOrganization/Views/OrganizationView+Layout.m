//
//  OrganizationView+Layout.m
//  TimeDBModule
//
//  Created by 杨永强 on 2020/3/4.
//
#import "OrganizationView.h"
#import "OrganizationView+Layout.h"
#import "ContentButton+Action.h"
#import "YYCategories.h"

@implementation OrganizationView (Layout)

- (void)reLayoutSubGraphicsView
{
    @autoreleasepool {
        OrganizationView *lastView;
        CGFloat maxWidth = self.cButton.width;
        CGFloat maxHeight = self.cButton.height + 40;
        for (OrganizationView *view in self.subviews) {
            if ([view isKindOfClass:[OrganizationView class]]) {
                view.top = view.cButton.height + 50;
                CGFloat offset = lastView.left + lastView.size.width;
                view.left = lastView? (offset + 50 ): 0;
                [view reLayoutSubGraphicsView];
                CGFloat right = view.left + view.size.width;
                if (right > maxWidth ) {
                    maxWidth = right;
                }
                CGFloat bottom = view.top + view.size.height;
                if (bottom > maxHeight ) {
                    maxHeight = bottom;
                }
                lastView = view;
            }
        }
        self.width = maxWidth;
        self.height = maxHeight;
    }
    
    if (self == self.rootView) {
        [self resetBounds];
    }
}

- (void)resetBounds
{
    UIScrollView *scrollV = (UIScrollView *)self.superview;
    if (![scrollV isKindOfClass:[UIScrollView class]]) {
        return;
    }
    CGPoint offset = scrollV.contentOffset;
    scrollV.contentSize = CGSizeMake(self.size.width + 100, self.size.height + 100);
    scrollV.contentOffset = offset;
}

@end
