//
//  ZIKLoginViewRouter.m
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/15.
//  Copyright © 2017 zuik. All rights reserved.
//

#import "ZIKLoginViewRouter.h"
@import ZIKRouter.Internal;
#import <ZIKViper/ZIKViewRouter+ZIKViper.h>
#import <ZIKViper/ZIKViperViewPrivate.h>
#import <ZIKViper/ZIKViperInteractorPrivate.h>

#import "ZIKLoginViewController.h"
#import "ZIKLoginViewPresenter.h"
#import "ZIKLoginInteractor.h"
#import "ZIKLoginViewProtocol.h"

@interface ZIKLoginViewController (ZIKLoginViewRouter) <ZIKRoutableView>
@end
@implementation ZIKLoginViewController (ZIKLoginViewRouter)
@end

@implementation ZIKLoginViewRouter

+ (void)registerRoutableDestination {
    ZIKViewRouter_registerView([ZIKLoginViewController class], self);
    ZIKViewRouter_registerViewProtocol(@protocol(ZIKLoginViewProtocol), self);
}

- (id)destinationWithConfiguration:(__kindof ZIKRouteConfiguration *)configuration {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ZIKLoginViewController *destination = [sb instantiateViewControllerWithIdentifier:@"ZIKLoginViewController"];
    return destination;
}

- (void)prepareDestination:(id)destination configuration:(__kindof ZIKViewRouteConfiguration *)configuration {
    NSParameterAssert([destination isKindOfClass:[ZIKLoginViewController class]]);
    NSParameterAssert([destination conformsToProtocol:@protocol(ZIKViperViewPrivate)]);
    if (![self isViperAssembled]) {
        [self assembleViper];
    } else {
        [self attachRouter];
    }
}

#pragma mark Viper assembly

- (void)assembleViper {
    id<ZIKViperViewPrivate> view = self.destination;
    NSAssert(view, @"Can't assemble viper when view is nil");
    ZIKLoginViewPresenter *presenter = [[ZIKLoginViewPresenter alloc] init];
    ZIKLoginInteractor *interactor = [[ZIKLoginInteractor alloc] init];
    NSParameterAssert([view conformsToProtocol:@protocol(ZIKViperViewPrivate)]);
    NSParameterAssert([presenter conformsToProtocol:@protocol(ZIKViperPresenterPrivate)]);
    NSParameterAssert([interactor conformsToProtocol:@protocol(ZIKViperInteractorPrivate)]);
    [self assembleViperForView:view
                     presenter:(id<ZIKViperPresenterPrivate>)presenter
                    interactor:(id<ZIKViperInteractorPrivate>)interactor];
}

- (void)attachRouter {
    id<ZIKViperViewPrivate> view = self.destination;
    NSAssert(view, @"Can't assemble viper when view is nil");
    [self attachRouterForView:view];
}

#pragma mark AOP

+ (void)router:(ZIKViewRouter *)router willPerformRouteOnDestination:(id)destination fromSource:(id)source {
    NSAssert([ZIKViewRouter isViperAssembledForView:destination], @"Viper should be assembled");
}

+ (ZIKViewRouteTypeMask)supportedRouteTypes {
    return
    ZIKViewRouteTypeMaskPresentModally |
    ZIKViewRouteTypeMaskPresentAsPopover |
    ZIKViewRouteTypeMaskPerformSegue |
    ZIKViewRouteTypeMaskShow |
    ZIKViewRouteTypeMaskShowDetail;
}

@end
