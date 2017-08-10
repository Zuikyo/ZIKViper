//
//  ZIKLoginInteractor.h
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/15.
//  Copyright © 2017 zuik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ZIKViper/ZIKViperInteractorPrivate.h>
#import "ZIKLoginInteractorInput.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZIKLoginInteractor : NSObject <ZIKViperInteractorPrivate, ZIKLoginInteractorInput>
@property (nonatomic, weak) id dataSource;
@property (nonatomic, weak) id eventHandler;
- (void)loginWithAccount:(NSString *)account
                password:(NSString *)password
                 success:(void(^_Nullable)(void))successHandler
                   error:(void(^_Nullable)(void))errorHandler;
@end

NS_ASSUME_NONNULL_END
