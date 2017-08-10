//
//  ZIKTLoginInteractor.h
//  ZIKTViperDemo
//
//  Created by zuik on 2017/7/15.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import <Foundation/Foundation.h>
@import ZIKTViper.ZIKTViperInteractor;
#import "ZIKTLoginInteractorInput.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZIKTLoginInteractor : NSObject <ZIKTViperInteractor, ZIKTLoginInteractorInput>
@property (nonatomic, weak) id dataSource;
@property (nonatomic, weak) id eventHandler;
- (void)loginWithAccount:(NSString *)account
                password:(NSString *)password
                 success:(void(^_Nullable)(void))successHandler
                   error:(void(^_Nullable)(void))errorHandler;
@end

NS_ASSUME_NONNULL_END
