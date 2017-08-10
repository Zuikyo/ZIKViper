//
//  ZIKTLoginViewDelegate.h
//  ZIKTViperDemo
//
//  Created by zuik on 2017/7/15.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZIKTLoginViewDelegate <NSObject>
@optional
- (void)loginViewController:(UIViewController *)loginViewController didLoginWithAccount:(NSString *)account;
@end
