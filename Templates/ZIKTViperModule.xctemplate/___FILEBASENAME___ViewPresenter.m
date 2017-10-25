//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

#import "___VARIABLE_productName___ViewPresenter.h"
#import <ZIKTViper/ZIKTViperView.h>
#import <ZIKTViper/ZIKTViperWireframe.h>
#import <ZIKTViper/ZIKTViperInteractor.h>
#import <ZIKTViper/ZIKTViperPresenterPrivate.h>

#import "___VARIABLE_productName___ViewInput.h"
#import "___VARIABLE_productName___WireframeInput.h"
#import "___VARIABLE_productName___InteractorInput.h"
#import "___VARIABLE_productName___InteractorDataSource.h"
#import "___VARIABLE_productName___InteractorEventHandler.h"

@interface ___VARIABLE_productName___ViewPresenter () <ZIKTViperPresenterPrivate,___VARIABLE_productName___InteractorDataSource,___VARIABLE_productName___InteractorEventHandler>
@property (nonatomic, strong) id<ZIKTViperWireframe,___VARIABLE_productName___WireframeInput> wireframe;
@property (nonatomic, weak) id<ZIKTViperView,___VARIABLE_productName___ViewInput> view;
@property (nonatomic, strong) id<ZIKTViperInteractor,___VARIABLE_productName___InteractorInput> interactor;
@end

@implementation ___VARIABLE_productName___ViewPresenter

#pragma mark ZIKTViperViewEventHandler

- (void)handleViewReady {
    NSAssert(self.wireframe.view == self.view, @"Wireframe should be initlized when view is ready.");
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
