//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

#import "___VARIABLE_productName___Builder.h"
#import <ZIKTViper/ZIKTViperViewPrivate.h>
#import <ZIKTViper/ZIKTViperPresenterPrivate.h>
#import <ZIKTViper/ZIKTViperInteractorPrivate.h>
#import <ZIKTViper/ZIKTViperWireframePrivate.h>
#import <ZIKTViper/NSObject+ZIKTViperAssembly.h>

#import "___VARIABLE_productName___View.h"
#import "___VARIABLE_productName___ViewPresenter.h"
#import "___VARIABLE_productName___Wireframe.h"
#import "___VARIABLE_productName___RouterInput.h"
#import "___VARIABLE_productName___Interactor.h"
#import "___VARIABLE_productName___InteractorEventHandler.h"
#import "___VARIABLE_productName___InteractorDataSource.h"

@implementation ___VARIABLE_productName___BuilderBuilder

///Change this method, add your arguments for initializing the module
+ (UIView *)viewWithRouteSource:(nullable UIViewController *)routeSource router:(id<___VARIABLE_productName___RouterInput>)router {
#error create view
    ___VARIABLE_productName___View *view =;
    
    [self buildView:(id<ZIKTViperViewPrivate>)view
        routeSource:routeSource
             router:router];
    return view;
}

+ (void)buildView:(id<ZIKTViperViewPrivate>)view
      routeSource:(nullable UIViewController *)routeSource
           router:(id<___VARIABLE_productName___RouterInput>)router {
    NSParameterAssert([view isKindOfClass:[___VARIABLE_productName___View class]]);
    ___VARIABLE_productName___ViewPresenter *presenter = [[___VARIABLE_productName___ViewPresenter alloc] init];
    ___VARIABLE_productName___Interactor *interactor = [[___VARIABLE_productName___Interactor alloc] init];
    ___VARIABLE_productName___WireframeWireframe *wireframe = [[___VARIABLE_productName___WireframeWireframe alloc] init];
    
    if ([view respondsToSelector:@selector(setRouteSource:)]) {
        view.routeSource = routeSource;
    }
    [self assembleViperForView:view
                     presenter:(id<ZIKTViperPresenterPrivate>)presenter
                    interactor:(id<ZIKTViperInteractorPrivate>)interactor
                     wireframe:(id<ZIKTViperWireframePrivate>)wireframe
                        router:(id<ZIKTViperRouter>)router];
}

@end
