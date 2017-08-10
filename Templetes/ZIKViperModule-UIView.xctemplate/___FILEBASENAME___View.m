//
//  ___FILEBASENAME___View.m
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

#import "___FILEBASENAME___View.h"
#import <ZIKViper/ZIKViperViewPrivate.h>
#import <ZIKRouter/ZIKViewRouter.h>
#import <ZIKRouter/UIView+ZIKViewRouter.h>
#import "___FILEBASENAME___ViewEventHandler.h"
#import "___FILEBASENAME___ViewDataSource.h"

@interface ___FILEBASENAMEASIDENTIFIER___View () <ZIKViperViewPrivate>
@property (nonatomic, strong) id<___FILEBASENAME___ViewEventHandler> eventHandler;
@property (nonatomic, strong) id<___FILEBASENAME___ViewDataSource> viewDataSource;
@property (nonatomic, assign) BOOL ready;
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

- (void)setEventHandler:(id<___FILEBASENAME___ViewEventHandler>)eventHandler {
    _eventHandler = eventHandler;
    [self sendViewReadyEventIfNeed];
}

- (void)sendViewReadyEventIfNeed {
    if (self.ready == NO &&
        self.ZIK_routed == NO &&
        self.eventHandler != nil) {
        self.ready = YES;
        NSAssert([self.eventHandler conformsToProtocol:@protocol(___FILEBASENAME___ViewEventHandler)], nil);
        if ([self.eventHandler respondsToSelector:@selector(handleViewReady)]) {
            [self.eventHandler handleViewReady];
        }
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (newSuperview) {
        [self sendViewReadyEventIfNeed];
    }
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    if (self.superview == nil) {
        if ([self.eventHandler respondsToSelector:@selector(handleViewRemoved)]) {
            [self.eventHandler handleViewRemoved];
        }
        self.ready = NO;
    }
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    [super willMoveToWindow:newWindow];
    if (newWindow != nil) {
        [self sendViewReadyEventIfNeed];
        if ([self.eventHandler respondsToSelector:@selector(handleViewWillAppear:)]) {
            [self.eventHandler handleViewWillAppear:NO];
        };
        return;
    }
    if ([self.eventHandler respondsToSelector:@selector(handleViewWillDisappear:)]) {
        [self.eventHandler handleViewWillDisappear:NO];
    }
}

- (void)didMoveToWindow {
    [super didMoveToWindow];
    if (self.window != nil) {
        [self sendViewReadyEventIfNeed];
        if ([self.eventHandler respondsToSelector:@selector(handleViewDidAppear:)]) {
            [self.eventHandler handleViewDidAppear:NO];
        }
        return;
    }
    if ([self.eventHandler respondsToSelector:@selector(handleViewDidDisappear:)]) {
        [self.eventHandler handleViewDidDisappear:NO];
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
