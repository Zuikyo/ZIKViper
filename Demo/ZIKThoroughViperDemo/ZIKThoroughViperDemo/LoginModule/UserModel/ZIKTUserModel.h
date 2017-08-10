//
//  ZIKTUserModel.h
//  ZIKTViperDemo
//
//  Created by zuik on 2017/7/15.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZIKTUserModel : NSObject
@property (nonatomic, readonly, copy) NSString *account;
@property (nonatomic, readonly, copy) NSString *password;
- (instancetype)initWithAccount:(NSString *)account password:(NSString *)password NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
@end
