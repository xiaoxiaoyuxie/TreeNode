//
//  GraphicsBaseView+Style.h
//  TimeDBModule
//
//  Created by 杨永强 on 2020/1/3.
//

#import "ContentButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface ContentButton (Style)

- (void)setSelectedStyle:(BOOL)selected;

- (void)removeStyleSubView;
@end

NS_ASSUME_NONNULL_END
