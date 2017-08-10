//
//  ZIKTRouter+ZIKTLogin.h
//  ZIKThoroughViperDemo
//
//  Created by zuik on 2017/8/3.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import "ZIKTRouter.h"

@protocol ZIKTLoginViewDelegate;
@interface ZIKTRouter (ZIKTLogin)
+ (UIViewController *)loginViewWithMessage:(NSString *)message delegate:(id<ZIKTLoginViewDelegate>)delegate;
@end
