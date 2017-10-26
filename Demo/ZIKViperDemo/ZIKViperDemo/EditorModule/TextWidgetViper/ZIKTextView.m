//
//  ZIKTextView.m
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/17.
//  Copyright © 2017 zuik. All rights reserved.
//

#import "ZIKTextView.h"
#import <ZIKViper/ZIKViperViewPrivate.h>
#import "ZIKTextWidgetViewEventHandler.h"
#import <ZIKRouter/UIView+ZIKViewRouter.h>
#import "ZIKTextViewDataSource.h"

@interface ZIKTextView () <ZIKViperViewPrivate>
@property (nonatomic, strong) id<ZIKTextWidgetViewEventHandler> eventHandler;
@property (nonatomic, strong) id viewDataSource;
@property (nonatomic, copy) NSString *prefix;
@end

@implementation ZIKTextView

- (UIViewController *)routeSource {
    UIViewController *source = [self zix_firstAvailableUIViewController];
    if (source == nil) {
//        source = [UIApplication sharedApplication].delegate.window.rootViewController;
        NSAssert(NO, @"This UIView is not in any UIViewController. Should use app rootViewController ?");
    }
    return source;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    UIView *superview = self.superview;
    if (superview == nil) {
        if ([self.eventHandler respondsToSelector:@selector(handleViewRemoved)]) {
            [self.eventHandler handleViewRemoved];
        }
    }
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    [super willMoveToWindow:newWindow];
    if (newWindow != nil) {
        if (self.zix_routed == NO) {
            NSAssert([self.eventHandler conformsToProtocol:@protocol(ZIKTextWidgetViewEventHandler)], nil);
            if ([self.eventHandler respondsToSelector:@selector(handleViewReady)]) {
                [self.eventHandler handleViewReady];
            }
        }
        if ([self.eventHandler respondsToSelector:@selector(handleViewWillAppear:)]) {
            [self.eventHandler handleViewWillAppear:NO];
        };
    } else {
        if ([self.eventHandler respondsToSelector:@selector(handleViewWillDisappear:)]) {
            [self.eventHandler handleViewWillDisappear:NO];
        }
    }
}

- (void)didMoveToWindow {
    [super didMoveToWindow];
    UIWindow *window = self.window;
    if (window != nil) {
        if ([self.eventHandler respondsToSelector:@selector(handleViewDidAppear:)]) {
            [self.eventHandler handleViewDidAppear:NO];
        }
    } else {
        if ([self.eventHandler respondsToSelector:@selector(handleViewDidDisappear:)]) {
            [self.eventHandler handleViewDidDisappear:NO];
        }
    }
}

- (void)setPrefixText:(NSString *)prefix {
     NSString *text = self.text;
    self.prefix = prefix;
    if (text) {
        self.text = text;
    }
}

- (nullable NSString *)prefix {
    if ([self.dataSource respondsToSelector:@selector(prefixStringForTextView:)]) {
        NSString *addtion = [self.dataSource prefixStringForTextView:self];
        if (addtion) {
            return [_prefix stringByAppendingString:addtion];
        }
    }
    return _prefix;
}

///Add copyright for text
- (void)setText:(NSString *)text {
    if (self.prefix) {
        NSString *newText = [NSString stringWithFormat:@"%@\n%@",self.prefix,text];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:newText];
        UIColor *colorForCopyright = self.colorForCopyright;
        if (colorForCopyright == nil) {
            colorForCopyright = [UIColor blackColor];
        }
        [attributedString addAttribute:NSForegroundColorAttributeName value:colorForCopyright range:NSMakeRange(0, self.prefix.length)];
        [self setAttributedText:attributedString];
        return;
    }
    [super setText:text];
}

- (NSString *)text {
    NSString *newText = [super text];
    if (self.prefix == nil) {
        return newText;
    }
    return [newText substringFromIndex:self.prefix.length+1];
}

#pragma mark Route

/*
- (void)prepareDestinationFromExternal:(id)destination configuration:(__kindof ZIKViewRouteConfiguration *)configuration {
    if ([destination conformsToProtocol:@protocol(view-protocol)]) {
        //Prepare
        
        return;
    }
    NSAssert(NO, @"Can't prepare for unknown destination.");
}
*/

@end
