//
//  ZIKTLoginBuilder.m
//  ZIKthoroughViperDemo
//
//  Created by zuik on 2017/8/3.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import "ZIKTLoginBuilder.h"
@import ZIKTViper;

#import "ZIKTLoginViewController.h"
#import "ZIKTLoginViewPresenter.h"
#import "ZIKTLoginInteractor.h"
#import "ZIKTLoginViewWireframe.h"

@implementation ZIKTLoginBuilder
+ (UIViewController *)viewWithMessage:(NSString *)message delegate:(id<ZIKTLoginViewDelegate>)delegate router:(id<ZIKTViperRouter>)router {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ZIKTLoginViewController *view = [sb instantiateViewControllerWithIdentifier:@"ZIKTLoginViewController"];
    view.delegate = delegate;
    view.message = message;
    [self buildView:(id<ZIKTViperViewPrivate>)view router:router];
    return view;
}

+ (void)buildView:(id<ZIKTViperViewPrivate>)view router:(id<ZIKTViperRouter>)router {
    ZIKTLoginViewPresenter *presenter = [[ZIKTLoginViewPresenter alloc] init];
    ZIKTLoginInteractor *interactor = [[ZIKTLoginInteractor alloc] init];
    id<ZIKTViperWireframePrivate> wireframe = (id)[[ZIKTLoginViewWireframe alloc] init];
    
    [self assembleViperForView:view
                     presenter:(id<ZIKTViperPresenterPrivate>)presenter
                    interactor:(id<ZIKTViperInteractorPrivate>)interactor
                     wireframe:(id<ZIKTViperWireframePrivate>)wireframe
                        router:(id<ZIKTViperRouter>)router];
}
@end
