//
//  ZIKUserModel.h
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/15.
//  Copyright © 2017 zuik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZIKUserModel : NSObject
@property (nonatomic, readonly, copy) NSString *account;
@property (nonatomic, readonly, copy) NSString *password;
- (instancetype)initWithAccount:(NSString *)account password:(NSString *)password NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
@end
