//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

@import ZIKRouter;

NS_ASSUME_NONNULL_BEGIN

//define ___VARIABLE_productName___ViewInput_routable in ___VARIABLE_productName___ViewInput.h file, and use it like ZIKViewRouterForView(___VARIABLE_productName___ViewInput_routable). If is not registered as routable protocol anymore, remember to remove macro ___VARIABLE_productName___ViewInput_routable
//#define ___VARIABLE_productName___ViewInput_routable @protocol(___VARIABLE_productName___ViewInput)

/*
 //define ___VARIABLE_productName___ConfigInput_routable in ___VARIABLE_productName___ConfigInput.h file, and use it like ZIKViewRouterForConfig(___VARIABLE_productName___ConfigInput_routable). If is not registered as routable protocol anymore, remember to remove macro ___VARIABLE_productName___ConfigInput_routable
 //#define ___VARIABLE_productName___ConfigInput_routable @protocol(___VARIABLE_productName___ConfigInput)
 
 //Create ___VARIABLE_productName___ConfigInput.h file for your configuration
 // if this viewController need custom arguments to initialize, use a custom view configuration to require those arguments
 @interface ___VARIABLE_productName___ViewRouteConfiguration : ZIKViewRouteConfiguration <NSCopying,___VARIABLE_productName___ConfigInput>
 @property (nonatomic, strong) id argument;
 @end
 */

@interface ___VARIABLE_productName___ViewRouter : ZIKViewRouter <ZIKViewRouterProtocol>

@end

NS_ASSUME_NONNULL_END
