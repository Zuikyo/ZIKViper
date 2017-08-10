//
//  ZIKTLoginViewProtocol.h
//  ZIKTViperDemo
//
//  Created by zuik on 2017/7/15.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZIKTLoginViewDelegate.h"

NS_ASSUME_NONNULL_BEGIN

#define _ZIKTLoginViewProtocol_ (Protocol<ZIKTRoutableViewDynamicGetter> *)@protocol(ZIKTLoginViewProtocol)
@protocol ZIKTLoginViewProtocol <NSObject>
@property (nonatomic, weak) id<ZIKTLoginViewDelegate> delegate;
@property (nonatomic, copy, nullable) NSString *message;
- (nullable NSString *)account;
- (nullable NSString *)password;
@end

NS_ASSUME_NONNULL_END
