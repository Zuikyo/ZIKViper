//
//  ZIKTNoteListViewPresenter
//  ZIKTViperDemo
//
//  Created by zuik on 2017/7/16.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import "ZIKTNoteListViewPresenter.h"
@import ZIKTViper.ZIKTViperView;
@import ZIKTViper.ZIKTViperPresenterPrivate;
#import "ZIKTNoteListWireframeInput.h"
#import "ZIKTNoteListViewProtocol.h"
#import "ZIKTNoteListInteractorInput.h"

#import "ZIKTLoginViewProtocol.h"
#import "ZIKTEditorDelegate.h"

@interface ZIKTNoteListViewPresenter () <ZIKTViperPresenterPrivate,ZIKTEditorDelegate,ZIKTLoginViewDelegate>
@property (nonatomic, strong) id<ZIKTNoteListWireframeInput> wireframe;
@property (nonatomic, weak) id<ZIKTViperView,ZIKTNoteListViewProtocol> view;
@property (nonatomic, strong) id<ZIKTViperInteractor,ZIKTNoteListInteractorInput> interactor;

@property (nonatomic, assign) BOOL logined;
@end

@implementation ZIKTNoteListViewPresenter

#pragma mark ZIKTViperViewEventHandler

- (void)handleViewReady {
    NSAssert(self.wireframe, @"Router should be initlized when view is ready.");
    NSAssert([self.view conformsToProtocol:@protocol(ZIKTNoteListViewProtocol)], @"Presenter should be attach to a view.");
    NSAssert([self.interactor conformsToProtocol:@protocol(ZIKTNoteListInteractorInput)], @"Interactor should be initlized when view is ready.");
    [self.interactor loadAllNotes];
}

- (void)handleViewWillAppear:(BOOL)animated {
    
}

- (void)handleViewDidAppear:(BOOL)animated {
    if (self.logined == NO) {
        [self.wireframe presentLoginViewWithMessage:@"Login in to use this app" delegate:self completion:nil];
    }
}

- (void)handleViewWillDisappear:(BOOL)animated {
    
}

- (void)handleViewDidDisappear:(BOOL)animated {
    
}

- (void)handleViewRemoved {
    
}

- (void)didTouchNavigationBarAddButton {
    [self.wireframe presentEditorForCreatingNewNoteWithDelegate:self completion:nil];
}

#pragma mark ZIKTNoteListViewDataSource

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return self.interactor.noteCount;
}

- (NSString *)textOfCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = [self.interactor titleForNoteAtIndex:indexPath.row];
    return title;
}

- (NSString *)detailTextOfCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *content = [self.interactor contentForNoteAtIndex:indexPath.row];
    return content;
}

#pragma mark ZIKTNoteListViewEventHandler

- (BOOL)canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)handleDeleteCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.interactor deleteNoteAtIndex:indexPath.row];
}

- (void)handleDidSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *uuid = [self.interactor noteUUIDAtIndex:indexPath.row];
    NSString *title = [self.interactor noteTitleAtIndex:indexPath.row];
    NSString *content = [self.interactor noteContentAtIndex:indexPath.row];
    
    [self.wireframe pushEditorViewForEditingNoteWithUUID:uuid title:title content:content delegate:self];
}

#pragma mark ZIKTLoginViewDelegate

- (void)loginViewController:(UIViewController *)loginViewController didLoginWithAccount:(NSString *)account {
    self.logined = YES;
    [self.wireframe dismissLoginView:loginViewController animated:YES completion:nil];
}

#pragma mark ZIKTEditorDelegate

- (void)editor:(UIViewController *)editor didFinishEditNote:(ZIKTNoteModel *)note {
    [self.wireframe quitEditorViewWithAnimated:YES];
    [self.view.noteListTableView reloadData];
}

#pragma mark UIViewControllerPreviewingDelegate

- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    __block UIViewController *destinationViewController;
    NSIndexPath *indexPath = [self.view.noteListTableView indexPathForRowAtPoint:location];
    
    NSString *uuid = [self.interactor noteUUIDAtIndex:indexPath.row];
    NSString *title = [self.interactor noteTitleAtIndex:indexPath.row];
    NSString *content = [self.interactor noteContentAtIndex:indexPath.row];
    destinationViewController = [self.wireframe editorViewForEditingNoteWithUUID:uuid title:title content:content delegate:self];
    NSAssert(destinationViewController != nil, nil);
    return destinationViewController;
}

- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    [self.wireframe pushEditorViewController:viewControllerToCommit fromViewController:self.view.routeSource animated:YES];
}

@end
