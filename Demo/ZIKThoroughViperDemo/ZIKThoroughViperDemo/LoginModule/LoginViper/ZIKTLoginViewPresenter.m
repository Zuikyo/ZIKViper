//
//  ZIKTLoginViewPresenter.m
//  ZIKTViperDemo
//
//  Created by zuik on 2017/7/15.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import "ZIKTLoginViewPresenter.h"
@import ZIKTViper.ZIKTViperView;
@import ZIKTViper.ZIKTViperPresenterPrivate;

#import "ZIKTLoginViewProtocol.h"
#import "ZIKTLoginInteractorInput.h"
#import "ZIKTLoginViewWireframeInput.h"

@interface ZIKTLoginViewPresenter () <ZIKTViperPresenterPrivate>
@property (nonatomic, strong) id<ZIKTLoginViewWireframeInput> wireframe;
@property (nonatomic, weak) id<ZIKTViperView,ZIKTLoginViewProtocol> view;
@property (nonatomic, strong) id<ZIKTViperInteractor,ZIKTLoginInteractorInput> interactor;
@end

@implementation ZIKTLoginViewPresenter

- (void)handleViewReady {
    NSAssert(self.wireframe, @"Wireframe should be initlized when view is ready.");
    NSAssert([self.view conformsToProtocol:@protocol(ZIKTLoginViewProtocol)], @"Presenter should be attach to a view.");
    NSAssert([self.interactor conformsToProtocol:@protocol(ZIKTLoginInteractorInput)], @"Interactor should be initlized when view is ready.");
    
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

- (void)didTouchLoginButton {
    NSString *account = self.view.account;
    NSString *password = self.view.password;
    [self.interactor loginWithAccount:account password:password success:^{
        if ([self.view.delegate respondsToSelector:@selector(loginViewController:didLoginWithAccount:)]) {
            [self.view.delegate loginViewController:(UIViewController *)self.view didLoginWithAccount:account];
        }
    } error:^{
        
    }];
}
@end
