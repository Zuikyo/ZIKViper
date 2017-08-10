//
//  ZIKLoginService.m
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/15.
//  Copyright © 2017 zuik. All rights reserved.
//

#import "ZIKLoginService.h"
#import "ZIKUserModel.h"

@implementation ZIKLoginService

+ (instancetype)sharedInstance {
    static ZIKLoginService *shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [ZIKLoginService new];
    });
    return shared;
}

- (nullable ZIKUserModel *)loginedUser {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *account = [userDefault objectForKey:@"account"];
    NSString *password = [userDefault objectForKey:@"password"];
    if (account && password) {
        ZIKUserModel *user = [[ZIKUserModel alloc] initWithAccount:account password:password];
        return user;
    }
    return nil;
}

- (void)setLoginedUser:(ZIKUserModel *)user {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:user.account forKey:@"account"];
    [userDefault setObject:user.password forKey:@"password"];
    [userDefault synchronize];
}

- (void)loginWithAccount:(NSString *)account
                password:(NSString *)password
                 success:(void(^_Nullable)(void))successHandler
                   error:(void(^_Nullable)(void))errorHandler {
    if ([account isEqualToString:@"abc"] &&
        [password isEqualToString:@"123"]) {
        ZIKUserModel *user = [[ZIKUserModel alloc] initWithAccount:account password:password];
        [self setLoginedUser:user];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (successHandler) {
                successHandler();
            }
        });
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        if (errorHandler) {
            errorHandler();
        }
    });
}

@end
