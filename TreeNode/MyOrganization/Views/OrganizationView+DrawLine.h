//
//  OrganizationView+DrawLine.h
//  TimeDBModule
//
//  Created by 杨永强 on 2020/1/19.
//

#import "OrganizationView.h"
#import "LineView.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrganizationView (DrawLine)
@property (nonatomic,strong)OrganizationView *superview;
@property (nonatomic,strong)NSMutableArray<LineView *> * subLineViews;

- (void)removeAllSubLines;

- (void)addLineToview:(OrganizationView *)toView fromView:(OrganizationView *)fromView;

- (void)deleteRelateLinesWithView:(OrganizationView *)delView; //删除delView相关线条

- (void)reDrawRelateLinesWhenPaning;


@end

NS_ASSUME_NONNULL_END
