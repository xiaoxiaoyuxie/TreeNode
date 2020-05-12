//
//  OrganizationView.h
//  TimeDBModule
//
//  Created by 杨永强 on 2020/4/17.
//

#import <UIKit/UIKit.h>
#import "OrganizationModel.h"
#import "ContentButton.h"

NS_ASSUME_NONNULL_BEGIN
@interface OrganizationView : UIView
@property (nonatomic,strong,readonly)OrganizationModel *orgModel;
@property (nonatomic,strong)ContentButton *cButton;

@property (nonatomic,weak,readonly)OrganizationView *rootView;
@property (nonatomic,weak,readonly)OrganizationView *perNode;

- (id)initWithModel:(OrganizationModel *)resultModel;
- (void)addSubElement:(__kindof OrganizationView *)subview;
- (void)removeFromBackView;
@end

NS_ASSUME_NONNULL_END
