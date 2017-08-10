//
//  ___FILEBASENAMEASIDENTIFIER___ViewPresenter.m
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

#import "___FILEBASENAME___ViewPresenter.h"
#import <ZIKTViper/ZIKTViperView.h>
#import <ZIKTViper/ZIKTViperWireframe.h>
#import <ZIKTViper/ZIKTViperInteractor.h>
#import <ZIKTViper/ZIKTViperPresenterPrivate.h>

#import "___FILEBASENAME___ViewInput.h"
#import "___FILEBASENAME___WireframeInput.h"
#import "___FILEBASENAME___InteractorInput.h"
#import "___FILEBASENAME___InteractorDataSource.h"
#import "___FILEBASENAME___InteractorEventHandler.h"

@interface ___FILEBASENAMEASIDENTIFIER___ViewPresenter () <ZIKTViperPresenterPrivate,___FILEBASENAME___InteractorDataSource,___FILEBASENAME___InteractorEventHandler>
@property (nonatomic, strong) id<ZIKTViperWireframe,___FILEBASENAME___WireframeInput> wireframe;
@property (nonatomic, weak) id<ZIKTViperView,___FILEBASENAME___ViewInput> view;
@property (nonatomic, strong) id<ZIKTViperInteractor,___FILEBASENAME___InteractorInput> interactor;
@end

@implementation ___FILEBASENAMEASIDENTIFIER___ViewPresenter

#pragma mark ZIKTViperViewEventHandler

- (void)handleViewReady {
    NSAssert(self.wireframe.view == self.view, @"Wireframe should be initlized when view is ready.");
    NSAssert([self.view conformsToProtocol:@protocol(___FILEBASENAME___ViewInput)], @"Presenter should be attach to a view.");
    NSAssert([self.interactor conformsToProtocol:@protocol(___FILEBASENAME___InteractorInput)], @"Interactor should be initlized when view is ready.");
    
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
