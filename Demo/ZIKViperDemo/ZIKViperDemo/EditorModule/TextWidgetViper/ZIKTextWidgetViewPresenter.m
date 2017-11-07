//
//  ZIKTextWidgetViewPresenter.m
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/17.
//  Copyright © 2017 zuik. All rights reserved.
//

#import "ZIKTextWidgetViewPresenter.h"
#import <ZIKViper/ZIKViperView.h>
#import <ZIKViper/ZIKViperPresenterPrivate.h>
@import ZIKRouter;
#import "ZIKTextWidgetViewProtocol.h"
#import "ZIKTextWidgetInteractorInput.h"
#import "ZIKTextWidgetInteractorDataSource.h"
#import "ZIKTextWidgetInteractorEventHandler.h"

#import "ZIKLoginViewProtocol.h"

@interface ZIKTextWidgetViewPresenter () <ZIKViperPresenterPrivate,ZIKTextWidgetInteractorDataSource,ZIKTextWidgetInteractorEventHandler,ZIKLoginViewDelegate>
@property (nonatomic, strong) ZIKViewRouter *router;
@property (nonatomic, weak) id<ZIKViperView,ZIKTextWidgetViewProtocol> view;
@property (nonatomic, strong) id<ZIKViperInteractor,ZIKTextWidgetInteractorInput> interactor;
@end

@implementation ZIKTextWidgetViewPresenter

#pragma mark ZIKViperViewEventHandler

- (void)handleViewReady {
    NSAssert(self.router, @"Router should be initlized when view is ready.");
    NSAssert([self.view conformsToProtocol:@protocol(ZIKTextWidgetViewProtocol)], @"Presenter should be attach to a view.");
    NSAssert([self.interactor conformsToProtocol:@protocol(ZIKTextWidgetInteractorInput)], @"Interactor should be initlized when view is ready.");
    
    [self.view setPrefixText:[self.interactor copyrightDescription]];
}

- (void)handleViewWillAppear:(BOOL)animated {
    
}

- (void)handleViewDidAppear:(BOOL)animated {
    if (self.view.dataSource.previewing == YES) {
        return;
    }
    if ([self.interactor needValidateAccount]) {
        __weak typeof(self) weakSelf = self;
        UIViewController *source = self.view.routeSource;
        NSAssert(source != nil, @"source is nil, UIView is not in any UIViewController, can't route from this UIView.");
        
        //UIView 's handleViewDidAppear: from -didMoveToWindow is not accurate, the view may not be displayed yet, still in will appear, so present another view controller may failed.
        [ZIKViewRouter.toView(ZIKLoginViewProtocol_routable)
         performWithConfiguring:^(ZIKViewRouteConfiguration * _Nonnull config) {
             config.source = source;
             config.routeType = ZIKViewRouteTypePresentModally;
             config.prepareForRoute = ^(id<ZIKLoginViewProtocol> _Nonnull destination) {
                 destination.delegate = weakSelf;
                 destination.message = @"Login in to edit this note";
             };
             config.errorHandler = ^(SEL  _Nonnull routeAction, NSError * _Nonnull error) {
                 
             };
        }];
    }
}

- (void)handleViewWillDisappear:(BOOL)animated {
    
}

- (void)handleViewDidDisappear:(BOOL)animated {
    
}

- (void)handleViewRemoved {
    
}

#pragma mark ZIKLoginViewDelegate

- (void)loginViewController:(UIViewController *)loginViewController didLoginWithAccount:(NSString *)account {
    [self.interactor didLoginedWithAccount:account];
}

#pragma mark ZIKTextWidgetInteractorDataSource

#pragma mark ZIKTextWidgetInteractorEventHandler

@end
