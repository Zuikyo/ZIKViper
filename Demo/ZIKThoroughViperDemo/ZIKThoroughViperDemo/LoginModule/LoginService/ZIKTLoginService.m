//
//  ZIKTLoginService.m
//  ZIKTViperDemo
//
//  Created by zuik on 2017/7/15.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import "ZIKTLoginService.h"
#import "ZIKTUserModel.h"

@implementation ZIKTLoginService

+ (instancetype)sharedInstance {
    static ZIKTLoginService *shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [ZIKTLoginService new];
    });
    return shared;
}

- (nullable ZIKTUserModel *)loginedUser {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *account = [userDefault objectForKey:@"account"];
    NSString *password = [userDefault objectForKey:@"password"];
    if (account && password) {
        ZIKTUserModel *user = [[ZIKTUserModel alloc] initWithAccount:account password:password];
        return user;
    }
    return nil;
}

- (void)setLoginedUser:(ZIKTUserModel *)user {
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
        ZIKTUserModel *user = [[ZIKTUserModel alloc] initWithAccount:account password:password];
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
