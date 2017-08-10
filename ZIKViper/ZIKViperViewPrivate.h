//
//  ZIKViperViewPrivate.h
//  ZIKViper
//
//  Created by zuik on 2017/7/3.
//  Copyright © 2017 zuik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZIKViperView.h"
#import "ZIKViperPresenterPrivate.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ZIKViperViewEventHandler;

///Private getter/setter to configure ZIKViperView. Should only be used inside view or assembly.
@protocol ZIKViperViewPrivate <ZIKViperView>

- (void)setEventHandler:(id<ZIKViperViewEventHandler>)eventHandler;
@optional
- (void)setViewDataSource:(id)viewDataSource;

@end

NS_ASSUME_NONNULL_END
