//
//  ZIKViperPresenterPrivate.h
//  ZIKViper
//
//  Created by zuik on 2017/7/3.
//  Copyright © 2017 zuik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZIKViperPresenter.h"
#import "ZIKViperInteractor.h"

NS_ASSUME_NONNULL_BEGIN

///Private getter/setter to configure ZIKViperPresenter. Should only be used inside presenter or assembly.
@protocol ZIKViperPresenterPrivate <ZIKViperPresenter>

- (id)router;
- (void)setRouter:(id)router;

- (void)setView:(id<ZIKViperView>)view;

- (id<ZIKViperInteractor>)interactor;
- (void)setInteractor:(id<ZIKViperInteractor>)interactor;

@end

NS_ASSUME_NONNULL_END
