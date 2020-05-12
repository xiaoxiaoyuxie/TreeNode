//
//  OrganizationView+Action.m
//  TimeDBModule
//
//  Created by 杨永强 on 2020/3/26.
//

#import "ContentButton+Action.h"
#import "OrganizationView+Layout.h"
#import "OrganizationView.h"
#import "OrganizScrollView.h"
#import <objc/runtime.h>
static int __staticNumber = 0;
@implementation ContentButton (Action)
-(UIButton *)addBtn
{
    UIButton *button = objc_getAssociatedObject(self, _cmd);
    if (!button) {
        button = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [button addTarget:self action:@selector(tapAddBtn) forControlEvents:UIControlEventTouchUpInside];
        button.hidden = YES;
        [button sizeToFit];
        self.addBtn = button;
    }
    [self.superview insertSubview:button belowSubview:self];
    return button;
}

-(void)setAddBtn:(UIButton *)addBtn
{
    objc_setAssociatedObject(self, @selector(addBtn), addBtn, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)tapAddBtn
{
    [self showAddButtons];
}

- (void)showAddButtons
{
    OrganizationModel *model = [OrganizationModel new];
    model.title = [NSString stringWithFormat:@"%d",++__staticNumber];
    OrganizationView *view = [[OrganizationView alloc] initWithModel:model];
    OrganizationView * superV = (OrganizationView *)self.superview;
    [superV addSubElement:view];
}
@end
