//
//  ZIKViewRouter+ZIKViper.m
//  ZIKViper
//
//  Created by zuik on 2017/6/15.
//  Copyright © 2017 zuik. All rights reserved.
//

#import "ZIKViewRouter+ZIKViper.h"
#import <ZIKRouter/ZIKRouter+Private.h>
#import "ZIKViperRouter.h"
#import "ZIKViperViewPrivate.h"
#import "ZIKViperPresenterPrivate.h"
#import "ZIKViperInteractorPrivate.h"

@implementation ZIKViewRouter (ZIKViper)

- (nullable ZIKViewRouter *)parentRouter {
    id parentRouter;
    id<ZIKViperPresenter> presenter = [(id)self presenter];
    id<ZIKViperView> view = presenter.view;
    if ([(id)view isKindOfClass:[UIView class]]) {
        parentRouter = [(id)view parentRouter];
    } else if ([(id)view isKindOfClass:[UIViewController class]]) {
        parentRouter = [(id)view parentRouter];
    } else {
        [[NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"view: %@ of presenter: %@ is not supported",view,presenter] userInfo:nil] raise];
    }
    return parentRouter;
}

- (BOOL)isViperAssembled {
    id<ZIKViperViewPrivate> view = self.destination;
    return [ZIKViewRouter isViperAssembledForView:view];
}

+ (BOOL)isViperAssembledForView:(id<ZIKViperViewPrivate>)view {
    NSAssert([view conformsToProtocol:@protocol(ZIKViperViewPrivate)], @"Only available when destination is ZIKViperView");
    if (![view conformsToProtocol:@protocol(ZIKViperViewPrivate)]) {
        return NO;
    }
    id viewEventHandler = [view eventHandler];
    if (!viewEventHandler) {
        return NO;
    }
    if ([view respondsToSelector:@selector(viewDataSource)]) {
        id viewDataSource = [view viewDataSource];
        if (!viewDataSource) {
            return NO;
        }
    }
    
    NSAssert2([viewEventHandler conformsToProtocol:@protocol(ZIKViperPresenterPrivate)], @"view(%@)'s eventHandler(%@) is not a presenter", view,viewEventHandler);
    id<ZIKViperPresenterPrivate> presenter = viewEventHandler;
    if (![presenter conformsToProtocol:@protocol(ZIKViperPresenterPrivate)]) {
        return NO;
    }
    id<ZIKViperInteractor> interactor = presenter.interactor;
    if (!interactor) {
        return NO;
    }
    if (!interactor.eventHandler ||
        !interactor.dataSource) {
        return NO;
    }
    return YES;
}

- (void)assembleViperForView:(id<ZIKViperViewPrivate>)view
                   presenter:(id<ZIKViperPresenterPrivate>)presenter
                  interactor:(id<ZIKViperInteractorPrivate>)interactor {
    NSParameterAssert([view conformsToProtocol:@protocol(ZIKViperViewPrivate)]);
    NSParameterAssert([presenter conformsToProtocol:@protocol(ZIKViperPresenterPrivate)]);
    NSParameterAssert([interactor conformsToProtocol:@protocol(ZIKViperInteractorPrivate)]);
    NSParameterAssert([ZIKViewRouter isViperAssembledForView:view] == NO);
    
    NSAssert3(interactor.eventHandler == nil, @"Interactor (%@)'s eventHandler (%@) already exists when assemble viper for new eventHandler", interactor, interactor.eventHandler,presenter);
    NSAssert3(interactor.dataSource == nil, @"Interactor (%@)'s dataSource (%@) already exists when assemble viper for new dataSource", interactor, interactor.dataSource,presenter);
    
    interactor.eventHandler = presenter;
    interactor.dataSource = presenter;
    
    NSAssert3(presenter.interactor == nil, @"Presenter (%@)'s interactor (%@) already exists when assemble viper for new interactor", presenter, presenter.interactor,interactor);
    NSAssert3(presenter.view == nil, @"Presenter (%@)'s view (%@) already exists when assemble viper for new view", presenter, presenter.view,view);
    NSAssert3(presenter.router == nil, @"Presenter (%@)'s router (%@) already exists when assemble viper for new router", presenter, presenter.router,self);
    
    presenter.interactor = interactor;
    presenter.view = view;
    presenter.router = self;
    
    if ([view respondsToSelector:@selector(viewDataSource)] &&
        [view respondsToSelector:@selector(setViewDataSource:)]) {
        NSAssert3(view.viewDataSource == nil, @"View (%@)'s viewDataSource (%@) already exists when assemble viper for new viewDataSource", view, view.viewDataSource,presenter);
        view.viewDataSource = presenter;
    }
    NSAssert3(view.eventHandler == nil, @"View (%@)'s eventHandler (%@) already exists when assemble viper for new eventHandler", view, view.eventHandler,presenter);
    view.eventHandler = presenter;
}

- (void)attachRouterForView:(id<ZIKViperViewPrivate>)view {
    NSParameterAssert(view);
    id<ZIKViperPresenterPrivate> presenter = (id)view.eventHandler;
    NSAssert2([presenter conformsToProtocol:@protocol(ZIKViperPresenterPrivate)], @"view (%@)'s evenHandler (%@) should be a ZIKViperPresenter",view,presenter);
    if ([presenter conformsToProtocol:@protocol(ZIKViperPresenterPrivate)]) {
        if (presenter.router != self) {
            presenter.router = self;
        }
    }
}

@end
