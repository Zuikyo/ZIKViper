//
//  ZIKTRouter+ZIKTLogin.m
//  ZIKThoroughViperDemo
//
//  Created by zuik on 2017/8/3.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import "ZIKTRouter+ZIKTLogin.h"
#import "ZIKTLoginBuilder.h"

@implementation ZIKTRouter (ZIKTLogin)
+ (UIViewController *)loginViewWithMessage:(NSString *)message delegate:(id<ZIKTLoginViewDelegate>)delegate {
    return [ZIKTLoginBuilder viewWithMessage:message delegate:delegate router:[self new]];
}
@end
