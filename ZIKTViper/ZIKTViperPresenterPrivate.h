//
//  ZIKTViperPresenterPrivate.h
//  ZIKTViper
//
//  Created by zuik on 2017/7/3.
//  Copyright © 2017 zuik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZIKTViperPresenter.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ZIKTViperWireframe,ZIKTViperView,ZIKTViperInteractor;

///Private getter/setter to configure ZIKTViperPresenter. Should only be used inside presenter or assembly.
@protocol ZIKTViperPresenterPrivate <ZIKTViperPresenter>

- (id<ZIKTViperWireframe>)wireframe;
- (void)setWireframe:(id<ZIKTViperWireframe>)wireframe;

- (void)setView:(id<ZIKTViperView>)view;

- (id<ZIKTViperInteractor>)interactor;
- (void)setInteractor:(id<ZIKTViperInteractor>)interactor;

@end

NS_ASSUME_NONNULL_END
