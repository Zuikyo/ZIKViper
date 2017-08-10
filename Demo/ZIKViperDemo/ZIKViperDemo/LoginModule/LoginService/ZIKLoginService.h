//
//  ZIKLoginService.h
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/15.
//  Copyright © 2017 zuik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZIKLoginServiceInput.h"

NS_ASSUME_NONNULL_BEGIN

@class ZIKUserModel;
@interface ZIKLoginService : NSObject <ZIKLoginServiceInput>
+ (instancetype)sharedInstance;
- (nullable ZIKUserModel *)loginedUser;
- (void)loginWithAccount:(NSString *)account
                password:(NSString *)password
              success:(void(^_Nullable)(void))successHandler
                error:(void(^_Nullable)(void))errorHandler;
@end

NS_ASSUME_NONNULL_END
