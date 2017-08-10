//
//  ZIKTRouter.h
//  ZIKTViperDemo
//
//  Created by zuik on 2017/8/2.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import <UIKit/UIKit.h>
@import ZIKTViper.ZIKTViperRouter;

NS_ASSUME_NONNULL_BEGIN

@interface ZIKTRouter : NSObject <ZIKTViperRouter>
+ (void)pushViewController:(UIViewController *)destination fromViewController:(UIViewController *)source animated:(BOOL)animated;
+ (void)popViewController:(UIViewController *)viewController animated:(BOOL)animated;

+ (void)presentViewController:(UIViewController *)viewControllerToPresent fromViewController:(UIViewController *)source animated:(BOOL)animated completion:(void (^ __nullable)(void))completion;
+ (void)dismissViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^ __nullable)(void))completion;
@end

NS_ASSUME_NONNULL_END
