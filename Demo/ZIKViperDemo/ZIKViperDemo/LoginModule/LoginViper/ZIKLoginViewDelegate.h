//
//  ZIKLoginViewDelegate.h
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/15.
//  Copyright © 2017 zuik. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZIKLoginViewDelegate <NSObject>
@optional
- (void)loginViewController:(UIViewController *)loginViewController didLoginWithAccount:(NSString *)account;
@end
