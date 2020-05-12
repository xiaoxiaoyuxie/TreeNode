//
//  OrganizScrollView.m
//  TimeDBModule
//
//  Created by 杨永强 on 2020/4/21.
//

#import "OrganizScrollView.h"
#import "YYCategories.h"

@implementation OrganizScrollView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        [doubleTap setNumberOfTapsRequired:2];
        [self addGestureRecognizer:doubleTap];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    if (self.rootOrgView.width > self.width) {
        self.rootOrgView.left = 0;
    }else
    {
        self.rootOrgView.centerX = self.width/2;
    }
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)tap
{
    [self setZoomScale:1 animated:YES];
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.rootOrgView;
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat scale = self.zoomScale;
    CATiledLayer*tiledLayer = (CATiledLayer*)[self.rootOrgView layer];
    int lev =ceil(log2(1/scale))+1;
    tiledLayer.levelsOfDetail=1;
    tiledLayer.levelsOfDetailBias= lev;
}

-(void)setSelectedView:(__kindof ContentButton *)selectedView
{
    _selectedView.selected = NO;
    selectedView.selected = YES;
    _selectedView = selectedView;
}

-(void)setRootOrgView:(OrganizationView *)orgView
{
    [_rootOrgView removeFromSuperview];
    _rootOrgView = orgView;
    [self addSubview:self.rootOrgView];
}
@end
