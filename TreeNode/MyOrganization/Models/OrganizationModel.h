//
//  OrganizationModel.h
//  TimeDBModule
//
//  Created by 杨永强 on 2020/4/17.
//
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrganizationModel : NSObject
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSMutableArray<OrganizationModel *> *children;
@end

NS_ASSUME_NONNULL_END
