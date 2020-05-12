//
//  OrganizScrollView.h
//  TimeDBModule
//
//  Created by 杨永强 on 2020/4/21.
//

#import <UIKit/UIKit.h>
#import "OrganizationView.h"
#import "ContentButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface OrganizScrollView : UIScrollView<UIScrollViewDelegate>
@property (nonatomic,strong)OrganizationView * rootOrgView;//跟节点
@property (nonatomic,weak,nullable)__kindof ContentButton *selectedView; //选中视图
@end

NS_ASSUME_NONNULL_END
