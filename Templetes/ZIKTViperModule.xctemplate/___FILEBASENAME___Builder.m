//
//  ___FILEBASENAME___Builder.m
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

#import "___FILEBASENAME___Builder.h"
#import <ZIKTViper/ZIKTViperViewPrivate.h>
#import <ZIKTViper/ZIKTViperPresenterPrivate.h>
#import <ZIKTViper/ZIKTViperInteractorPrivate.h>
#import <ZIKTViper/ZIKTViperWireframePrivate.h>
#import <ZIKTViper/NSObject+ZIKTViperAssembly.h>

#import "___FILEBASENAME___ViewController.h"
#import "___FILEBASENAME___ViewPresenter.h"
#import "___FILEBASENAME___Wireframe.h"
#import "___FILEBASENAME___RouterInput.h"
#import "___FILEBASENAME___Interactor.h"
#import "___FILEBASENAME___InteractorEventHandler.h"
#import "___FILEBASENAME___InteractorDataSource.h"

@implementation ___FILEBASENAME___BuilderBuilder

+ (UIViewController *)viewControllerWithRouter:(id<___FILEBASENAME___RouterInput>)router {
#error create view
    ___FILEBASENAMEASIDENTIFIER___ViewController *view =;
    
    [self buildView:(id<ZIKTViperViewPrivate>)view router:router];
    return view;
}

+ (void)buildView:(id<ZIKTViperViewPrivate>)view router:(id<___FILEBASENAME___RouterInput>)router {
    NSParameterAssert([view isKindOfClass:[___FILEBASENAMEASIDENTIFIER___ViewController class]]);
    ___FILEBASENAMEASIDENTIFIER___ViewPresenter *presenter = [[___FILEBASENAMEASIDENTIFIER___ViewPresenter alloc] init];
    ___FILEBASENAMEASIDENTIFIER___Interactor *interactor = [[___FILEBASENAMEASIDENTIFIER___Interactor alloc] init];
    ___FILEBASENAMEASIDENTIFIER___WireframeWireframe *wireframe = [[___FILEBASENAMEASIDENTIFIER___WireframeWireframe alloc] init];
    
    [self assembleViperForView:view
                     presenter:(id<ZIKTViperPresenterPrivate>)presenter
                    interactor:(id<ZIKTViperInteractorPrivate>)interactor
                     wireframe:(id<ZIKTViperWireframePrivate>)wireframe
                        router:(id<ZIKTViperRouter>)router];
}

@end
