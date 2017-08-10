//
//  ZIKTEditorViewPresenter
//  ZIKTViperDemo
//
//  Created by zuik on 2017/7/16.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import "ZIKTEditorViewPresenter.h"
@import ZIKTViper.ZIKTViperView;
@import ZIKTViper.ZIKTViperPresenterPrivate;

#import "ZIKTEditorViewProtocol.h"
#import "ZIKTEditorInteractorInput.h"
#import "ZIKTEditorInteractorDataSource.h"
#import "ZIKTEditorInteractorEventHandler.h"
#import "ZIKTEditorWireframeInput.h"

#import "ZIKTEditorDelegate.h"

@interface ZIKTEditorViewPresenter () <ZIKTViperPresenterPrivate,ZIKTEditorInteractorDataSource,ZIKTEditorInteractorEventHandler>
@property (nonatomic, strong) id<ZIKTEditorWireframeInput> wireframe;
@property (nonatomic, weak) id<ZIKTViperView,ZIKTEditorViewProtocol> view;
@property (nonatomic, strong) id<ZIKTViperInteractor,ZIKTEditorInteractorInput> interactor;
@end

@implementation ZIKTEditorViewPresenter

#pragma mark ZIKTViperViewEventHandler

- (void)handleViewReady {
    NSAssert(self.wireframe, @"Wireframe should be initlized when view is ready.");
    NSAssert([self.view conformsToProtocol:@protocol(ZIKTEditorViewProtocol)], @"Presenter should be attach to a view.");
    NSAssert([self.interactor conformsToProtocol:@protocol(ZIKTEditorInteractorInput)], @"Interactor should be initlized when view is ready.");
    
    if (self.view.editMode == ZIKTEditorModeModify) {
        [self.view updateTitleString:[self.interactor currentEditingNoteTitle]];
        [self.view updateContentString:[self.interactor currentEditingNoteContent]];
    }
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

- (void)didTouchNavigationBarDoneButton {
    [self.interactor storeCurrentEditingNote];
    id<ZIKTEditorDelegate> delegate = self.view.delegate;
    if ([delegate respondsToSelector:@selector(editor:didFinishEditNote:)]) {
        [delegate editor:(UIViewController *)self.view didFinishEditNote:[self.interactor currentEditingNote]];
    }
}

- (id<ZIKTViperRouter>)router {
    return self.wireframe.router;
}

#pragma mark ZIKTEditorInteractorDataSource

- (nullable NSString *)currentEditingNoteTitle {
    return [self.view titleString];
}

- (nullable NSString *)currentEditingNoteContent {
    return [self.view contentString];
}

#pragma mark ZIKTTextViewDataSource

- (NSString *)prefixStringForTextView {
    return @" Demo for Viper by zuik.";
}

@end
