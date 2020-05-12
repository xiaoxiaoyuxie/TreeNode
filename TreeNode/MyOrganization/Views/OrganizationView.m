//
//  OrganizationView.m
//  TimeDBModule
//
//  Created by 杨永强 on 2020/4/17.
//

#import "OrganizationView.h"
#import "ContentButton+Style.h"
#import "OrganizationView+Layout.h"
#import "OrganizationView+DrawLine.h"
#import "YYCategories.h"

@interface OrganizationView ()
@property (nonatomic,weak)OrganizationView *perNode;
@end

@implementation OrganizationView

+ (Class)layerClass {
    return [CATiledLayer class];
}

-(id)initWithModel:(OrganizationModel *)resultModel;
{
    self = [super init];
    if (self) {
        _orgModel = resultModel;
        [self addAllSubView];
        self.backgroundColor = [UIColor whiteColor];
        self.cButton = [ContentButton new];
        [self.cButton setTitle:_orgModel.title forState:UIControlStateNormal];
        [self addSubview:self.cButton];
        self.size = self.cButton.size;
        self.height = self.cButton.height + 40;
    }
    return self;
}

- (void)addAllSubView
{
    for (OrganizationModel *model in self.orgModel.children) {
        OrganizationView *view = [[OrganizationView alloc] initWithModel:model];
        [self addSubview:view];
        [self addLineToview:view fromView:self];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.cButton.centerX = self.width/2;
    self.cButton.top = 0;
    [self.cButton layoutStyleSubView];
    [self reDrawRelateLinesWhenPaning];
}

-(void)didMoveToSuperview
{
    [super didMoveToSuperview];
    [self.rootView reLayoutSubGraphicsView];
}

- (OrganizationView *)rootView
{
    OrganizationView *view = self;
    while (view.perNode) {
        view = view.perNode;
    }
    return view;
}

-(void)addSubElement:(OrganizationView *)subview
{
    subview.perNode = self;
    [self addSubview:subview];
    [self addLineToview:subview fromView:self];
}

- (void)removeFromBackView;
{
    [self.subLineViews removeAllObjects]; //移除子视图的线条

    [self.cButton removeStyleSubView];
    
    [self.perNode.orgModel.children removeObject:self.orgModel];
    [self.perNode deleteRelateLinesWithView:self];//移除自身相关线条
    
    OrganizationView *superV = self.rootView;
    [self removeFromSuperview];
    [superV reLayoutSubGraphicsView];
}
@end
