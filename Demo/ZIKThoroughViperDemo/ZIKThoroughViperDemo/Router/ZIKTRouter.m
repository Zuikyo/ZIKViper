//
//  ZIKTRouter.m
//  ZIKTViperDemo
//
//  Created by zuik on 2017/8/2.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import "ZIKTRouter.h"

@implementation ZIKTRouter

+ (void)pushViewController:(UIViewController *)destination fromViewController:(UIViewController *)source animated:(BOOL)animated {
    NSParameterAssert([destination isKindOfClass:[UIViewController class]]);
    NSParameterAssert(source.navigationController);
    [source.navigationController pushViewController:destination animated:animated];
}

+ (void)popViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSParameterAssert(viewController.navigationController);
    [viewController.navigationController popViewControllerAnimated:animated];
}

+ (void)presentViewController:(UIViewController *)viewControllerToPresent fromViewController:(UIViewController *)source animated:(BOOL)animated completion:(void (^ __nullable)(void))completion {
    NSParameterAssert(viewControllerToPresent);
    NSParameterAssert(source);
    [source presentViewController:viewControllerToPresent animated:animated completion:completion];
}

+ (void)dismissViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^ __nullable)(void))completion {
    NSParameterAssert(viewController);
    [viewController dismissViewControllerAnimated:animated completion:completion];
}

@end
