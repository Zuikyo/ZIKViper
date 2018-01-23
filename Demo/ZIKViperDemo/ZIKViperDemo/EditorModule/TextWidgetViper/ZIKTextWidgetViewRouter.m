//
//  ZIKTextWidgetViewRouter.m
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/17.
//  Copyright © 2017 zuik. All rights reserved.
//

#import "ZIKTextWidgetViewRouter.h"
@import ZIKRouter.Internal;
#import <ZIKViper/ZIKViper.h>
#import "ZIKTextView.h"
#import "ZIKTextWidgetViewPresenter.h"
#import "ZIKTextWidgetInteractor.h"
#import "ZIKTextWidgetViewProtocol.h"

@interface ZIKTextView (ZIKTextWidgetViewRouter) <ZIKRoutableView>
@end
@implementation ZIKTextView (ZIKTextWidgetViewRouter)
@end

@interface ZIKTextWidgetViewRouter ()

@end

@implementation ZIKTextWidgetViewRouter

+ (void)registerRoutableDestination {
    [self registerExclusiveView:[ZIKTextView class]];
    [self registerViewProtocol:ZIKRoutableProtocol(ZIKTextWidgetViewProtocol)];
}

- (UIView *)destinationWithConfiguration:(ZIKViewRouteConfiguration *)configuration {
    //create your view, and initialize it with configuration
    ZIKTextView *destination = [[ZIKTextView alloc] init];
    
    return destination;
}

+ (BOOL)destinationPrepared:(ZIKTextView *)destination {
    if (destination.colorForCopyright == nil) {
        return NO;
    }
    return YES;
}

- (void)prepareDestination:(id)destination configuration:(__kindof ZIKViewRouteConfiguration *)configuration {
    NSParameterAssert([destination isKindOfClass:[ZIKTextView class]]);
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
    NSAssert([self isViperAssembled] == NO, @"Already assembled");
    ZIKTextWidgetViewPresenter *presenter = [[ZIKTextWidgetViewPresenter alloc] init];
    ZIKTextWidgetInteractor *interactor = [[ZIKTextWidgetInteractor alloc] init];
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
    return ZIKViewRouteTypeMaskUIViewDefault;
}

/*
 // Return your custom configuration
+ (ZIKViewRouteConfiguration *)defaultRouteConfiguration {
    return [[ZIKTextWidgetViewRouteConfiguration alloc] init];
}
 */

@end
