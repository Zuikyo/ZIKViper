//
//  ZIKLoginServiceRouter.m
//  ZIKViperDemo
//
//  Created by zuik on 2017/8/9.
//  Copyright © 2017 zuik. All rights reserved.
//

#import "ZIKLoginServiceRouter.h"
#import "ZIKLoginService.h"

RegisterRoutableService(ZIKLoginService, ZIKLoginServiceRouter)
RegisterRoutableServiceProtocol(ZIKLoginServiceInput, ZIKLoginServiceRouter)

@implementation ZIKLoginServiceRouter

- (id)destinationWithConfiguration:(__kindof ZIKRouteConfiguration *)configuration {
    ZIKLoginService *destination = [ZIKLoginService sharedInstance];
    return destination;
}

@end
