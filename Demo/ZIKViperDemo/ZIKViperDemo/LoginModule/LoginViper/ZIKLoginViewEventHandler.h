//
//  ZIKLoginViewEventHandler.h
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/15.
//  Copyright © 2017 zuik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ZIKViper/ZIKViperViewEventHandler.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZIKLoginViewEventHandler <ZIKViperViewEventHandler>
- (void)didTouchLoginButton;
@end

NS_ASSUME_NONNULL_END
