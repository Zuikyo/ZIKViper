//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

#import "___VARIABLE_productName___View.h"
#import <ZIKTViper/ZIKTViperViewPrivate.h>
#import "___VARIABLE_productName___ViewEventHandler.h"
#import "___VARIABLE_productName___ViewDataSource.h"

@interface ___VARIABLE_productName___View () <ZIKTViperViewPrivate>
@property (nonatomic, strong) id<___VARIABLE_productName___ViewEventHandler> eventHandler;
@property (nonatomic, strong) id<___VARIABLE_productName___ViewDataSource> viewDataSource;
@property (nonatomic, weak, nullable) UIViewController *routeSource;
@property (nonatomic, assign) BOOL ready;
@end

@implementation ___VARIABLE_productName___View

- (void)sendViewReadyEventIfNeed {
    if (self.ready == NO &&
        self.eventHandler != nil) {
        self.ready = YES;
        NSAssert([self.eventHandler conformsToProtocol:@protocol(___VARIABLE_productName___ViewEventHandler)], nil);
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

@end
