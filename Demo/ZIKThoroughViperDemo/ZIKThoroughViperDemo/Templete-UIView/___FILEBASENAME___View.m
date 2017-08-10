//
//  ___FILEBASENAME___View.m
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

#import "___FILEBASENAME___View.h"
#import "ZIKViperViewPrivate.h"
#import "UIView+ZIKViewRouter.h"
#import "___FILEBASENAME___ViewEventHandler.h"

@interface ___FILEBASENAMEASIDENTIFIER___View () <ZIKViperViewPrivate>
@property (nonatomic, strong) id<ZIKViperPresenter,___FILEBASENAME___ViewEventHandler> presenter;
@end

@implementation ___FILEBASENAMEASIDENTIFIER___View

- (nullable UIViewController *)routeSource {
    UIViewController *source = [self ZIK_firstAvailableUIViewController];
    if (source == nil) {
//        source = [UIApplication sharedApplication].delegate.window.rootViewController;
        NSAssert(NO, @"This UIView is not in any UIViewController. Should use app rootViewController ?");
    }
    return source;
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    if (self.superview == nil) {
        if ([self.presenter respondsToSelector:@selector(handleViewRemoved)]) {
            [self.presenter handleViewRemoved];
        }
    }
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    [super willMoveToWindow:newWindow];
    if (newWindow != nil) {
        if (self.ZIK_routed == NO) {
            NSAssert([self.presenter conformsToProtocol:@protocol(___FILEBASENAME___ViewEventHandler)], nil);
            NSAssert(self.presenter.view == self, nil);
            if ([self.presenter respondsToSelector:@selector(handleViewReady)]) {
                [self.presenter handleViewReady];
            }
        }
        if ([self.presenter respondsToSelector:@selector(handleViewWillAppear:)]) {
            [self.presenter handleViewWillAppear:NO];
        };
        return;
    }
    if ([self.presenter respondsToSelector:@selector(handleViewWillDisappear:)]) {
        [self.presenter handleViewWillDisappear:NO];
    }
}

- (void)didMoveToWindow {
    [super didMoveToWindow];
    if (self.window != nil) {
        if ([self.presenter respondsToSelector:@selector(handleViewDidAppear:)]) {
            [self.presenter handleViewDidAppear:NO];
        }
        return;
    }
    if ([self.presenter respondsToSelector:@selector(handleViewDidDisappear:)]) {
        [self.presenter handleViewDidDisappear:NO];
    }
}

#pragma mark Route
/*
 ///Prepare sub vipers
 - (void)prepareForDestinationRoutingFromExternal:(id)destination configuration:(__kindof ZIKViewRouteConfiguration *)configuration {
     if ([destination conformsToProtocol:@protocol(view-protocol)]) {
         //Prepare
         return;
     }
     NSAssert(NO, @"Can't prepare for unknown destination.");
 }
 */

@end
