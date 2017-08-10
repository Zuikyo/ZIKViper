//
//  UIApplication+ZIKTViperRouter.m
//  ZIKTViperDemo
//
//  Created by zuik on 2017/8/2.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import "UIApplication+ZIKTViperRouter.h"
#import "ZIKTRouter.h"

@implementation UIApplication (ZIKTViperRouter)

- (ZIKTRouter *)ZIKT_router {
    return [ZIKTRouter new];
}

@end
