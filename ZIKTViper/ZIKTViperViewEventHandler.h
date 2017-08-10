//
//  ZIKTViperViewEventHandler.h
//  ZIKTViper
//
//  Created by zuik on 2017/5/24.
//  Copyright © 2017 zuik. All rights reserved.
//

#import <Foundation/Foundation.h>

///Handle event from ZIKTViperView
@protocol ZIKTViperViewEventHandler <NSObject>

@optional
- (void)handleViewReady;
- (void)handleViewRemoved;
- (void)handleViewWillAppear:(BOOL)animated;
- (void)handleViewDidAppear:(BOOL)animated;
- (void)handleViewWillDisappear:(BOOL)animated;
- (void)handleViewDidDisappear:(BOOL)animated;

@end
