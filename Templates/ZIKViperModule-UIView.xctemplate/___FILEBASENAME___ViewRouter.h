//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

@import ZIKRouter;

NS_ASSUME_NONNULL_BEGIN

//define ____VARIABLE_productName___ViewInput_ in ___VARIABLE_productName___ViewInput.h file, and use it like ZIKViewRouterForView(____VARIABLE_productName___ViewInput_). If is not registered as routable protocol anymore, remember to remove macro ____VARIABLE_productName___ViewInput_
//#define ____VARIABLE_productName___ViewInput_ (Protocol<ZIKViewRoutable> *)@protocol(___VARIABLE_productName___ViewInput)

/*
 //define ____VARIABLE_productName___ConfigProtocol_ in ___VARIABLE_productName___ConfigProtocol.h file, and use it like ZIKViewRouterForConfig(____VARIABLE_productName___ConfigProtocol_). If is not registered as routable protocol anymore, remember to remove macro ____VARIABLE_productName___ConfigProtocol_
 //#define ____VARIABLE_productName___ConfigProtocol_ (Protocol<ZIKViewConfigRoutable> *)@protocol(___VARIABLE_productName___ConfigProtocol)
 
 //Create ___VARIABLE_productName___ConfigProtocol.h file for your configuration
 // if this viewController need custom arguments to initialize, use a custom view configuration to require those arguments
 @interface ___VARIABLE_productName___ViewRouteConfiguration : ZIKViewRouteConfiguration <NSCopying,___VARIABLE_productName___ConfigProtocol>
 @property (nonatomic, strong) id argument;
 @end
 */

@interface ___VARIABLE_productName___ViewRouter : ZIKViewRouter <ZIKViewRouterProtocol>

@end

NS_ASSUME_NONNULL_END
