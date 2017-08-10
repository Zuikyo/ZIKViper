//
//  ZIKTNoteListWireframe.m
//  ZIKTViperDemo
//
//  Created by zuik on 2017/7/24.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
@import ZIKTViper.ZIKTViperWireframePrivate;
#import "ZIKTNoteListWireframe.h"
#import "ZIKTNoteListViewController.h"
#import "ZIKTNoteListViewPresenter.h"
#import "ZIKTNoteListInteractor.h"
#import "ZIKTNoteListModuleBuilder.h"
#import "ZIKTNoteListRouter.h"

#import "ZIKTEditorWireframeInput.h"

@interface ZIKTNoteListWireframe () <ZIKTViperWireframePrivate>
@property (nonatomic, weak) id<ZIKTViperView> view;
@property (nonatomic, strong) id<ZIKTNoteListRouter> router;
@property (nonatomic, weak) UIViewController *editor;
@property (nonatomic, assign) BOOL presentingEditor;
@property (nonatomic, assign) BOOL pushedEditor;
@end

@implementation ZIKTNoteListWireframe

- (void)presentLoginViewWithMessage:(NSString *)message delegate:(id<ZIKTLoginViewDelegate>)delegate completion:(void (^ __nullable)(void))completion {
    UIViewController *loginViewController = [[self.router class] loginViewWithMessage:message delegate:delegate];
    
    [[self.router class] presentViewController:loginViewController fromViewController:self.view.routeSource animated:YES completion:completion];
}

- (void)dismissLoginView:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^ __nullable)(void))completion {
    [viewController dismissViewControllerAnimated:animated completion:completion];
}

- (void)presentEditorForCreatingNewNoteWithDelegate:(id<ZIKTEditorDelegate>)delegate completion:(void (^ __nullable)(void))completion {
    UIViewController *editorViewController = [[self.router class] viewForCreatingNoteWithDelegate:delegate];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:editorViewController];
    [[self.router class] presentViewController:navigationController fromViewController:self.view.routeSource animated:YES completion:completion];
    [self resetState];
    self.editor = editorViewController;
    self.presentingEditor = YES;
}

- (void)pushEditorViewForEditingNoteWithUUID:(NSString *)uuid title:(NSString *)title content:(NSString *)content delegate:(id<ZIKTEditorDelegate>)delegate {
    UIViewController *editorViewController = [[self.router class] viewForEditingNoteWithUUID:uuid title:title content:content delegate:delegate];
    [[self.router class] pushViewController:editorViewController fromViewController:self.view.routeSource animated:YES];
    [self resetState];
    self.editor = editorViewController;
    self.pushedEditor = YES;
}

- (UIViewController *)editorViewForEditingNoteWithUUID:(NSString *)uuid title:(NSString *)title content:(NSString *)content delegate:(id<ZIKTEditorDelegate>)delegate {
    UIViewController *editorViewController = [[self.router class] viewForEditingNoteWithUUID:uuid title:title content:content delegate:delegate];
    return editorViewController;
}

- (void)quitEditorViewWithAnimated:(BOOL)animated {
    NSAssert(self.editor, @"Didn't show any editor");
    NSAssert(self.presentingEditor || self.pushedEditor, @"Editor was not presented or pushed");
    if (self.presentingEditor) {
        self.presentingEditor = NO;
        [[self.router class] dismissViewController:self.editor animated:animated completion:nil];
    } else if (self.pushedEditor) {
        self.pushedEditor = NO;
        [[self.router class] popViewController:self.editor animated:animated];
    }
}

- (void)pushEditorViewController:(UIViewController *)destination fromViewController:(UIViewController *)source animated:(BOOL)animated {
    [[self.router class] pushViewController:destination fromViewController:source animated:YES];
    [self resetState];
    self.editor = destination;
    self.pushedEditor = YES;
}

- (void)resetState {
    self.editor = nil;
    self.presentingEditor = NO;
    self.pushedEditor = NO;
}

@end
