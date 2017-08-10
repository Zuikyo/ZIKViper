//
//  ___FILEBASENAMEASIDENTIFIER___ViewPresenter.m
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

#import "___FILEBASENAME___ViewPresenter.h"
#import "ZIKViperView.h"
#import "ZIKViperPresenterPrivate.h"
#import "ZIKViewRouter.h"
#import "___FILEBASENAME___ViewProtocol.h"
#import "___FILEBASENAME___InteractorProtocol.h"
#import "___FILEBASENAME___InteractorDataSource.h"
#import "___FILEBASENAME___InteractorEventHandler.h"

@interface ___FILEBASENAMEASIDENTIFIER___ViewPresenter () <ZIKViperPresenterPrivate,___FILEBASENAME___InteractorDataSource,___FILEBASENAME___InteractorEventHandler>
@property (nonatomic, strong) ZIKViewRouter *router;
@property (nonatomic, weak) id<ZIKViperView,___FILEBASENAME___ViewProtocol> view;
@property (nonatomic, strong) id<ZIKViperInteractor,___FILEBASENAME___InteractorProtocol> interactor;
@end

@implementation ___FILEBASENAMEASIDENTIFIER___ViewPresenter

#pragma mark ZIKViperViewEventHandler

- (void)handleViewReady {
    NSAssert(self.router, @"Router should be initlized when view is ready.");
    NSAssert([self.view conformsToProtocol:@protocol(___FILEBASENAME___ViewProtocol)], @"Presenter should be attach to a view.");
    NSAssert([self.interactor conformsToProtocol:@protocol(___FILEBASENAME___InteractorProtocol)], @"Interactor should be initlized when view is ready.");
    
}

- (void)handleViewWillAppear:(BOOL)animated {
    
}

- (void)handleViewDidAppear:(BOOL)animated {
    
}

- (void)handleViewWillDisappear:(BOOL)animated {
    
}

- (void)handleViewDidDisappear:(BOOL)animated {
    
}

- (void)handleViewRemoved {
    
}

#pragma mark ___FILEBASENAME___InteractorDataSource

#pragma mark ___FILEBASENAME___InteractorEventHandler

@end
