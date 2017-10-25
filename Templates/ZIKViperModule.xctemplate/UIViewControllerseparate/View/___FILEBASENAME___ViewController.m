//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

#import "___VARIABLE_productName___ViewController.h"
#import <ZIKViper/ZIKViperViewPrivate.h>
#import <ZIKRouter/ZIKViewRouter.h>
#import <ZIKRouter/UIViewController+ZIKViewRouter.h>
#import "___VARIABLE_productName___ViewEventHandler.h"
#import "___VARIABLE_productName___ViewDataSource.h"

@interface ___VARIABLE_productName___ViewController () <ZIKViperViewPrivate>
@property (nonatomic, strong) id<___VARIABLE_productName___ViewEventHandler> eventHandler;
@property (nonatomic, strong) id<___VARIABLE_productName___ViewDataSource> viewDataSource;
@end

@implementation ___VARIABLE_productName___ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (UIViewController *)routeSource {
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.zix_routed == NO) {
        //Note: in -viewWillAppear:, if this view controller contains sub routable UIView added from external (addSubview:, storyboard or xib), it may not be ready yet. The UIView has to search the UIViewController with -nextResponder to prepare itself, nextResponder can only be gained after -willMoveToWindow:. But -willMoveToWindow: may not be called yet in -viewWillAppear:. If the subview is not ready, config the subview in -handleViewReady may fail. If you can make sure there is no sub routable UIView or the subview is added with router before -viewWillAppear:, you can do -handleViewReady in -viewWillAppear:.
        NSAssert([self.eventHandler conformsToProtocol:@protocol(___VARIABLE_productName___ViewEventHandler)], nil);
        if ([self.eventHandler respondsToSelector:@selector(handleViewReady)]) {
            [self.eventHandler handleViewReady];
        }
    }
    if ([self.eventHandler respondsToSelector:@selector(handleViewWillAppear:)]) {
        [self.eventHandler handleViewWillAppear:animated];
    };
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([self.eventHandler respondsToSelector:@selector(handleViewDidAppear:)]) {
        [self.eventHandler handleViewDidAppear:animated];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([self.eventHandler respondsToSelector:@selector(handleViewWillDisappear:)]) {
        [self.eventHandler handleViewWillDisappear:animated];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if ([self.eventHandler respondsToSelector:@selector(handleViewDidDisappear:)]) {
        [self.eventHandler handleViewDidDisappear:animated];
    }
    if (self.zix_routed == NO) {
        if ([self.eventHandler respondsToSelector:@selector(handleViewRemoved)]) {
            [self.eventHandler handleViewRemoved];
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
