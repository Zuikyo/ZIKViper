//
//  ZIKTNoteListModuleBuilder.m
//  ZIKTViperDemo
//
//  Created by zuik on 2017/7/31.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import "ZIKTNoteListModuleBuilder.h"
@import ZIKTViper;

#import "ZIKTNoteListViewController.h"
#import "ZIKTNoteListViewPresenter.h"
#import "ZIKTNoteListInteractor.h"
#import "ZIKTNoteListDataService.h"
#import "ZIKTNoteListWireframe.h"
#import "ZIKTNoteListRouter.h"

@implementation ZIKTNoteListModuleBuilder

+ (UIViewController *)viewControllerWithNoteListDataService:(id<ZIKTNoteListDataService>)service router:(id<ZIKTNoteListRouter>)router {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *view = [sb instantiateViewControllerWithIdentifier:@"ZIKTNoteListViewController"];
    NSAssert([view isKindOfClass:[ZIKTNoteListViewController class]], nil);
    [self buildView:(id<ZIKTViperViewPrivate>)view noteListDataService:service router:router];
    return view;
}

+ (void)buildView:(id<ZIKTViperViewPrivate>)view noteListDataService:(id<ZIKTNoteListDataService>)service router:(id<ZIKTNoteListRouter>)router {
    NSParameterAssert([view isKindOfClass:[ZIKTNoteListViewController class]]);
    NSParameterAssert(service);
    
    ZIKTNoteListViewPresenter *presenter = [[ZIKTNoteListViewPresenter alloc] init];
    ZIKTNoteListInteractor *interactor = [[ZIKTNoteListInteractor alloc] initWithNoteListDataService:service];
    
    interactor.eventHandler = presenter;
    interactor.dataSource = presenter;
    
    id<ZIKTViperWireframePrivate> wireframe = (id)[[ZIKTNoteListWireframe alloc] init];
    NSAssert([wireframe conformsToProtocol:@protocol(ZIKTViperWireframePrivate)], nil);
    wireframe.view = view;
    wireframe.router = router;
    
    [(id<ZIKTViperPresenterPrivate>)presenter setView:view];
    [(id<ZIKTViperPresenterPrivate>)presenter setWireframe:wireframe];
    [(id<ZIKTViperPresenterPrivate>)presenter setInteractor:interactor];
    
    view.eventHandler = presenter;
    view.viewDataSource = presenter;
}

@end
