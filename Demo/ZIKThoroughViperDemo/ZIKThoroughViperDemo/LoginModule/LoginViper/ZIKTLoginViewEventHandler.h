//
//  ZIKTLoginViewEventHandler.h
//  ZIKTViperDemo
//
//  Created by zuik on 2017/7/15.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import <Foundation/Foundation.h>
@import ZIKTViper.ZIKTViperViewEventHandler;

NS_ASSUME_NONNULL_BEGIN

@protocol ZIKTLoginViewEventHandler <ZIKTViperViewEventHandler>
- (void)didTouchLoginButton;
@end

NS_ASSUME_NONNULL_END
