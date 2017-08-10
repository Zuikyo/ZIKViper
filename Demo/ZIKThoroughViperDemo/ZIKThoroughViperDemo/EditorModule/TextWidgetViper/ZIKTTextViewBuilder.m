//
//  ZIKTTextViewBuilder.m
//  ZIKthoroughViperDemo
//
//  Created by zuik on 2017/8/3.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import "ZIKTTextViewBuilder.h"
@import ZIKTViper;

#import "ZIKTTextView.h"
#import "ZIKTTextViewDataSource.h"
#import "ZIKTTextWidgetViewPresenter.h"
#import "ZIKTTextWidgetInteractor.h"
#import "ZIKTTextWidgetInteractorDataSource.h"
#import "ZIKTTextWidgetInteractorEventHandler.h"
#import "ZIKTTextViewWireframe.h"

@implementation ZIKTTextViewBuilder

+ (UIView *)viewWithPrefixText:(NSString *)prefix colorForCopyright:(UIColor *)color dataSource:(id<ZIKTTextViewDataSource>)dataSource router:(id<ZIKTViperRouter>)router {
    ZIKTTextView *view = [[ZIKTTextView alloc] init];
    view.dataSource = dataSource;
    [view setPrefixText:prefix];
    [self buildView:(id<ZIKTViperViewPrivate>)view router:router];
    return view;
}

+ (void)buildView:(id<ZIKTViperViewPrivate>)view router:(id<ZIKTViperRouter>)router {
    NSParameterAssert([view isKindOfClass:[ZIKTTextView class]]);
    ZIKTTextWidgetViewPresenter *presenter = [[ZIKTTextWidgetViewPresenter alloc] init];
    ZIKTTextWidgetInteractor *interactor = [[ZIKTTextWidgetInteractor alloc] init];
    id<ZIKTViperWireframePrivate> wireframe = (id)[[ZIKTTextViewWireframe alloc] init];
    
    [self assembleViperForView:view
                     presenter:(id<ZIKTViperPresenterPrivate>)presenter
                    interactor:(id<ZIKTViperInteractorPrivate>)interactor
                     wireframe:(id<ZIKTViperWireframePrivate>)wireframe
                        router:(id<ZIKTViperRouter>)router];
}

@end
