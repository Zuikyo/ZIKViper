//
//  ZIKTLoginBuilder.h
//  ZIKthoroughViperDemo
//
//  Created by zuik on 2017/8/3.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZIKTLoginViewDelegate,ZIKTViperRouter;
@interface ZIKTLoginBuilder : NSObject
+ (UIViewController *)viewWithMessage:(NSString *)message delegate:(id<ZIKTLoginViewDelegate>)delegate router:(id<ZIKTViperRouter>)router;
@end
