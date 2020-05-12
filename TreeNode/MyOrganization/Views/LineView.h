//
//  LineView.h
//  TimeDBModule
//
//  Created by 杨永强 on 2020/1/4.
//
#define kLineWidth 2.0f

#define kArrowWidth 20.0f

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "LineModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LineView : NSObject

@property (nonatomic,assign)BOOL selected;
@property (nonatomic,strong)LineModel *lineModel;

- (void)drawLineFromView:(UIView *)from to:(UIView *)toView needShow:(BOOL)needShow;

- (void)removeLine;

@end

NS_ASSUME_NONNULL_END
