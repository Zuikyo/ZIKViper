//
//  ZIKLoginViewPresenter.m
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/15.
//  Copyright © 2017 zuik. All rights reserved.
//

#import "ZIKLoginViewPresenter.h"
#import <ZIKViper/ZIKViperView.h>
#import <ZIKViper/ZIKViperPresenterPrivate.h>
@import ZIKRouter;
#import "ZIKLoginViewProtocol.h"
#import "ZIKLoginInteractorInput.h"

@interface ZIKLoginViewPresenter () <ZIKViperPresenterPrivate>
@property (nonatomic, strong) ZIKViewRouter *router;
@property (nonatomic, weak) id<ZIKViperView,ZIKLoginViewProtocol> view;
@property (nonatomic, strong) id<ZIKViperInteractor,ZIKLoginInteractorInput> interactor;
@end

@implementation ZIKLoginViewPresenter

- (void)handleViewReady {
    NSAssert(self.router, @"Router should be initlized when view is ready.");
    NSAssert([self.view conformsToProtocol:@protocol(ZIKLoginViewProtocol)], @"Presenter should be attach to a view.");
    NSAssert([self.interactor conformsToProtocol:@protocol(ZIKLoginInteractorInput)], @"Interactor should be initlized when view is ready.");
    
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
        if ([self.router canRemove]) {
            [self.router removeRoute];
        }
    } error:^{
        
    }];
}
@end
