//
//  ZIKLoginServiceRouter.m
//  ZIKViperDemo
//
//  Created by zuik on 2017/8/9.
//  Copyright © 2017 zuik. All rights reserved.
//

#import "ZIKLoginServiceRouter.h"
#import "ZIKLoginService.h"

@interface ZIKLoginService (ZIKLoginServiceRouter) <ZIKRoutableService>
@end
@implementation ZIKLoginService (ZIKLoginServiceRouter)
@end

@implementation ZIKLoginServiceRouter

+ (void)registerRoutableDestination {
    ZIKServiceRouter_registerService([ZIKLoginService class], self);
    ZIKServiceRouter_registerServiceProtocol(@protocol(ZIKLoginServiceInput), self);
}

- (id)destinationWithConfiguration:(__kindof ZIKRouteConfiguration *)configuration {
    ZIKLoginService *destination = [ZIKLoginService sharedInstance];
    return destination;
}

@end
