//
//  ZIKTextWidgetViewRouter.h
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/17.
//  Copyright © 2017 zuik. All rights reserved.
//

@import ZIKRouter;

NS_ASSUME_NONNULL_BEGIN

//define _ZIKTextWidgetViewProtocol_ in ZIKTextWidgetViewProtocol.h file, and use it like ZIKViewRouterForView(_ZIKTextWidgetViewProtocol_). If is not registered as routable protocol anymore, remember to remove macro _ZIKTextWidgetViewProtocol_
//#define _ZIKTextWidgetViewProtocol_ (Protocol<ZIKRoutableViewDynamicGetter> *)@protocol(ZIKTextWidgetViewProtocol)

DeclareRoutableViewProtocol(ZIKTextWidgetViewProtocol, ZIKTextWidgetViewRouter)

/*
 //define _ZIKTextWidgetConfigProtocol_ in ZIKTextWidgetConfigProtocol.h file, and use it like ZIKViewRouterForConfig(_ZIKTextWidgetConfigProtocol_). If is not registered as routable protocol anymore, remember to remove macro _ZIKTextWidgetConfigProtocol_
 //#define _ZIKTextWidgetConfigProtocol_ (Protocol<ZIKRoutableViewConfigDynamicGetter> *)@protocol(ZIKTextWidgetConfigProtocol)
 
 //Create ZIKTextWidgetConfigProtocol.h file for your configuration
 //DeclareRoutableViewProtocol(ZIKTextWidgetConfigProtocol, ZIKTextWidgetViewRouter)
 // if this viewController need custom arguments to initialize, use a custom view configuration to require those arguments
@interface ZIKTextWidgetViewRouteConfiguration : ZIKViewRouteConfiguration <NSCopying,ZIKTextWidgetConfigProtocol>
@property (nonatomic, strong) id argument;
@end
*/

@interface ZIKTextWidgetViewRouter : ZIKViewRouter <ZIKViewRouterProtocol>

@end

NS_ASSUME_NONNULL_END
