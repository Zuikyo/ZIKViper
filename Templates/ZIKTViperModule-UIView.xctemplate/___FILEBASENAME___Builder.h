//
//  ___FILEBASENAME___Builder.h
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZIKTViperViewPrivate,___FILEBASENAME___RouterInput;
@interface ___FILEBASENAME___BuilderBuilder : NSObject

///Change this method, add your arguments for initializing the module
+ (UIView *)viewWithRouteSource:(nullable UIViewController *)routeSource router:(id<___FILEBASENAME___RouterInput>)router;
+ (void)buildView:(id<ZIKTViperViewPrivate>)view
      routeSource:(nullable UIViewController *)routeSource
           router:(id<___FILEBASENAME___RouterInput>)router;

@end

NS_ASSUME_NONNULL_END
