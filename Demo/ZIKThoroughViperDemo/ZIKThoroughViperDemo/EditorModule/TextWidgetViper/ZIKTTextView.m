//
//  ZIKTTextView.m
//  ZIKTViperDemo
//
//  Created by zuik on 2017/7/17.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import "ZIKTTextView.h"
@import ZIKTViper.ZIKTViperViewPrivate;
#import "ZIKTTextWidgetViewEventHandler.h"
#import "ZIKTTextViewDataSource.h"

@interface ZIKTTextView () <ZIKTViperViewPrivate>
@property (nonatomic, assign) BOOL appeared;
@property (nonatomic, strong) id<ZIKTTextWidgetViewEventHandler> eventHandler;
@property (nonatomic, strong) id viewDataSource;
@property (nonatomic, weak, nullable) UIViewController *routeSource;
@property (nonatomic, assign) BOOL ready;
@property (nonatomic, copy) NSString *prefix;
@end

@implementation ZIKTTextView

- (void)sendViewReadyEventIfNeed {
    if (self.ready == NO &&
        self.eventHandler != nil) {
        self.ready = YES;
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

@end
