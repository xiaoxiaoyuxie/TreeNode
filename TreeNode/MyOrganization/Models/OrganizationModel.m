//
//  OrganizationModel.m
//  TimeDBModule
//
//  Created by 杨永强 on 2020/4/17.
//

#import "OrganizationModel.h"

@implementation OrganizationModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"children":OrganizationModel.class};
}
@end
