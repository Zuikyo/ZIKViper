//
//  ZIKTViperRouter.h
//  ZIKTViper
//
//  Created by zuik on 2017/5/31.
//  Copyright © 2017 zuik. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@protocol ZIKTViperView;
@protocol ZIKTViperPresenter;
@protocol ZIKTViperInteractor;

@protocol ZIKTViperRouter <NSObject>
+ (void)pushViewController:(UIViewController *)destination fromViewController:(UIViewController *)source animated:(BOOL)animated;
+ (void)popViewController:(UIViewController *)viewController animated:(BOOL)animated;
+ (void)presentViewController:(UIViewController *)viewControllerToPresent fromViewController:(UIViewController *)source animated:(BOOL)animated completion:(void (^ __nullable)(void))completion;
+ (void)dismissViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^ __nullable)(void))completion;
@end

NS_ASSUME_NONNULL_END
