//
//  ZIKTLoginInteractor.m
//  ZIKTViperDemo
//
//  Created by zuik on 2017/7/15.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import "ZIKTLoginInteractor.h"
@import ZIKTViper.ZIKTViperInteractorPrivate;
#import "ZIKTLoginService.h"

@interface ZIKTLoginInteractor () <ZIKTViperInteractorPrivate>

@end

@implementation ZIKTLoginInteractor

- (void)loginWithAccount:(NSString *)account
                password:(NSString *)password
                 success:(void(^_Nullable)(void))successHandler
                   error:(void(^_Nullable)(void))errorHandler {
    [[ZIKTLoginService sharedInstance] loginWithAccount:account password:password success:successHandler error:errorHandler];
}

@end
