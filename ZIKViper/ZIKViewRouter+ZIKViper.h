//
//  ZIKViewRouter+ZIKViper.h
//  ZIKViper
//
//  Created by zuik on 2017/6/15.
//  Copyright © 2017 zuik. All rights reserved.
//

#import <ZIKRouter/ZIKViewRouter.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZIKViperViewPrivate;
@protocol ZIKViperPresenterPrivate;
@protocol ZIKViperInteractorPrivate;

@interface ZIKViewRouter (ZIKViper)
- (nullable ZIKViewRouter *)parentRouter;
- (BOOL)isViperAssembled;
+ (BOOL)isViperAssembledForView:(id<ZIKViperViewPrivate>)view;
- (void)assembleViperForView:(id<ZIKViperViewPrivate>)view
                   presenter:(id<ZIKViperPresenterPrivate>)presenter
                  interactor:(id<ZIKViperInteractorPrivate>)interactor;
- (void)attachRouterForView:(id<ZIKViperViewPrivate>)view;
@end

NS_ASSUME_NONNULL_END
