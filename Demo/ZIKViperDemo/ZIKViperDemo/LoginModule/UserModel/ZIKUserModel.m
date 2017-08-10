//
//  ZIKUserModel.m
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/15.
//  Copyright © 2017 zuik. All rights reserved.
//

#import "ZIKUserModel.h"

@interface ZIKUserModel ()
@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *password;
@end

@implementation ZIKUserModel
- (instancetype)initWithAccount:(NSString *)account password:(NSString *)password {
    if (self = [super init]) {
        _account = account;
        _password = password;
    }
    return self;
}

@end
