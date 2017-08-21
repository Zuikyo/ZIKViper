//
//  ZIKNoteListViewRouter
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/16.
//  Copyright © 2017 zuik. All rights reserved.
//

#import "ZIKNoteListViewRouter.h"
@import ZIKRouter.Private;
#import <ZIKViper/ZIKViewRouter+ZIKViper.h>
#import <ZIKViper/ZIKViperViewPrivate.h>
#import "ZIKNoteListViewController.h"
#import "ZIKNoteListViewPresenter.h"
#import "ZIKNoteListInteractor.h"
#import "ZIKNoteListViewProtocol.h"

@interface ZIKNoteListViewController (ZIKNoteListViewRouter) <ZIKRoutableView>
@end
@implementation ZIKNoteListViewController (ZIKNoteListViewRouter)
@end

@interface ZIKNoteListViewRouter ()

@end

@implementation ZIKNoteListViewRouter

+ (void)registerRoutableDestination {
    ZIKViewRouter_registerViewForExclusiveRouter([ZIKNoteListViewController class], self);
    ZIKViewRouter_registerViewProtocol(@protocol(ZIKNoteListViewProtocol), self);
}

- (UIViewController *)destinationWithConfiguration:(ZIKViewRouteConfiguration *)configuration {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ZIKNoteListViewController *destination = [sb instantiateViewControllerWithIdentifier:@"ZIKNoteListViewController"];
    
    return destination;
}

+ (BOOL)destinationPrepared:(id)destination {
    NSParameterAssert([destination isKindOfClass:[ZIKNoteListViewController class]]);
    NSParameterAssert([destination conformsToProtocol:@protocol(ZIKViperViewPrivate)]);
    if (![ZIKViewRouter isViperAssembledForView:destination]) {
        return NO;
    }
    return YES;
}

- (void)prepareDestination:(id)destination configuration:(__kindof ZIKViewRouteConfiguration *)configuration {
    NSParameterAssert([destination isKindOfClass:[ZIKNoteListViewController class]]);
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
    ZIKNoteListViewPresenter *presenter = [[ZIKNoteListViewPresenter alloc] init];
    ZIKNoteListInteractor *interactor = [[ZIKNoteListInteractor alloc] init];
    NSParameterAssert([view conformsToProtocol:@protocol(ZIKViperViewPrivate)]);
    NSParameterAssert([presenter conformsToProtocol:@protocol(ZIKViperPresenterPrivate)]);
    NSParameterAssert([interactor conformsToProtocol:@protocol(ZIKViperInteractor)]);
    [self assembleViperForView:view
                     presenter:(id<ZIKViperPresenterPrivate>)presenter
                    interactor:interactor];
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

@end
