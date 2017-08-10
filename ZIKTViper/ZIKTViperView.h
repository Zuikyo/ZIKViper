//
//  ZIKTViperView.h
//  ZIKTViper
//
//  Created by zuik on 2017/4/28.
//  Copyright © 2017 zuik. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZIKTViperViewEventHandler;

@protocol ZIKTViperView <NSObject>

- (nullable UIViewController *)routeSource;
@property (nonatomic, readonly, strong) id<ZIKTViperViewEventHandler> eventHandler;
@optional
@property (nonatomic, readonly, strong) id viewDataSource;

@end

NS_ASSUME_NONNULL_END
