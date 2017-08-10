//
//  ZIKTEditorBuilder.m
//  ZIKTViperDemo
//
//  Created by zuik on 2017/8/2.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import "ZIKTEditorBuilder.h"
@import ZIKTViper;

#import "ZIKTEditorViewController.h"
#import "ZIKTEditorViewPresenter.h"
#import "ZIKTEditorInteractor.h"
#import "ZIKTEditorWireframe.h"

#import "ZIKTNoteModel.h"

@implementation ZIKTEditorBuilder

+ (UIViewController *)viewForCreatingNoteWithDelegate:(id<ZIKTEditorDelegate>)delegate router:(id<ZIKTViperRouter>)router {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ZIKTEditorViewController *view = [sb instantiateViewControllerWithIdentifier:@"ZIKTEditorViewController"];
    view.delegate = delegate;
    view.editMode = ZIKTEditorModeCreate;
    [self buildView:(id<ZIKTViperViewPrivate>)view note:nil router:router];
    return view;
}

+ (UIViewController *)viewForEditingNoteWithUUID:(NSString *)uuid title:(NSString *)title content:(NSString *)content delegate:(id<ZIKTEditorDelegate>)delegate router:(id<ZIKTViperRouter>)router {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ZIKTEditorViewController *view = [sb instantiateViewControllerWithIdentifier:@"ZIKTEditorViewController"];
    view.delegate = delegate;
    view.editMode = ZIKTEditorModeModify;
    ZIKTNoteModel *note = [[ZIKTNoteModel alloc] initWithUUID:uuid title:title content:content];
    [self buildView:(id<ZIKTViperViewPrivate>)view note:note router:router];
    return view;
}

+ (void)buildView:(id<ZIKTViperViewPrivate>)view note:(nullable ZIKTNoteModel *)note router:(id<ZIKTViperRouter>)router {
    ZIKTEditorViewPresenter *presenter = [[ZIKTEditorViewPresenter alloc] init];
    ZIKTEditorInteractor *interactor = [[ZIKTEditorInteractor alloc] initWithEditingNote:note];
    id<ZIKTViperWireframePrivate> wireframe = (id)[[ZIKTEditorWireframe alloc] init];
    
    [self assembleViperForView:view
                     presenter:(id<ZIKTViperPresenterPrivate>)presenter
                    interactor:(id<ZIKTViperInteractorPrivate>)interactor
                     wireframe:(id<ZIKTViperWireframePrivate>)wireframe
                        router:(id<ZIKTViperRouter>)router];
}

@end
