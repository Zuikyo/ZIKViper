//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

#import "___VARIABLE_productName___ViewPresenter.h"
#import <ZIKViper/ZIKViperView.h>
#import <ZIKViper/ZIKViperPresenterPrivate.h>
#import <ZIKRouter/ZIKViewRouter.h>
#import "___VARIABLE_productName___ViewInput.h"
#import "___VARIABLE_productName___InteractorInput.h"
#import "___VARIABLE_productName___InteractorDataSource.h"
#import "___VARIABLE_productName___InteractorEventHandler.h"

@interface ___VARIABLE_productName___ViewPresenter () <ZIKViperPresenterPrivate,___VARIABLE_productName___InteractorDataSource,___VARIABLE_productName___InteractorEventHandler>
@property (nonatomic, strong) ZIKViewRouter *router;
@property (nonatomic, weak) id<ZIKViperView,___VARIABLE_productName___ViewInput> view;
@property (nonatomic, strong) id<ZIKViperInteractor,___VARIABLE_productName___InteractorInput> interactor;
@end

@implementation ___VARIABLE_productName___ViewPresenter

#pragma mark ZIKViperViewEventHandler

- (void)handleViewReady {
    NSAssert(self.router, @"Router should be initlized when view is ready.");
    NSAssert([self.view conformsToProtocol:@protocol(___VARIABLE_productName___ViewInput)], @"Presenter should be attach to a view.");
    NSAssert([self.interactor conformsToProtocol:@protocol(___VARIABLE_productName___InteractorInput)], @"Interactor should be initlized when view is ready.");
    
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

#pragma mark ___VARIABLE_productName___InteractorDataSource

#pragma mark ___VARIABLE_productName___InteractorEventHandler

@end
