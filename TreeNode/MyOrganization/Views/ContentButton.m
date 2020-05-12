//
//  ContentButton.m
//  TimeDBModule
//
//  Created by 杨永强 on 2020/4/29.
//

#import "ContentButton.h"
#import "OrganizationView.h"
#import "ContentButton+Action.h"
#import "ContentButton+Style.h"
#import "OrganizScrollView.h"
#import "YYCategories.h"

@implementation ContentButton

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.size = CGSizeMake(120, 70);
        self.layer.shadowColor = [UIColor grayColor].CGColor;
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowRadius = 4;
        self.layer.shadowOffset = CGSizeMake(3, 3);
        self.backgroundColor = [UIColor clearColor];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelfView:)]];
    }
    return self;
}

-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self setSelectedStyle:selected];
}

- (void)tapSelfView:(UITapGestureRecognizer *)tap
{
    OrganizationView * view = (OrganizationView *)self.superview;
    view = view.rootView;
    OrganizScrollView * superV = (OrganizScrollView *)view.superview;
    superV.selectedView = self;
}

- (void)layoutStyleSubView;
{
    if (self.hidden) {
        self.addBtn.hidden = YES;
        self.addBtn.center = self.center;
    }else
    {
        self.addBtn.centerX = self.centerX - 50;
        self.addBtn.top = self.bottom + 10;
    }
}


@end
