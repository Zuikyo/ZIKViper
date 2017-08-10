//
//  ZIKTViperViewPrivate.h
//  ZIKTViper
//
//  Created by zuik on 2017/7/3.
//  Copyright © 2017 zuik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZIKTViperView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ZIKTViperViewEventHandler;

///Private getter/setter to configure ZIKTViperView. Should only be used inside view or assembly.
@protocol ZIKTViperViewPrivate <ZIKTViperView>

- (id<ZIKTViperViewEventHandler>)eventHandler;
- (void)setEventHandler:(id<ZIKTViperViewEventHandler>)eventHandler;

@optional
- (id)viewDataSource;
- (void)setViewDataSource:(id)viewDataSource;
- (void)setRouteSource:(UIViewController *)routeSource;

@end

NS_ASSUME_NONNULL_END
