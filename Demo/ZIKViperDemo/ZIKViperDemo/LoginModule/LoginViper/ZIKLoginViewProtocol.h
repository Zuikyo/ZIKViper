//
//  ZIKLoginViewProtocol.h
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/15.
//  Copyright © 2017 zuik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZIKLoginViewDelegate.h"
@import ZIKRouter;

NS_ASSUME_NONNULL_BEGIN

@protocol ZIKLoginViewProtocol <ZIKViewRoutable>
@property (nonatomic, weak) id<ZIKLoginViewDelegate> delegate;
@property (nonatomic, copy, nullable) NSString *message;
- (nullable NSString *)account;
- (nullable NSString *)password;
@end

NS_ASSUME_NONNULL_END
