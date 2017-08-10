//
//  ___FILEBASENAMEASIDENTIFIER___ViewController.m
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

#import "___FILEBASENAME___ViewController.h"
#import "ZIKViperViewPrivate.h"
#import "UIViewController+ZIKViewRouter.h"
#import "___FILEBASENAME___ViewEventHandler.h"

@interface ___FILEBASENAMEASIDENTIFIER___ViewController () <ZIKViperViewPrivate>
@property (nonatomic, strong) id<ZIKViperPresenter,___FILEBASENAME___ViewEventHandler> presenter;
@end

@implementation ___FILEBASENAMEASIDENTIFIER___ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (UIViewController *)routeSource {
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.ZIK_routed == NO) {
        //Note: in -viewWillAppear:, if this view controller contains sub routable UIView added from external (addSubview:, storyboard or xib), it may not be ready yet. The UIView has to search the UIViewController with -nextResponder to prepare itself, nextResponder can only be gained after -willMoveToWindow:. But -willMoveToWindow: may not be called yet in -viewWillAppear:. If the subview is not ready, config the subview in -handleViewReady may fail. If you can make sure there is no sub routable UIView or the subview is added with router before -viewWillAppear:, you can do -handleViewReady in -viewWillAppear:.
        NSAssert([self.presenter conformsToProtocol:@protocol(___FILEBASENAME___ViewEventHandler)], nil);
        NSAssert(self.presenter.view == self, nil);
        if ([self.presenter respondsToSelector:@selector(handleViewReady)]) {
            [self.presenter handleViewReady];
        }
    }
    if ([self.presenter respondsToSelector:@selector(handleViewWillAppear:)]) {
        [self.presenter handleViewWillAppear:animated];
    };
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([self.presenter respondsToSelector:@selector(handleViewDidAppear:)]) {
        [self.presenter handleViewDidAppear:animated];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([self.presenter respondsToSelector:@selector(handleViewWillDisappear:)]) {
        [self.presenter handleViewWillDisappear:animated];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if ([self.presenter respondsToSelector:@selector(handleViewDidDisappear:)]) {
        [self.presenter handleViewDidDisappear:animated];
    }
    if (self.ZIK_routed == NO) {
        if ([self.presenter respondsToSelector:@selector(handleViewRemoved)]) {
            [self.presenter handleViewRemoved];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Route
/*
 ///Prepare sub vipers
- (void)prepareForDestinationRoutingFromExternal:(id)destination configuration:(__kindof ZIKViewRouteConfiguration *)configuration {
    if ([destination conformsToProtocol:@protocol(view-protocol)]) {
        //Prepare
        return;
    }
    NSAssert(NO, @"Can't prepare for unknown destination.");
}
*/
@end
