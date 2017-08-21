//
//  ___FILEBASENAMEASIDENTIFIER___ViewRouter.h
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

@import ZIKRouter;

NS_ASSUME_NONNULL_BEGIN

//define ____FILEBASENAME___ViewInput_ in ___FILEBASENAME___ViewInput.h file, and use it like ZIKViewRouterForView(____FILEBASENAME___ViewInput_). If is not registered as routable protocol anymore, remember to remove macro ____FILEBASENAME___ViewInput_
//#define ____FILEBASENAME___ViewInput_ (Protocol<ZIKViewRoutable> *)@protocol(___FILEBASENAME___ViewInput)

/*
 //define ____FILEBASENAME___ConfigProtocol_ in ___FILEBASENAME___ConfigProtocol.h file, and use it like ZIKViewRouterForConfig(____FILEBASENAME___ConfigProtocol_). If is not registered as routable protocol anymore, remember to remove macro ____FILEBASENAME___ConfigProtocol_
 //#define ____FILEBASENAME___ConfigProtocol_ (Protocol<ZIKViewConfigRoutable> *)@protocol(___FILEBASENAME___ConfigProtocol)
 
 //Create ___FILEBASENAME___ConfigProtocol.h file for your configuration
 // if this viewController need custom arguments to initialize, use a custom view configuration to require those arguments
@interface ___FILEBASENAMEASIDENTIFIER___ViewRouteConfiguration : ZIKViewRouteConfiguration <NSCopying,___FILEBASENAME___ConfigProtocol>
@property (nonatomic, strong) id argument;
@end
*/

@interface ___FILEBASENAMEASIDENTIFIER___ViewRouter : ZIKViewRouter <ZIKViewRouterProtocol>

@end

NS_ASSUME_NONNULL_END
