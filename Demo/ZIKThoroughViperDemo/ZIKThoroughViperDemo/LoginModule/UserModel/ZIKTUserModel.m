//
//  ZIKTUserModel.m
//  ZIKTViperDemo
//
//  Created by zuik on 2017/7/15.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import "ZIKTUserModel.h"

@interface ZIKTUserModel ()
@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *password;
@end

@implementation ZIKTUserModel
- (instancetype)initWithAccount:(NSString *)account password:(NSString *)password {
    if (self = [super init]) {
        _account = account;
        _password = password;
    }
    return self;
}

@end
