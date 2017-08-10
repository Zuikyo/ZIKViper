//
//  ZIKEditorViewPresenter
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/16.
//  Copyright © 2017 zuik. All rights reserved.
//

#import "ZIKEditorViewPresenter.h"
#import <ZIKViper/ZIKViperView.h>
#import <ZIKViper/ZIKViperPresenterPrivate.h>
@import ZIKRouter;
#import "ZIKEditorViewProtocol.h"
#import "ZIKEditorInteractorInput.h"
#import "ZIKEditorInteractorDataSource.h"
#import "ZIKEditorInteractorEventHandler.h"

#import "ZIKEditorDelegate.h"

@interface ZIKEditorViewPresenter () <ZIKViperPresenterPrivate,ZIKEditorInteractorDataSource,ZIKEditorInteractorEventHandler>
@property (nonatomic, strong) ZIKViewRouter *router;
@property (nonatomic, weak) id<ZIKViperView,ZIKEditorViewProtocol> view;
@property (nonatomic, strong) id<ZIKViperInteractor,ZIKEditorInteractorInput> interactor;
@end

@implementation ZIKEditorViewPresenter

#pragma mark ZIKViperViewEventHandler

- (void)handleViewReady {
    NSAssert(self.router, @"Router should be initlized when view is ready.");
    NSAssert([self.view conformsToProtocol:@protocol(ZIKEditorViewProtocol)], @"Presenter should be attach to a view.");
    NSAssert([self.interactor conformsToProtocol:@protocol(ZIKEditorInteractorInput)], @"Interactor should be initlized when view is ready.");
    
    if (self.view.editMode == ZIKEditorModeModify) {
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
    id<ZIKEditorDelegate> delegate = self.view.delegate;
    if ([delegate respondsToSelector:@selector(editor:didFinishEditNote:)]) {
        [delegate editor:(UIViewController *)self.view didFinishEditNote:[self.interactor currentEditingNote]];
    }
}

#pragma mark ZIKEditorInteractorDataSource

- (nullable NSString *)currentEditingNoteTitle {
    return [self.view titleString];
}

- (nullable NSString *)currentEditingNoteContent {
    return [self.view contentString];
}

#pragma mark ZIKTextViewDataSource

- (NSString *)prefixStringForTextView {
    return @" Demo for Viper by zuik.";
}

@end
